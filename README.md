## 🚀 Karpenter on Amazon EKS 

Deploy and configure **Karpenter** on an **Amazon EKS** cluster using **IAM Roles for Service Accounts (IRSA)**, **EC2NodeClass**, **NodePool**, and **Spot/On-Demand provisioning** to build a scalable, production-ready Kubernetes platform.

---

## 📖 Project Overview

This project demonstrates a **production-ready implementation of Karpenter on Amazon EKS** to provide intelligent, Kubernetes-native node autoscaling for containerized workloads.

Unlike the traditional Kubernetes Cluster Autoscaler, which relies on predefined EC2 Auto Scaling Groups, **Karpenter provisions EC2 instances directly** based on the scheduling requirements of pending pods. This enables faster workload scheduling, improved resource utilization, and significant infrastructure cost optimization through intelligent instance selection and automatic node consolidation. :contentReference[oaicite:0]{index=0}

The repository provides a complete, hands-on deployment of Karpenter using **Infrastructure as Code (Terraform)** and **Helm**, following AWS production best practices. It covers the entire lifecycle—from provisioning an Amazon EKS cluster to configuring IAM Roles for Service Accounts (IRSA), installing Karpenter, creating EC2NodeClasses and NodePools, validating automatic node provisioning, and safely deprovisioning unused nodes.

This implementation demonstrates how Karpenter automatically:

- Detects unschedulable Kubernetes pods
- Launches right-sized EC2 instances based on workload requirements
- Selects appropriate instance families, architectures, and Availability Zones
- Supports both On-Demand and Spot capacity for cost optimization
- Consolidates underutilized nodes to reduce infrastructure costs
- Removes idle nodes automatically while maintaining application availability

The project follows modern AWS EKS architecture and showcases production-grade autoscaling capabilities including:

- Kubernetes-native autoscaling without Auto Scaling Groups
- Dynamic node provisioning using **NodePools** and **EC2NodeClasses**
- IAM Roles for Service Accounts (IRSA) integration
- AWS EKS Pod Identity / IAM authentication (depending on deployment)
- Automatic node consolidation and drift management
- Flexible instance type selection
- Multi-AZ deployment support
- Spot and On-Demand capacity management
- Infrastructure as Code using Terraform
- Helm-based Karpenter installation
- Scale-up and scale-down validation using sample workloads

---
## 🎯 Key Objectives
- Deploy a production-ready **Amazon EKS** cluster using **Terraform**.
- Install and configure **Karpenter** for Kubernetes-native node autoscaling.
- Configure **IAM Roles for Service Accounts (IRSA)** to enable secure AWS API access.
- Create and manage **EC2NodeClass** and **NodePool** resources for dynamic node provisioning.
- Provision EC2 instances automatically based on pending pod resource requirements.
- Support both **On-Demand** and **Spot** instances to optimize infrastructure costs.
- Enable intelligent instance type selection across multiple Availability Zones.
- Automatically consolidate underutilized nodes to improve cluster efficiency.
- Demonstrate rapid scale-up and scale-down based on application workload.
- Eliminate dependency on fixed Auto Scaling Groups (ASGs) for worker nodes.
- Follow AWS and Kubernetes production best practices for scalability, security, and reliability.
- Validate end-to-end autoscaling behavior through workload deployment and monitoring.
- Provide a reusable, production-ready reference implementation for modern EKS autoscaling.

---
## 🌟 Why This Project Matters

Traditional Kubernetes node autoscaling with the **Cluster Autoscaler** depends on predefined **EC2 Auto Scaling Groups (ASGs)**, which can lead to slower scaling decisions, overprovisioned infrastructure, and limited flexibility in instance selection.

**Karpenter** addresses these challenges by provisioning compute capacity directly through the AWS EC2 API whenever unschedulable pods are detected. It intelligently selects the most suitable instance types, capacity options (On-Demand or Spot), Availability Zones, and CPU architectures based on the workload's resource requirements. This approach enables faster pod scheduling, higher cluster utilization, and improved cost efficiency.

This project demonstrates how to implement a modern, production-ready autoscaling solution on Amazon EKS using Karpenter. It showcases best practices for secure deployment with **Terraform**, **IAM Roles for Service Accounts (IRSA)**, **Helm**, **EC2NodeClass**, and **NodePool**, providing a scalable and maintainable foundation for cloud-native workloads.

### Key Benefits

- ⚡ Faster node provisioning compared to traditional autoscaling approaches.
- 💰 Lower infrastructure costs through intelligent resource allocation and node consolidation.
- 🚀 Improved application availability by rapidly provisioning capacity for pending workloads.
- 🎯 Optimal EC2 instance selection based on workload requirements.
- 🔄 Automatic scaling and consolidation without relying on predefined Auto Scaling Groups.
- ☁️ Support for both **On-Demand** and **Spot** instances to balance performance and cost.
- 🔒 Production-ready architecture following AWS and Kubernetes best practices.
- 📈 Better cluster utilization through just-in-time compute provisioning.

---
## 🏗️ Architecture Overview

![Project Overview](docs/images/karpenter.png "Architecture")

---
## ✨ Features

