resource "helm_release" "gha_runners" {
  name             = "${var.runner_name}-release"
  chart            = "${path.module}/runner-deployment/"
  namespace        = var.kube_namespace
  create_namespace = var.create_namespace

  # Values from templatefile
  values = [
    templatefile("${path.module}/values/runner-values.yaml.tpl", {
      runner_name    = var.runner_name
      org            = var.org
      repo           = var.repo
      kube_namespace = var.kube_namespace
    })
  ]

  # Extra values passed directly
  set = {
    name  = "runnerLabels"
    value = join(",", var.runner_labels)
  }
}

output "runner_name" {
  value = var.runner_name
}

output "kube_namespace" {
  value = var.kube_namespace
}
