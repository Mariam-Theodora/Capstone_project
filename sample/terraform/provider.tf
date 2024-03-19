provider "aws" {
  region = var.region
}

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.tes-eks-cluster.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.tes-eks-cluster.certificate_authority[0].data)
    config_context_cluster = aws_eks_cluster.tes-eks-cluster.name
  }
}

provider "kubernetes" {
  host                   = aws_eks_cluster.tes-eks-cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.tes-eks-cluster.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    command     = "aws"
  }
}

