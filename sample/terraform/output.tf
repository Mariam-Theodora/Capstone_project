output "cluster_name" {
  value = aws_eks_cluster.tes-eks-cluster.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.tes-eks-cluster.endpoint
}

output "cluster_ca_certificate" {
  value = aws_eks_cluster.tes-eks-cluster.certificate_authority[0].data
}


# ###################
# output "grafana_url" {
#   value = "http://${helm_release.grafana.metadata.0.name}.${var.grafana_namespace}:80"
# }

# output "argocd_url" {
#   value = "https://${helm_release.argocd.metadata.0.name}.${var.argocd_namespace}:443"
# }
