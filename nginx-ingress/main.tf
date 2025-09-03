resource "helm_release" "nginx_ingress" {
  name             = "ingress-nginx"
  namespace        = var.kube_namespace
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.10.0"
  create_namespace = var.create_namespace

  values = [
    file("${path.module}/values.yaml")
  ]
}