| Feature | Description |
|----------|-------------|
| 🚀 Amazon EKS Deployment | Provision a production-ready Amazon EKS cluster using Terraform. |
| ⚙️ Karpenter Installation | Deploy Karpenter using Helm with production-ready configuration. |
| 🔐 IAM Roles for Service Accounts (IRSA) | Securely grant AWS permissions to Karpenter using IAM Roles for Service Accounts. |
| 🖥️ EC2NodeClass | Define AWS-specific infrastructure settings such as AMI, subnets, security groups, and IAM instance profiles. |
| 📦 NodePool Configuration | Configure scheduling policies, capacity types, instance families, CPU architectures, and scaling constraints. |
| ⚡ Dynamic Node Provisioning | Automatically provision EC2 instances when pods become unschedulable. |
| 📈 Automatic Scale-Up | Launch new worker nodes based on real-time workload demand. |
| 📉 Automatic Scale-Down | Remove idle nodes when they are no longer required. |
| 💰 Cost Optimization | Reduce infrastructure costs through intelligent node consolidation and right-sized instance selection. |
| 🎯 Intelligent Instance Selection | Automatically choose the most suitable EC2 instance types based on pod resource requirements. |
| ☁️ Multi-Capacity Support | Provision both **On-Demand** and **Spot** instances for maximum flexibility and savings. |
| 🌍 Multi-Availability Zone Support | Distribute workloads across multiple Availability Zones for improved resilience. |
| 🏗️ Kubernetes-Native Autoscaling | Scale compute resources without relying on predefined Auto Scaling Groups (ASGs). |
| 🔄 Node Consolidation | Automatically replace or remove underutilized nodes to improve resource utilization. |
| 🧪 Autoscaling Validation | Demonstrate end-to-end node provisioning, workload scheduling, and node termination. |
| 📊 Observability | Monitor node lifecycle events, provisioning activities, and autoscaling behavior using Kubernetes and AWS tools. |
| 🛡️ Production Best Practices | Implement secure, scalable, and highly available configurations aligned with AWS and Kubernetes recommendations. |
| 📚 Infrastructure as Code | Manage the complete deployment lifecycle using Terraform for repeatable and version-controlled infrastructure. |

---
## 📋 Prerequisites

Before deploying Karpenter on Amazon EKS, ensure the following requirements are met:

| Requirement | Version / Details |
|-------------|-------------------|
| AWS Account | Active AWS account with sufficient IAM permissions |
| AWS CLI | v2.x or later, configured with appropriate credentials |
| Terraform | v1.5+ |
| kubectl | Compatible with your Amazon EKS cluster version |
| Helm | v3.12+ |
| eksctl *(Optional)* | Latest version for EKS management tasks |
| Docker | Latest stable version (optional for testing workloads) |
| Git | Latest version |
| Amazon EKS Cluster | Existing EKS cluster (Kubernetes v1.31+ recommended) |
| IAM OIDC Provider | Enabled for the EKS cluster |
| IAM Roles for Service Accounts (IRSA) | Configured for Karpenter |
| EC2 Instance Profile | IAM instance profile for worker nodes |
| VPC Configuration | Public and/or private subnets tagged for Karpenter discovery |
| Security Groups | Configured for EKS worker node communication |
| Amazon ECR Public Access | Required to pull Karpenter container images |
| Internet or NAT Gateway | Required for private subnet deployments |
| SSH Access *(Optional)* | For troubleshooting EC2 worker nodes |

### Required AWS Permissions

The AWS IAM user or role used for deployment should have permissions to manage:

- Amazon EKS
- Amazon EC2
- Amazon IAM
- Amazon VPC
- Amazon CloudFormation
- Amazon EventBridge
- AWS Systems Manager (SSM)
- Amazon ECR
- Amazon CloudWatch

### Verify Installed Tools

```bash
aws --version
terraform version
kubectl version --client
helm version
git --version
docker --version
```

### Verify AWS Authentication

```bash
aws sts get-caller-identity
```

### Verify Kubernetes Cluster Access

```bash
kubectl get nodes
kubectl get ns
```

> **Note:** Ensure your EKS cluster is operational and the IAM OIDC provider is associated with the cluster before installing Karpenter. Karpenter relies on **IRSA** and **EC2NodeClass** resources to securely provision worker nodes.

---
## 🏗️ Architecture Components

The solution consists of the following core components that work together to provide intelligent, Kubernetes-native autoscaling on Amazon EKS.

| Component | Purpose |
|-----------|---------|
| **Amazon EKS** | Managed Kubernetes control plane that hosts containerized applications. |
| **Terraform** | Provisions the EKS cluster and AWS infrastructure using Infrastructure as Code (IaC). |
| **Karpenter** | Kubernetes-native autoscaler that dynamically provisions and terminates EC2 instances based on workload demand. |
| **Helm** | Installs and manages the Karpenter controller and related Kubernetes resources. |
| **IAM Roles for Service Accounts (IRSA)** | Provides secure, least-privilege AWS access for the Karpenter controller without long-lived credentials. |
| **Amazon EC2** | Supplies compute capacity by launching worker nodes that match application requirements. |
| **EC2NodeClass** | Defines AWS-specific configuration including AMI family, IAM instance profile, subnets, security groups, storage, and tags for provisioned nodes. |
| **NodePool** | Defines scheduling policies, capacity types, instance families, architectures, resource limits, and disruption settings for dynamically provisioned nodes. |
| **Amazon VPC** | Provides secure networking for the EKS cluster and worker nodes. |
| **Subnets** | Enable Karpenter to discover eligible networking resources for node provisioning. |
| **Security Groups** | Control inbound and outbound network traffic for the EKS cluster and worker nodes. |
| **IAM Instance Profile** | Grants AWS permissions to EC2 instances launched by Karpenter. |
| **Amazon ECR Public** | Hosts the Karpenter controller container image. |
| **AWS Systems Manager (SSM)** | Supplies the latest optimized EKS AMIs for node provisioning. |
| **Amazon EventBridge** | Delivers interruption notifications (such as Spot interruptions) to Karpenter for graceful node handling. |
| **Kubernetes Scheduler** | Detects unschedulable pods and triggers Karpenter to provision additional capacity. |
| **Application Workloads** | Deployments, StatefulSets, Jobs, and other Kubernetes workloads that generate autoscaling demand. |

