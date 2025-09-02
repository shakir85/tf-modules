resource "helm_release" "nginx_ingress" {
  name             = "ingress-nginx"
  namespace        = var.kube_namespace
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.10.0"
  create_namespace = true

  values = [
    yamlencode({
      controller = {
        kind = "DaemonSet"
        ingressClassResource = {
          name            = var.ingress_controller_name
          enabled         = true
          controllerValue = "k8s.io/ingress-nginx"
        }
        ingressClass       = var.ingress_controller_name
        ingressClassByName = true
        service = {
          type = "LoadBalancer"
          port = {
            http = 80
          }
        }
        fullnameOverride = "nginx-controller"
      }
      labels = {
        "app.kubernetes.io/managed-by" = "terraform"
      },
      podLabels = {
        "app.kubernetes.io/managed-by" = "terraform"
      },
      commonLabels = {
        "app.kubernetes.io/managed-by" = "terraform"
      }
    })
  ]
}
