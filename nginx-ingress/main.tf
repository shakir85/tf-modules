resource "kubernetes_namespace" "nginx_ingress" {
  metadata {
    name = var.kube_namespace
  }
}

resource "helm_release" "nginx_ingress" {
  name       = "ingress-nginx"
  namespace  = kubernetes_namespace.nginx_ingress.metadata[0].name
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.13.1"

  values = [
    file("${path.module}/values.yaml")
  ]

  depends_on = [kubernetes_namespace.nginx_ingress]
}