### Component Workflow

1. **Terraform** provisions the Amazon EKS cluster and required AWS infrastructure.
2. **Helm** installs the Karpenter controller into the EKS cluster.
3. **IRSA** securely grants AWS permissions to the Karpenter controller.
4. **EC2NodeClass** defines how EC2 instances should be configured.
5. **NodePool** specifies the provisioning and scheduling policies.
6. When pods cannot be scheduled, the **Kubernetes Scheduler** notifies Karpenter.
7. **Karpenter** provisions the most suitable EC2 instances based on workload requirements.
8. Applications are scheduled immediately on the newly created worker nodes.
9. When demand decreases, Karpenter automatically consolidates or terminates underutilized nodes to optimize infrastructure costs.

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
## 🔐 Step 1: Configure IAM for Karpenter (IRSA)

Before installing Karpenter, configure **IAM Roles for Service Accounts (IRSA)** to securely grant the Karpenter controller permission to provision and manage AWS resources without using long-lived credentials.

---
### 1.1 Create the IAM Policy

Create an IAM policy that grants Karpenter the required permissions to manage EC2 instances, launch templates, instance profiles, pricing information, and other AWS resources.

```bash
# Create the Karpenter IAM policy
```

---
### 1.2 Create the IAM Policy Resource

Create the IAM policy in your AWS account.

```bash
# aws iam create-policy ...
```

---
### 1.3 Create the IAM Role Trust Policy

Create the IAM trust policy that allows the Kubernetes Service Account to assume the IAM role through the cluster's OIDC provider.

```json
{
  ...
}
```

---
### 1.4 Create the IAM Role

Create the IAM role and attach the Karpenter IAM policy.

```bash
# aws iam create-role ...

# aws iam attach-role-policy ...
```

---
### 1.5 Annotate the Karpenter Service Account

Associate the IAM role with the Karpenter Service Account using IRSA.

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: karpenter
  namespace: karpenter
  annotations:
    eks.amazonaws.com/role-arn: arn:aws:iam::<ACCOUNT_ID>:role/KarpenterControllerRole-eks-cluster
```

---
### 1.6 Validate the IRSA Configuration

Verify that the IAM role has been correctly associated with the Service Account.

```bash
kubectl get sa karpenter -n karpenter -o yaml
```

Verify the IAM role annotation.

```bash
kubectl describe sa karpenter -n karpenter
```

> **Note**
>
> Ensure that the Amazon EKS cluster has an **IAM OIDC Provider** associated with it before configuring IRSA. Karpenter relies on IRSA to securely interact with AWS services such as Amazon EC2, IAM, and Systems Manager.

## 🏷️ Step 2: Configure AWS Resource Discovery

Before Karpenter can provision worker nodes, it must be able to discover the networking resources associated with your Amazon EKS cluster.

### 2.1 Tag Amazon VPC Subnets

Tag every subnet that Karpenter should use for launching EC2 instances.

**Required Subnet Tag**

```text
karpenter.sh/discovery=<cluster-name>
```

---
### 2.2 Tag Security Groups

Tag the worker node security group using the same discovery tag.

**Required Security Group Tag**

```text
karpenter.sh/discovery=<cluster-name>
```

---
### 2.3 Configure the IAM Instance Profile

Ensure an IAM Instance Profile is attached to the node role that will be referenced by the EC2NodeClass.

> **Note**
>
> Without the discovery tags and IAM Instance Profile, Karpenter cannot provision worker nodes successfully.

---
## ⚙️ Step 3: Install Karpenter

Install Karpenter after completing the IAM (IRSA) configuration and AWS resource discovery.

---
### 3.1 Install Helm

```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

chmod 700 get_helm.sh

./get_helm.sh
```

---
### 3.2 Install Karpenter Custom Resource Definitions (CRDs)

```bash
export KARPENTER_VERSION="1.12.0"

kubectl create -f \
"https://raw.githubusercontent.com/aws/karpenter-provider-aws/v${KARPENTER_VERSION}/pkg/apis/crds/karpenter.sh_nodepools.yaml"

kubectl create -f \
"https://raw.githubusercontent.com/aws/karpenter-provider-aws/v${KARPENTER_VERSION}/pkg/apis/crds/karpenter.k8s.aws_ec2nodeclasses.yaml"

