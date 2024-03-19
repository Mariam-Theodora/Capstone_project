# We deploy our microservices-based architecture on Kubernetes and we need to create a clear IaaC (Infrastructure as Code) deployment to be able to deploy our services in a fast manner.

## Setup Details:
* Provision a webapp of your choosing with nginx/httpd frontend proxy and a database
(mongo, postgresql etc) backend .
* Provision the Socks Shop example microservice application -
https://microservices-demo.github.io/

### Prerequisite:

* AWS account

* AWS CLI

* Kubectl

* Terraform

* Helm

* ArgoCD

* Docker

* Github repo

# Steps:
After installing the prerequisite, we need to configure the AWS CLI.
* Configure the AWS CLI

```bash 
 aws configure
 ```

$ AWS Access Key ID [None]: <YOUR_AWS_ACCESS_KEY_ID>

$ AWS Secret Access Key [None]: <YOUR_AWS_SECRET_ACCESS_KEY>

$ Default region name [None]: <YOUR_AWS_REGION>

## Terraform Initial Setup Configuration
Create an AWS provider. it will be used to interact the resources in AWS such as EKS, VPC, etc.
* Create a new directory for your project and change into it.
* Create a new file called provider.tf and add the following ref: terraform/provider.tf

## Terraform state file
Create terraform backend to specify the location of the state file on S3 bucket.
note: Remote state is a Terraform feature that allows you to store the state file in a remote location. This is useful when you are working with a team and want to share the state file.
* Create a new file called backend.tf and add the following ref: terraform/backend.tf

## Network Setup
Setup the VPC, Subnets, Internet Gateway, Route Table, Security Group, etc.
* Create a new file called network.tf and add the following ref: terraform/network.tf

## EKS Cluster Setup
1. Create an EKS cluster
2. Setup IAM roles and policies for the cluster
IAM roles and policies are used to control access to AWS resources. In this case, we will create a role that will allow the EKS cluster to access other AWS resources.
* Create a new file called eks.tf and add the following ref: terraform/eks.tf

## EKS Node Group Setup
Create a node group to run appplication workloads.
IAM Role: similar to the cluster role, we will create a role that will allow the nodes to access other AWS resources.
IAM Policy: Attach the AmazonEKSWorkerNodePolicy, AmazonEKS_CNI_Policy policies and AmazonEC2ContainerRegistryReadOnly policy to the role.
Create a new file called node.tf and add the following ref: terraform/node.tf

## Terraform variables
Define variables for the project.
* Create a new file called variables.tf and add the following ref: terraform/variable.tf

## Terraform locals
Define locals for the project.
* Create a new file called locals.tf and add the following ref: terraform/locals.tf

## ArgoCD Setup
Setup ArgoCD to deploy the application.
* Create a new file called argocd.tf and add the following ref: terraform/argocd.tf

## Define data sources
Define data sources for the project.
* Create a new file called data.tf and add the following ref: terraform/data.tf

## Terraform outputs
 Define outputs for the project.
* Create a new file called outputs.tf and add the following ref: terraform/output.tf

## Let's run the terraform

* Initialize the terraform

```bash
 terraform init
```

* Validate the terraform

```bash
 terraform validate
```

* Plan the terraform

```bash
 terraform plan
```

* Apply the terraform

```bash
 terraform apply
```

*After terraform apply, the infrastructure could'nt reploy the argocd application. We need to manually deploy the argocd application.

* Deploy the argocd application

* first, we need to add the cluster to our local kubectl config.

```bash
aws eks --region <YOUR_AWS_REGION> update-kubeconfig --name <YOUR_EKS_CLUSTER_NAME>
```

* Create a namespace for the argocd application

```bash
 kubectl create namespace argocd
```

* Add the argocd helm repo

```bash
 helm repo add argo-cd https://argoproj.github.io/argo-helm -n argocd
```

* Install the argocd application

```bash
 helm install argocd argo-cd/argo-cd -n argocd
```

* Confirm installation

```bash
 kubectl get pods -n argocd
```

* Expose the argocd application

by default, the argocd application is not exposed to an external IP address. 
* We need to expose the argocd application to a load balancer.

```bash
 kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}' -n argocd
 ```

* Get the argocd application password

```bash
 kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d; echo -n argocd
```

to login to the argocd application

* Get the argocd application load balancer

```bash
 kubectl get svc -n argocd
```

use the load balancer to login to the argocd application

## Connecting ArgoCD to git repo

* Open the repository management menu and click on "Repositories" tab.

* Connect repo using https

* Add the repo url and click on "Connect"

## Setup argocd app of apps

### App Creation Page

* Click on "New App" button

* Fill the form with the following details:

* Application Name: root

* Project: default

* Sync Policy: Automatic

* Sync Options: auto create namespace

* Cluster: https://kubernetes.default.svc

* repo url: select the repo url

* Path: select the path

* Revision: HEAD

* Click on "Create" button

### App Details Page

* Click on "Sync" button

## Deploy other applications using helm charts

Traditionally, in Argo CD, we can deploy applications with configurations in manifests that are the same as those we run ‘kubectl apply’ on. However, in our case, we use Helm charts (because it’s easier).

### The /apps directory is the place where we store all the applications that we want to deploy.

* Go to the argocd application and click on sync button



* ref: https://medium.com/devops-mojo/terraform-provision-amazon-eks-cluster-using-terraform-deploy-create-aws-eks-kubernetes-cluster-tf-4134ab22c594

* ref: https://faun.pub/continuous-deployments-of-kubernetes-applications-using-argo-cd-gitops-helm-charts-9df917caa2e4


