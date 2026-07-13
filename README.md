## 🚀 Karpenter on Amazon EKS — Production-Ready Setup Guide

Deploy and configure **Karpenter** on an **Amazon EKS** cluster using **IAM Roles for Service Accounts (IRSA)**, **EC2NodeClass**, **NodePool**, and **Spot/On-Demand provisioning** to build a scalable, production-ready Kubernetes platform.

---

## 📑 Table of Contents

* [📌 Overview](#-overview)
* [🚀 What is Karpenter?](#-what-is-karpenter)
* [🏗️ Architecture Overview](#️-architecture-overview)
* [✅ Prerequisites](#-prerequisites)
* [🔑 Create IAM Role for Karpenter (IRSA)](#-create-iam-role-for-karpenter-irsa)
* [⚙️ Install Karpenter Using Helm](#️-install-karpenter-using-helm)

  * [Install Helm](#install-helm)
  * [Install Karpenter](#install-karpenter)
* [🏷️ Tag Subnets & Security Groups](#️-tag-subnets--security-groups)

  * [Required Subnet Tag](#required-subnet-tag)
  * [Required Security Group Tag](#required-security-group-tag)
* [🧩 Create EC2NodeClass](#-create-ec2nodeclass)
* [🖥️ Create NodePool](#️-create-nodepool)
* [📈 Test Karpenter Autoscaling](#-test-karpenter-autoscaling)

  * [Test Deployment](#test-deployment)
  * [Verify Pending Pods](#verify-pending-pods)
  * [Check Karpenter Logs](#check-karpenter-logs)
  * [Verify Worker Nodes](#verify-worker-nodes)
* [💰 Spot & On-Demand Best Practices](#-spot--on-demand-best-practices)
* [🔥 Production Best Practices](#-production-best-practices)

  * [Use Multiple Instance Types](#-use-multiple-instance-types)
  * [Enable Node Consolidation](#-enable-node-consolidation)
  * [Use Private Subnets](#-use-private-subnets)
  * [Use IRSA Only](#-use-irsa-only)
  * [Restrict Node Limits](#-restrict-node-limits)
* [🚨 Common Issues](#-common-issues)

  * [Karpenter Cannot Discover Subnets](#karpenter-cannot-discover-subnets)
  * [AccessDenied Errors](#accessdenied-errors)
  * [Nodes Not Launching](#nodes-not-launching)
* [🧹 Cleanup](#-cleanup)
* [📚 References](#-references)
* [🎯 Conclusion](#-conclusion)

---
## 📌 Overview

This guide demonstrates how to deploy and configure **Karpenter** on an **Amazon EKS** cluster using production-ready best practices.

### This guide covers:

* IAM Roles for Service Accounts (IRSA)
* Private or Public Amazon EKS Clusters
* Spot and On-Demand Capacity Provisioning
* EC2NodeClass Configuration
* NodePool Configuration
* Production-Grade Autoscaling Practices

---
## 🚀 What is Karpenter?

**Karpenter** is an open-source Kubernetes node autoscaler designed for Amazon EKS.

Unlike the traditional **Cluster Autoscaler**, Karpenter provisions EC2 instances directly based on pending pod requirements instead of scaling predefined node groups.

### Key Benefits

* ⚡ Direct EC2 instance provisioning
* 🧠 Intelligent scheduling decisions
* 🚀 Faster node provisioning
* 💰 Spot Instance optimization
* 📦 Improved bin-packing efficiency
* ❌ Eliminates Managed Node Group dependency

Karpenter continuously monitors unschedulable Kubernetes pods and dynamically launches or terminates EC2 instances to satisfy workload requirements.

---
## 🏗️ Architecture Overview

![Project Overview](docs/images/karpenter.png "Architecture")

---
## ✅ Prerequisites

Before starting, ensure the following prerequisites are available.

* Amazon EKS Cluster (v1.27 or later recommended)
* kubectl configured
* Helm installed
* AWS CLI configured
* IAM OIDC Provider enabled
* Existing worker nodes
* Properly tagged VPC subnets

---
## 🔑 Create IAM Role for Karpenter (IRSA)

Karpenter requires AWS permissions to provision and manage infrastructure resources.

The controller requires access to:

* Amazon EC2
* AWS IAM
* AWS Pricing API
* AWS Systems Manager (SSM)
* Amazon EKS APIs

### Example IAM Policy

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

> **Note**
>
> Configure **IAM Roles for Service Accounts (IRSA)** before installing Karpenter to securely grant AWS permissions without using static credentials.

---

## ⚙️ Install Karpenter Using Helm

### Install Helm

```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

chmod 700 get_helm.sh

./get_helm.sh
```

---
### Install Karpenter

```bash
kubectl create -f \
"https://raw.githubusercontent.com/aws/karpenter-provider-aws/v${KARPENTER_VERSION}/pkg/apis/crds/karpenter.sh_nodepools.yaml"

kubectl create -f \
"https://raw.githubusercontent.com/aws/karpenter-provider-aws/v${KARPENTER_VERSION}/pkg/apis/crds/karpenter.k8s.aws_ec2nodeclasses.yaml"

kubectl create -f \
"https://raw.githubusercontent.com/aws/karpenter-provider-aws/v${KARPENTER_VERSION}/pkg/apis/crds/karpenter.sh_nodeclaims.yaml"

kubectl create namespace karpenter

export KARPENTER_VERSION="1.12.0"

helm template karpenter oci://public.ecr.aws/karpenter/karpenter \
  --version "${KARPENTER_VERSION}" \
  --namespace karpenter \
  --set settings.clusterName=eks-cluster \
  --set "serviceAccount.annotations.eks\.amazonaws\.com/role-arn=arn:aws:iam::<ACCOUNT_ID>:role/KarpenterControllerRole-eks-cluster" \
  --set controller.resources.requests.cpu=1 \
  --set controller.resources.requests.memory=1Gi \
  --set controller.resources.limits.cpu=1 \
  --set controller.resources.limits.memory=1Gi \
  > karpenter.yaml
```

> **Tip**
>
> Replace `<ACCOUNT_ID>` and the cluster name with values matching your AWS environment.

---

## 🏷️ Tag Subnets & Security Groups

Karpenter discovers AWS networking resources using resource tags.

### Required Subnet Tag

```text
karpenter.sh/discovery=<cluster-name>
```

### Required Security Group Tag

```text
karpenter.sh/discovery=<cluster-name>
```

> **Important**
>
> Without these discovery tags, Karpenter cannot locate the appropriate networking resources required to provision worker nodes.

---
## 🧩 Create EC2NodeClass

The **EC2NodeClass** defines the AWS infrastructure configuration used when provisioning EC2 instances.

It specifies:

* AMI Family
* IAM Role
* VPC Subnets
* Security Groups
* Storage Configuration

### Example

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

## 🖥️ Create NodePool

The **NodePool** defines how Karpenter provisions Kubernetes worker nodes.

It controls:

* Capacity Type
* Instance Types
* Scheduling Constraints
* Scaling Limits
* Consolidation Policy

#### Example

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
          values:
            - amd64

        - key: karpenter.sh/capacity-type
          operator: In
          values:
            - spot
            - on-demand

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

## 📈 Test Karpenter Autoscaling

Deploy the following test workload to trigger node provisioning.

#### Test Deployment

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

### Verify Pending Pods

```bash
kubectl get pods
```

### Check Karpenter Logs

```bash
kubectl logs -n karpenter deployment/karpenter
```

### Verify Worker Nodes

```bash
kubectl get nodes
```

---

# 💰 Spot & On-Demand Best Practices

| Workload Type          | Recommended Capacity     |
| ---------------------- | ------------------------ |
| Critical Workloads     | On-Demand                |
| Stateless Applications | Spot                     |
| CI/CD Workloads        | Spot                     |
| Production APIs        | Mixed (Spot + On-Demand) |

---

## 🔥 Production Best Practices

### ✅ Use Multiple Instance Types

Avoid depending on a single EC2 instance family.

```yaml
values:
  - m5.large
  - m5.xlarge
  - c5.large
  - r5.large
```

---

### ✅ Enable Node Consolidation

Automatically remove underutilized nodes.

```yaml
disruption:
  consolidationPolicy: WhenUnderutilized
```

---
### ✅ Use Private Subnets

Deploy worker nodes in private subnets for improved security.

---
### ✅ Use IRSA Only

Avoid storing static AWS credentials inside Kubernetes workloads.

---
### ✅ Restrict Node Limits

Prevent unexpected infrastructure costs.

```yaml
limits:
  cpu: "500"
```

---
## 🚨 Common Issues

### Karpenter Cannot Discover Subnets

Verify subnet discovery tags.

```bash
aws ec2 describe-subnets
```

---
### AccessDenied Errors

Verify the following:

* IAM Permissions
* IRSA Configuration
* OIDC Provider
* IAM Trust Policy

---
### Nodes Not Launching

Inspect Karpenter controller logs.

```bash
kubectl logs -n karpenter deployment/karpenter
```

---
## 🧹 Cleanup

#### Delete NodePool

```bash
kubectl delete nodepool default
```

#### Remove Karpenter

```bash
helm uninstall karpenter -n karpenter
```

---
## 📚 References

* Amazon EKS Documentation
* Karpenter Documentation
* Kubernetes Documentation
* Helm Documentation

---
## 🎯 Conclusion

Karpenter simplifies Kubernetes node autoscaling by provisioning infrastructure dynamically based on workload requirements.

#### Benefits

* Faster Autoscaling
* Intelligent Bin Packing
* Reduced Infrastructure Costs
* Spot Instance Optimization
* Simplified Node Management

Karpenter is rapidly becoming the preferred node autoscaling solution for modern Amazon EKS environments due to its flexibility, efficiency, and production-ready design.

---