kubectl create -f \
"https://raw.githubusercontent.com/aws/karpenter-provider-aws/v${KARPENTER_VERSION}/pkg/apis/crds/karpenter.sh_nodeclaims.yaml"
```

---
### 3.3 Deploy the Karpenter Controller

Create the namespace.

```bash
kubectl create namespace karpenter
```

Generate the deployment manifest.

```bash
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

Deploy Karpenter.

```bash
kubectl apply -f karpenter.yaml
```

> **Tip**
>
> Replace `<ACCOUNT_ID>` and `eks-cluster` with values from your AWS environment.

---
### 3.4 Verify the Installation

Verify the controller.

```bash
kubectl get pods -n karpenter
```

Verify the deployment.

```bash
kubectl get deployment -n karpenter
```

Verify the CRDs.

```bash
kubectl get crds | grep karpenter
```

---
## 🧩 Step 4: Create an EC2NodeClass

The **EC2NodeClass** defines the AWS infrastructure configuration used when provisioning EC2 instances.

---
### 4.1 Configure the EC2NodeClass

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
### 4.2 Configuration Overview

- AMI Family
- IAM Role
- Subnet Discovery
- Security Group Discovery
- AMI Selection
- Storage Configuration

---
### 4.3 Production Best Practices

- Use Amazon Linux 2023 or Bottlerocket.
- Use subnet discovery tags instead of subnet IDs.
- Apply least-privilege IAM permissions.
- Keep AMIs updated.
- Separate system and application workloads.

---
## 🖥️ Step 5: Create a NodePool

The **NodePool** controls how Karpenter provisions worker nodes.

---
### 5.1 Configure the NodePool

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
### 5.2 Scheduling Requirements

- CPU Architecture
- Capacity Type
- EC2 Instance Types
- Availability Zones

---
### 5.3 Resource Limits

- CPU Limits
- Cluster Capacity Limits

---
### 5.4 Node Disruption Policies

- Consolidation
- Expiration
- Drift Replacement

---
### 5.5 Scheduling Policies

- Labels
- Taints
- Tolerations
- Node Affinity

---
## 🔄 Step 6: Understand the Karpenter Provisioning Workflow

Karpenter continuously monitors the Kubernetes scheduler for **Pending** pods that cannot be scheduled due to insufficient cluster capacity. When additional compute resources are required, Karpenter dynamically provisions the most appropriate Amazon EC2 instances based on workload requirements, schedules the pending pods, and continuously optimizes cluster utilization by consolidating or terminating underutilized nodes.

This intelligent, Kubernetes-native provisioning approach eliminates the need for predefined Auto Scaling Groups (ASGs), enabling faster scaling decisions, improved resource utilization, and lower infrastructure costs.

---
### 6.1 Scale-Up Workflow

When an application requires additional compute capacity, Karpenter performs the following sequence of operations:

1. An application is deployed or scaled.
2. Kubernetes creates new Pods.
3. The Kubernetes Scheduler attempts to schedule the Pods.
4. If sufficient resources are unavailable, the Pods remain in the **Pending** state.
5. Karpenter detects the pending Pods.
6. Karpenter evaluates the scheduling requirements, including:
   - CPU and memory requests
   - Node affinity
   - Taints and tolerations
   - Availability Zones
   - Capacity type (On-Demand or Spot)
   - Architecture (amd64 or arm64)
7. Karpenter evaluates the configured **NodePool**.
8. Karpenter retrieves the infrastructure configuration from the **EC2NodeClass**.
9. Karpenter selects the most appropriate EC2 instance type.
10. A new EC2 instance is launched.
11. The new worker node joins the Amazon EKS cluster.
12. Kubernetes automatically schedules the pending Pods onto the newly provisioned node.

---
### 6.2 Node Consolidation Workflow

As workload demand decreases, Karpenter continuously evaluates cluster utilization and automatically optimizes infrastructure costs.

The consolidation workflow consists of the following steps:

1. Application workload decreases.
2. Some worker nodes become underutilized or empty.
3. Karpenter identifies consolidation opportunities.
4. Running Pods are safely drained and rescheduled if required.
5. Replacement nodes are created when beneficial.
6. Empty or underutilized EC2 instances are terminated.
7. Cluster capacity is automatically optimized.

This process helps eliminate idle compute resources while maintaining application availability.

---
### 6.3 End-to-End Provisioning Workflow

```text
                 Deploy Application
                         │
                         ▼
                 Kubernetes Pods Created
                         │
                         ▼
              Kubernetes Scheduler Attempts
                  to Schedule the Pods
                         │
          ┌──────────────┴──────────────┐
          │                             │
     Resources Available         Resources Unavailable
          │                             │
          ▼                             ▼
     Pods Scheduled              Pods Remain Pending
                                        │
                                        ▼
                          Karpenter Detects Pending Pods
                                        │
                                        ▼
                           Evaluate NodePool Requirements
                                        │
                                        ▼
                         Retrieve EC2NodeClass Configuration
                                        │
                                        ▼
                      Select Optimal EC2 Instance Type
                                        │
                                        ▼
                          Launch Amazon EC2 Instance
                                        │
                                        ▼
                          Worker Node Joins Amazon EKS
                                        │
                                        ▼
                     Kubernetes Schedules Pending Pods
                                        │
                                        ▼
                         Application Becomes Available
                                        │
                                        ▼
                        Workload Demand Eventually Drops
                                        │
                                        ▼
                   Karpenter Consolidates Idle Worker Nodes
                                        │
                                        ▼
                         Unused EC2 Instances Terminated
```

