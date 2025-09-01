resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = var.kube_namespace
  create_namespace = true
  version          = "1.17.2"

  set = [{
    name  = "prometheus.enabled"
    value = "false"
    },
    {
      name  = "crds.enabled"
      value = "true"
    },
    {
      name  = "crds.keep"
      value = "false"
  }]

  values = [
    yamlencode({
      global = {
        commonLabels = {
          "app.kubernetes.io/managed-by" = "terraform"
        }
      }
    })
  ]
}
