resource "kubernetes_namespace" "nginx_ingress" {
  metadata {
    name = var.kube_namespace
  }
}

resource "helm_release" "nginx_ingress" {
  name       = "ingress-nginx"
  namespace  = var.kube_namespace
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.13.1"

  values = [
    yamlencode({
      controller = {
        kind               = "DaemonSet"
        ingressClassByName = true
        service = {
          type = "LoadBalancer"
          port = {
            http = 80
          }
        }
        fullnameOverride = "nginx-controller"
      }
    })
  ]

  depends_on = [kubernetes_namespace.nginx_ingress]
}