---
### 6.4 Benefits of the Provisioning Workflow

The Karpenter provisioning workflow provides several operational and cost optimization benefits:

- ⚡ Rapid provisioning of worker nodes for pending workloads.
- 🎯 Intelligent EC2 instance selection based on application requirements.
- ☁️ Native integration with Amazon EC2 and Amazon EKS.
- 💰 Reduced infrastructure costs through automatic node consolidation.
- 📈 Improved cluster resource utilization.
- 🚀 Faster application scheduling compared to traditional Auto Scaling Groups.
- 🔄 Automatic support for both **On-Demand** and **Spot** capacity.
- 🌍 Multi-Availability Zone provisioning for improved resilience.
- 🛡️ Kubernetes-native autoscaling without managing predefined node groups.
- 🏗️ Production-ready architecture aligned with AWS and Kubernetes best practices.

---
### 6.5 Verify the Provisioning Workflow

Use the following commands to observe the provisioning workflow in real time.

Watch pending Pods:

```bash
kubectl get pods -w
```

Watch worker nodes:

```bash
kubectl get nodes -w
```

Monitor the Karpenter controller logs:

```bash
kubectl logs -f -n karpenter deployment/karpenter
```

View NodePools:

```bash
kubectl get nodepool
```

View EC2NodeClasses:

```bash
kubectl get ec2nodeclass
```

View NodeClaims created by Karpenter:

```bash
kubectl get nodeclaims
```

These commands help validate that Karpenter is successfully provisioning, managing, and consolidating worker nodes based on real-time application demand.

---
## 📈 Step 7: Validate Karpenter Autoscaling

### 7.1 Deploy a Test Workload

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

---
### 7.2 Verify Pending Pods

```bash
kubectl get pods
```

---
### 7.3 Monitor the Karpenter Controller

```bash
kubectl logs -n karpenter deployment/karpenter
```

---
### 7.4 Verify Newly Provisioned Worker Nodes

```bash
kubectl get nodes
```

---
### 7.5 Validate Automatic Scale-Down

Delete the test deployment.

```bash
kubectl delete deployment inflate
```

Watch Karpenter automatically consolidate and terminate idle worker nodes.

```bash
kubectl get nodes -w
```


---
## 💰 Cost Optimization

Karpenter is designed to optimize infrastructure costs by dynamically provisioning the most appropriate Amazon EC2 instances based on real-time workload requirements. Unlike traditional autoscaling solutions that rely on predefined Auto Scaling Groups (ASGs), Karpenter continuously evaluates cluster utilization, intelligently selects EC2 instance types, and consolidates underutilized nodes to maximize efficiency while maintaining application availability.

---
### 🎯 Spot Instances

Karpenter supports both **On-Demand** and **Spot** capacity, allowing workloads to take advantage of lower-cost Spot Instances for fault-tolerant applications.

#### Benefits

- Significantly reduce EC2 infrastructure costs.
- Utilize unused AWS compute capacity.
- Automatically replace interrupted Spot Instances.
- Combine Spot and On-Demand capacity for high availability.
- Improve overall cluster cost efficiency.

**Example NodePool Configuration**

```yaml
requirements:
  - key: karpenter.sh/capacity-type
    operator: In
    values:
      - spot
      - on-demand
```

---
### 🔄 Consolidation

Karpenter continuously analyzes cluster utilization and automatically consolidates underutilized worker nodes.

Instead of leaving partially utilized nodes running, Karpenter can:

- Reschedule workloads onto fewer nodes.
- Replace multiple small nodes with a single larger node when appropriate.
- Remove empty nodes.
- Terminate underutilized EC2 instances.

#### Benefits

- Higher cluster utilization.
- Lower EC2 costs.
- Reduced infrastructure waste.
- Automatic cluster optimization.

**Example**

```yaml
disruption:
  consolidationPolicy: WhenUnderutilized
```

---
### 🖥️ Intelligent Instance Selection

Karpenter automatically selects the most suitable EC2 instance type based on workload requirements instead of relying on predefined node groups.

It evaluates factors such as:

- CPU requirements
- Memory requirements
- Pod scheduling constraints
- Node affinity
- Availability Zones
- Capacity type (Spot or On-Demand)
- CPU architecture (amd64 or arm64)

This enables right-sized infrastructure for each workload while minimizing unnecessary resource allocation.

---
### 📦 Bin Packing

Karpenter uses intelligent **bin packing** to maximize utilization of worker nodes.

Rather than provisioning one node per workload, Karpenter packs multiple Pods onto the fewest number of nodes while respecting Kubernetes scheduling constraints.

#### Benefits

- Higher CPU utilization.
- Better memory utilization.
- Fewer EC2 instances.
- Lower infrastructure costs.
- Improved cluster efficiency.

---
### 🔄 Cost Optimization Workflow

```text
Application Workload
         │
         ▼
Pending Pods
         │
         ▼
Karpenter Evaluates Workload Requirements
         │
         ▼
Select Optimal EC2 Instance Type
         │
         ▼
Launch Right-Sized EC2 Instance
         │
         ▼
Schedule Pods Efficiently
         │
         ▼
Continuously Monitor Node Utilization
         │
         ▼
Identify Underutilized Nodes
         │
         ▼
Consolidate Workloads
         │
         ▼
Terminate Unused EC2 Instances
         │
         ▼
Lower Infrastructure Costs
```

