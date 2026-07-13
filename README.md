# Karpenter on Amazon EKS — Production-Ready Setup Guide

## 📌 Overview

This guide demonstrates how to deploy and configure Karpenter on an Amazon EKS cluster using:

- IRSA (IAM Roles for Service Accounts)
- Private or Public EKS Cluster
- Spot + On-Demand Provisioning
- NodePool & EC2NodeClass
- Production-Grade Scaling Practices

---

# 🚀 What is Karpenter?

Karpenter is a Kubernetes node autoscaler developed by AWS.

Unlike Cluster Autoscaler:

- Provisions nodes directly
- Makes intelligent scheduling decisions
- Launches nodes faster
- Supports Spot optimization
- Eliminates node group dependency

Karpenter dynamically creates and terminates EC2 instances based on unschedulable Kubernetes pods.

---

# 🏗️ Architecture Overview

![Project Overview](docs/images/karpenter.png "Architecture")

```text
Pending Pods
      ↓
Karpenter Controller
      ↓
EC2 Fleet API
      ↓
Launch Optimized EC2 Nodes
      ↓
Pods Scheduled Automatically
```

---

# ✅ Prerequisites

Before starting, ensure the following are available:

- Amazon EKS Cluster (v1.27+ recommended)
- kubectl configured
- Helm installed
- AWS CLI configured
- IAM OIDC Provider enabled
- Existing worker nodes
- Properly tagged VPC subnets

---


# 🔑 Create IAM Role for Karpenter (IRSA)

Karpenter requires AWS permissions for:

- EC2
- IAM
- Pricing API
- SSM
- EKS APIs

Example IAM policy:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:*",
        "iam:PassRole",
        "ssm:GetParameter",
        "pricing:GetProducts"
      ],
      "Resource": "*"
    }
  ]
}
```

---

# ⚙️ Install Karpenter Using Helm

## Helm Install

```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

## Install Karpenter

```bash 
kubectl create -f \
    "https://raw.githubusercontent.com/aws/karpenter-provider-aws/v${KARPENTER_VERSION}/pkg/apis/crds/karpenter.sh_nodepools.yaml"
kubectl create -f \
    "https://raw.githubusercontent.com/aws/karpenter-provider-aws/v${KARPENTER_VERSION}/pkg/apis/crds/karpenter.k8s.aws_ec2nodeclasses.yaml"
kubectl create -f \
    "https://raw.githubusercontent.com/aws/karpenter-provider-aws/v${KARPENTER_VERSION}/pkg/apis/crds/karpenter.sh_nodeclaims.yaml"
```

```bash
kubectl create ns karpenter
export KARPENTER_VERSION="1.12.0"

helm template karpenter oci://public.ecr.aws/karpenter/karpenter \
  --version "${KARPENTER_VERSION}" \
  --namespace karpenter \
  --set settings.clusterName=eks-cluster \
  --set "serviceAccount.annotations.eks\.amazonaws\.com/role-arn=arn:aws:iam::104824081961:role/KarpenterControllerRole-eks-cluster" \
  --set controller.resources.requests.cpu=1 \
  --set controller.resources.requests.memory=1Gi \
  --set controller.resources.limits.cpu=1 \
  --set controller.resources.limits.memory=1Gi \
  > karpenter.yaml
```

---

# 🏷️ Tag Subnets & Security Groups

Karpenter discovers AWS networking resources using tags.

## Required Subnet Tag

```text
karpenter.sh/discovery=<cluster-name>
```

## Required Security Group Tag

```text
karpenter.sh/discovery=<cluster-name>
```

---

# 🧩 Create EC2NodeClass

`EC2NodeClass` defines:

- AMI family
- Subnets
- Security groups
- IAM role
- Storage configuration

Example:

```yaml
apiVersion: karpenter.k8s.aws/v1beta1
kind: EC2NodeClass
metadata:
  name: default
spec:
  amiFamily: AL2

  role: KarpenterNodeRole

  subnetSelectorTerms:
    - tags:
        karpenter.sh/discovery: demo-cluster

  securityGroupSelectorTerms:
    - tags:
        karpenter.sh/discovery: demo-cluster

  amiSelectorTerms:
    - alias: al2@latest
```

---

# 🖥️ Create NodePool

`NodePool` defines:

- Capacity type
- Instance types
- Scaling limits
- Scheduling constraints

Example:

```yaml
apiVersion: karpenter.sh/v1beta1
kind: NodePool
metadata:
  name: default
spec:
  template:
    spec:
      nodeClassRef:
        name: default

      requirements:
        - key: kubernetes.io/arch
          operator: In
          values: ["amd64"]

        - key: karpenter.sh/capacity-type
          operator: In
          values: ["spot", "on-demand"]

        - key: node.kubernetes.io/instance-type
          operator: In
          values:
            - t3.medium
            - t3.large
            - m5.large

  limits:
    cpu: "1000"

  disruption:
    consolidationPolicy: WhenUnderutilized
    expireAfter: 720h
```

---

# 📈 Test Karpenter Autoscaling

## Deploy Test Workload

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: inflate
spec:
  replicas: 20
  selector:
    matchLabels:
      app: inflate
  template:
    metadata:
      labels:
        app: inflate
    spec:
      containers:
        - name: inflate
          image: public.ecr.aws/eks-distro/kubernetes/pause:3.7
          resources:
            requests:
              cpu: 1
```

## Verify Pending Pods

```bash
kubectl get pods
```

## Check Karpenter Logs

```bash
kubectl logs -n karpenter deployment/karpenter
```

## Verify Nodes

```bash
kubectl get nodes
```

---

# 💰 Spot + On-Demand Best Practices

| Workload Type       | Recommended Capacity |
|---------------------|----------------------|
| Critical workloads  |  On-Demand           |
| Stateless workloads |  Spot                |
| CI/CD workloads     |  Spot                |
| Production APIs     |  Mixed               |

---

# 🔥 Production Best Practices

## ✅ Use Multiple Instance Types

Avoid dependency on a single EC2 instance type.

```yaml
values:
  - m5.large
  - m5.xlarge
  - c5.large
  - r5.large
```

---

## ✅ Enable Consolidation

Automatically removes underutilized nodes.

```yaml
disruption:
  consolidationPolicy: WhenUnderutilized
```

---

## ✅ Use Private Subnets

Production nodes should run in private subnets.

---

## ✅ Use IRSA Only

Avoid static AWS credentials inside pods.

---

## ✅ Restrict Node Limits

Prevent unexpected infrastructure costs.

```yaml
limits:
  cpu: "500"
```

---

# 🚨 Common Issues

## Karpenter Cannot Discover Subnets

Verify subnet tags:

```bash
aws ec2 describe-subnets
```

---

## AccessDenied Errors

Check:

- IAM permissions
- IRSA annotation
- OIDC provider setup

---

## Nodes Not Launching

Check Karpenter logs:

```bash
kubectl logs -n karpenter deployment/karpenter
```

---

# 🧹 Cleanup

## Delete NodePool

```bash
kubectl delete nodepool default
```

## Remove Karpenter

```bash
helm uninstall karpenter -n karpenter
```

---

# 📚 References

- AWS EKS Documentation
- Karpenter Official Documentation
- Kubernetes Documentation
- Helm Documentation

---

# 🎯 Conclusion

Karpenter provides:

- Faster autoscaling
- Better bin-packing
- Reduced infrastructure cost
- Spot optimization
- Simplified node management

For modern Amazon EKS environments, Karpenter is becoming the preferred replacement for Cluster Autoscaler.