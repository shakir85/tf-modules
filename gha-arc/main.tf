resource "kubernetes_secret_v1" "controller_manager" {
  metadata {
    name      = "controller-manager"
    namespace = var.arc_namespace
    labels = {
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }

  data = {
    github_app_id              = var.github_app_id
    github_app_installation_id = var.github_app_installation_id
    github_app_private_key     = file(var.github_app_private_key)
  }

  type = "Opaque"
}

resource "helm_release" "actions_runner_controller" {
  name             = "actions-runner-controller"
  namespace        = var.arc_namespace
  create_namespace = true
  repository       = "https://actions-runner-controller.github.io/actions-runner-controller"
  chart            = "actions-runner-controller"
  version          = "0.23.7"

  set = [{
    name  = "syncPeriod"
    value = "1m"
    },
    {
      name  = "containerMode.type"
      value = "kubernetes"
  }]

  values = [
    yamlencode({
      labels = {
        "app.kubernetes.io/managed-by" = "terraform"
      }
      podLabels = {
        "app.kubernetes.io/managed-by" = "terraform"
      }
    })
  ]

  depends_on = [
    kubernetes_secret_v1.controller_manager
  ]
}