---
### ✅ Cost Optimization Best Practices

Follow these recommendations to maximize cost savings while maintaining application performance:

- Prefer **Spot Instances** for stateless and fault-tolerant workloads.
- Configure **On-Demand** capacity for critical production services.
- Enable **Node Consolidation** to remove underutilized worker nodes automatically.
- Allow multiple EC2 instance families instead of restricting to a single instance type.
- Define realistic CPU and memory requests for workloads to improve scheduling efficiency.
- Use Kubernetes **Resource Requests** and **Limits** to enable accurate instance sizing.
- Distribute workloads across multiple Availability Zones for improved resilience.
- Regularly monitor node utilization and provisioning events.
- Review NodePool requirements to avoid overly restrictive scheduling policies.
- Continuously optimize workload placement to maximize cluster utilization.

> **Tip**
>
> Combining **Spot Instances**, **Node Consolidation**, **Intelligent Instance Selection**, and **Bin Packing** enables Karpenter to significantly reduce Amazon EKS infrastructure costs while maintaining high application availability and efficient resource utilization.

---
## 🏆 Production Best Practices

Deploying Karpenter in production requires careful planning to ensure scalability, security, availability, and cost efficiency. The following best practices help build a resilient and production-ready Amazon EKS environment.

---
### 🔒 Security Best Practices

- Configure **IAM Roles for Service Accounts (IRSA)** for secure AWS API access.
- Follow the **principle of least privilege** when creating IAM policies.
- Enable the **Amazon EKS OIDC provider** before installing Karpenter.
- Restrict access using Kubernetes **RBAC**.
- Store sensitive information securely using **AWS Secrets Manager** or **External Secrets**.
- Regularly rotate IAM credentials and audit permissions.
- Enable Kubernetes audit logging and Amazon CloudTrail.

---
### ☁️ Infrastructure Best Practices

- Use **Amazon Linux 2023 (AL2023)** or **Bottlerocket** AMIs for new deployments.
- Tag Amazon VPC subnets and security groups using the `karpenter.sh/discovery` tag.
- Deploy worker nodes across multiple **Availability Zones**.
- Use private subnets for worker nodes whenever possible.
- Keep the EKS control plane and worker nodes updated to supported Kubernetes versions.
- Version-control all infrastructure using **Terraform** or another Infrastructure as Code (IaC) tool.

---
### 🖥️ NodePool Best Practices

- Create separate **NodePools** for different workload types (for example, system, application, and data workloads).
- Allow multiple EC2 instance families to improve scheduling flexibility.
- Avoid restricting NodePools to a single instance type unless required.
- Configure appropriate CPU and memory limits.
- Use labels, taints, and tolerations to isolate workloads.
- Define NodePool requirements based on workload characteristics rather than individual applications.

---
### ⚙️ EC2NodeClass Best Practices

- Use discovery tags instead of hardcoded subnet or security group IDs.
- Keep AMIs updated with the latest Amazon EKS-optimized releases.
- Configure appropriate root volume size and storage settings.
- Use dedicated IAM instance profiles for worker nodes.
- Validate networking configuration before deploying workloads.
- Regularly review EC2NodeClass settings to align with infrastructure changes.

---
### 💰 Cost Optimization Best Practices

- Prefer **Spot Instances** for stateless and fault-tolerant workloads.
- Keep **On-Demand** capacity available for critical production applications.
- Enable node consolidation to reduce infrastructure costs.
- Allow Karpenter to select from multiple EC2 instance families.
- Define accurate Kubernetes resource requests and limits.
- Monitor node utilization and eliminate overprovisioning.

---
### 📊 Monitoring and Observability

- Monitor the Karpenter controller using **Amazon CloudWatch**, **Prometheus**, or **Grafana**.
- Review controller logs regularly for provisioning and scheduling events.
- Monitor node provisioning latency and cluster utilization.
- Track Spot interruption events and node lifecycle events.
- Configure alerts for controller failures, provisioning delays, and node health.

---
### 🚀 High Availability

- Deploy multiple replicas of the Karpenter controller where supported by your operational requirements.
- Distribute workloads across multiple Availability Zones.
- Configure Pod Disruption Budgets (PDBs) for critical applications.
- Use multiple EC2 instance families to reduce capacity shortages.
- Maintain sufficient cluster capacity for critical workloads during scaling events.

---
### 🔄 Operational Best Practices

- Test autoscaling behavior before deploying production workloads.
- Validate scale-up and scale-down scenarios regularly.
- Keep Helm charts and Karpenter versions up to date.
- Review NodePool and EC2NodeClass configurations after Kubernetes upgrades.
- Perform periodic disaster recovery and infrastructure validation exercises.
- Document operational procedures for provisioning, upgrades, and troubleshooting.

---
### ✅ Production Readiness Checklist

Before deploying Karpenter to production, verify the following:

