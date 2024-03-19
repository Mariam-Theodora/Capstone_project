resource "helm_release" "argocd" {
  count = local.create_workloads == true ? 1 : 0

  name       = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.23.3"

  namespace        = "argocd"
  create_namespace = true

  values = [
    templatefile("apps/values.yaml", { env = var.env } )
  ]
}

resource "helm_release" "argocd_apps" {
  count = local.create_workloads == true ? 1 : 0

  name       = "argo-cd-apps"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-apps"
  version    = "0.0.8"

  #   namespace for argocd-apps
  namespace        = "argocd"
  create_namespace = true

  values = [
    templatefile("apps/chart.yaml", { env = var.env })
  ]

  depends_on = [
    helm_release.argocd
  ]
}
# resource "helm_release" "prometheus" {
#   name       = "prometheus"
#   repository = "https://prometheus-community.github.io/helm-charts"
#   chart      = "prometheus"
#   namespace  = var.namespace
#   create_namespace = true
# }


# resource "helm_release" "grafana" {
#   name      = "grafana"
#   repository = "https://grafana.github.io/helm-charts"
#   chart      = "grafana"
#   namespace  = var.namespace
#   create_namespace = true

#   set {
#     name  = "adminPassword"
#     value = var.namespace
# }

# }

