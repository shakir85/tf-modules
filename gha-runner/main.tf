resource "helm_release" "gha_runners" {
  name             = "${var.runner_name}-release"
  chart            = "${path.module}/runner-deployment/"
  namespace        = var.kube_namespace
  create_namespace = var.create_namespace

  values = [
    {
      name       = var.runner_name
      repository = "${var.org}/${var.repo}"
      namespace  = var.kube_namespace
      labels = {
        "app.kubernetes.io/managed-by" = "terraform"
        "repository/name"              = var.repo
      }
      podLabels = {
        "app.kubernetes.io/managed-by" = "terraform"
        "repository/name"              = var.repo
      }
    }
  ]
}