- ✅ IRSA is configured correctly.
- ✅ Amazon EKS OIDC provider is enabled.
- ✅ Required IAM permissions are configured.
- ✅ Subnets and security groups are tagged for discovery.
- ✅ EC2NodeClass is configured and validated.
- ✅ NodePool requirements and limits are reviewed.
- ✅ Spot and On-Demand capacity strategies are defined.
- ✅ Node consolidation is enabled where appropriate.
- ✅ Monitoring and alerting are configured.
- ✅ Autoscaling workflows have been tested successfully.
- ✅ Infrastructure is managed using Infrastructure as Code (IaC).
- ✅ Kubernetes and Karpenter versions are supported and up to date.

> **Tip**
>
> A production-ready Karpenter deployment combines secure IAM configuration, well-designed NodePools, optimized EC2NodeClasses, intelligent cost optimization, and comprehensive monitoring to deliver a scalable, resilient, and cost-efficient Amazon EKS platform.

---
## 🛠️ Troubleshooting

This section covers common issues you may encounter when deploying or operating Karpenter on Amazon EKS, along with recommended troubleshooting steps.

---
### Issue 1: Karpenter Controller Pod Is Not Running

#### Symptoms

- Karpenter controller Pod remains in `Pending`, `CrashLoopBackOff`, or `Error`.
- Deployment is unavailable.

#### Verify

```bash
kubectl get pods -n karpenter

kubectl describe pod <karpenter-pod-name> -n karpenter

kubectl logs -n karpenter deployment/karpenter
```

#### Possible Causes

- Insufficient cluster resources.
- Incorrect Helm configuration.
- Missing IAM permissions.
- Invalid Service Account annotation.

#### Resolution

- Verify the Helm installation.
- Check the controller logs for errors.
- Confirm the IAM Role is attached to the Service Account.
- Ensure the EKS cluster has sufficient resources.

---
### Issue 2: Pending Pods Are Not Triggering Node Provisioning

#### Symptoms

- Pods remain in the `Pending` state.
- No new EC2 instances are launched.

#### Verify

```bash
kubectl get pods

kubectl describe pod <pod-name>

kubectl logs -n karpenter deployment/karpenter
```

#### Possible Causes

- NodePool requirements are too restrictive.
- EC2NodeClass is misconfigured.
- Missing subnet or security group discovery tags.
- Insufficient AWS account quotas.

#### Resolution

- Review the NodePool scheduling requirements.
- Verify the EC2NodeClass configuration.
- Confirm the required discovery tags exist.
- Check AWS service quotas.

---

### Issue 3: EC2NodeClass Not Ready

#### Symptoms

- EC2NodeClass status is not `Ready`.

#### Verify

```bash
kubectl get ec2nodeclass

kubectl describe ec2nodeclass default
```

#### Possible Causes

- Invalid IAM role.
- Missing subnet discovery tags.
- Missing security group discovery tags.
- Invalid AMI configuration.

#### Resolution

- Verify the IAM instance profile or node role.
- Check subnet and security group tags.
- Validate the selected AMI family and AMI configuration.

---

### Issue 4: NodePool Not Ready

#### Symptoms

- NodePool remains in a non-ready state.
- Worker nodes are not provisioned.

#### Verify

```bash
kubectl get nodepool

kubectl describe nodepool default
```

#### Possible Causes

- Invalid NodePool requirements.
- EC2NodeClass reference is incorrect.
- Resource limits are too restrictive.

#### Resolution

- Verify the referenced EC2NodeClass exists.
- Review scheduling requirements.
- Increase resource limits if necessary.

---

### Issue 5: Worker Nodes Fail to Join the Cluster

#### Symptoms

- EC2 instances are created but do not appear in the cluster.

#### Verify

```bash
kubectl get nodes

aws ec2 describe-instances
```

#### Possible Causes

- Incorrect IAM instance profile.
- Bootstrap configuration failure.
- Network connectivity issues.
- Security group misconfiguration.

#### Resolution

- Verify the node IAM role.
- Check subnet routing and NAT Gateway configuration.
- Confirm security group rules allow communication with the EKS control plane.
- Review EC2 instance system logs.

---
### Issue 6: IRSA Authentication Failure

#### Symptoms

- Access denied errors in the Karpenter controller logs.
- AWS API calls fail.

#### Verify

```bash
kubectl describe sa karpenter -n karpenter

kubectl logs -n karpenter deployment/karpenter
```

#### Possible Causes

- Missing IAM Role annotation.
- Incorrect trust policy.
- OIDC provider is not configured.

#### Resolution

- Verify the Service Account annotation.
- Confirm the IAM trust relationship.
- Ensure the Amazon EKS OIDC provider is associated with the cluster.

---
### Issue 7: Discovery Tags Not Found

#### Symptoms

- Karpenter cannot discover subnets or security groups.
- Node provisioning fails.

#### Verify

```bash
aws ec2 describe-subnets

aws ec2 describe-security-groups
```

#### Resolution

Ensure the following tag is applied to all required resources:

```text
karpenter.sh/discovery=<cluster-name>
```

---
### Issue 8: Node Consolidation Is Not Working

#### Symptoms

- Empty or underutilized nodes remain running.
- Infrastructure costs remain higher than expected.

#### Verify

```bash
kubectl get nodepool -o yaml

kubectl logs -n karpenter deployment/karpenter
```

#### Possible Causes

- Consolidation is disabled.
- Running Pods cannot be evicted.
- Pod Disruption Budgets prevent node termination.

