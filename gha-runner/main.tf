resource "helm_release" "gha_runners" {
  name             = "${var.runner_name}-release"
  chart            = "${path.module}/runner-deployment/"
  namespace        = var.kube_namespace
  create_namespace = var.create_namespace

  values = [
    yamldecode(templatefile("${path.module}/values/runner-values.yaml.tpl", {
      runner_name     = var.runner_name
      org             = var.org
      repo            = var.repo
      kube_namespace  = var.kube_namespace
      rbac_namespaces = jsonencode(var.rbac_namespaces)
    }))
  ]
}