#### Resolution

- Enable node consolidation.
- Review Pod Disruption Budgets.
- Verify disruption policies.

---
### Issue 9: Spot Instances Are Not Provisioned

#### Symptoms

- Only On-Demand instances are launched.

#### Verify

```bash
kubectl describe nodepool default
```

#### Possible Causes

- Spot capacity unavailable.
- NodePool requirements restrict Spot instances.
- AWS capacity constraints.

#### Resolution

- Allow multiple EC2 instance families.
- Include both Spot and On-Demand capacity types.
- Deploy across multiple Availability Zones.

---
### Useful Debugging Commands

```bash
kubectl get pods -A

kubectl get nodes

kubectl get nodepool

kubectl get ec2nodeclass

kubectl get nodeclaims

kubectl describe nodepool default

kubectl describe ec2nodeclass default

kubectl logs -n karpenter deployment/karpenter

kubectl get events --sort-by=.lastTimestamp
```

---
### Production Troubleshooting Checklist

Before investigating complex issues, verify the following:

- ✅ Karpenter controller is running.
- ✅ CRDs are installed.
- ✅ IAM Roles for Service Accounts (IRSA) is configured.
- ✅ Amazon EKS OIDC provider is enabled.
- ✅ EC2NodeClass is in the `Ready` state.
- ✅ NodePool is configured correctly.
- ✅ Subnets and security groups have the required discovery tags.
- ✅ IAM instance profile is valid.
- ✅ AWS service quotas are sufficient.
- ✅ Kubernetes events and Karpenter controller logs have been reviewed.

> **Tip**
>
> Most provisioning issues are caused by missing IAM permissions, incorrect discovery tags, invalid EC2NodeClass or NodePool configurations, or restrictive scheduling requirements. Reviewing Kubernetes events and Karpenter controller logs is usually the fastest way to identify the root cause.

---
## 🧹 Cleanup

After completing the demonstration or testing, remove the Kubernetes resources and AWS infrastructure to avoid unnecessary charges.

---

### Step 1: Delete the Test Workload

Remove the sample application used to trigger Karpenter autoscaling.

```bash
kubectl delete deployment inflate
```

Verify that the deployment has been removed.

```bash
kubectl get deployments
```

---
### Step 2: Delete the NodePool

Delete the NodePool to prevent Karpenter from provisioning new worker nodes.

```bash
kubectl delete nodepool default
```

Verify the NodePool has been removed.

```bash
kubectl get nodepool
```

---
### Step 3: Delete the EC2NodeClass

Delete the EC2NodeClass configuration.

```bash
kubectl delete ec2nodeclass default
```

Verify the EC2NodeClass has been removed.

```bash
kubectl get ec2nodeclass
```

---
### Step 4: Uninstall Karpenter

Delete the Karpenter deployment.

```bash
kubectl delete -f karpenter.yaml
```

Delete the Karpenter namespace.

```bash
kubectl delete namespace karpenter
```

---
### Step 5: Remove the Custom Resource Definitions (CRDs)

Delete the Karpenter Custom Resource Definitions.

```bash
kubectl delete crd nodepools.karpenter.sh

kubectl delete crd ec2nodeclasses.karpenter.k8s.aws

kubectl delete crd nodeclaims.karpenter.sh
```

Verify that the CRDs have been removed.

```bash
kubectl get crds | grep karpenter
```

---
### Step 6: Remove IAM Resources (Optional)

If the environment is no longer required, remove the IAM resources created for Karpenter.

- Delete the IAM Role
- Detach and delete the IAM Policy
- Delete the IAM Instance Profile
- Remove the IAM OIDC Provider *(only if the EKS cluster is being deleted)*

---
### Step 7: Remove Discovery Tags (Optional)

Remove the Karpenter discovery tags from the Amazon VPC resources if they are no longer needed.

**Subnet Tag**

```text
karpenter.sh/discovery=<cluster-name>
```

**Security Group Tag**

```text
karpenter.sh/discovery=<cluster-name>
```

---
### Step 8: Delete the Amazon EKS Cluster (Optional)

If this was a dedicated lab or demonstration environment, delete the Amazon EKS cluster and its associated AWS resources using Terraform.

```bash
terraform destroy
```

Review the execution plan and confirm the deletion when prompted.

---
### Verify Resource Cleanup

Confirm that all Karpenter resources have been removed.

```bash
kubectl get nodepool

kubectl get ec2nodeclass

kubectl get nodeclaims

kubectl get pods -n karpenter
```

Verify that no Karpenter-managed EC2 instances remain running in your AWS account.

---
### Cleanup Checklist

- ✅ Test workload removed
- ✅ NodePool deleted
- ✅ EC2NodeClass deleted
- ✅ Karpenter controller uninstalled
- ✅ Karpenter namespace removed
- ✅ Karpenter CRDs deleted
- ✅ IAM resources removed (if no longer required)
- ✅ Discovery tags removed (optional)
- ✅ Amazon EKS cluster destroyed (optional)
- ✅ No Karpenter-managed EC2 instances remain

> **Note**
>
> If you are managing your infrastructure with **Terraform**, prefer using `terraform destroy` to remove AWS resources. This ensures that all infrastructure is deleted in the correct order and prevents orphaned resources that could continue to incur charges.

---
