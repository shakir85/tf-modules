resource "helm_release" "gha_runners" {
  name             = "${var.runner_name}-release"
  chart            = "${path.module}/runner-deployment/"
  namespace        = var.kube_namespace
  create_namespace = var.create_namespace

  values = [
    templatefile("${path.module}/values/runner-values.yaml.tpl", {
      runner_name     = var.runner_name
      org             = var.org
      repo            = var.repo
      kube_namespace  = var.kube_namespace
      rbac_namespaces = var.rbac_namespaces
    })
  ]
}

# ** Roles & Bindings resources
# -- Give the runners enough permissions to deploy to the same cluster across namespaces.
# -- The below logic is ugly logic but will optimize later.
#
# For each namespace in rbac_namespaces, create a Role and name it: '<runner_name>-role'
resource "kubernetes_role" "this" {
  for_each = toset(var.rbac_namespaces)

  metadata {
    name      = "${var.runner_name}-role"
    namespace = each.value
    labels    = var.shared_labels
  }

  # Core API resources - pods, services, configmaps, SAs
  rule {
    api_groups = [""]
    resources  = ["pods", "services", "configmaps", "persistentvolumeclaims", "persistentvolumes", "serviceaccounts", "statefulsets"]
    verbs      = ["get", "list", "create", "update", "patch", "delete"]
  }
  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["get", "list", "create", "update", "patch", "delete"]
  }
  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "replicasets"]
    verbs      = ["get", "list", "create", "update", "patch", "delete"]
  }
  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses"]
    verbs      = ["get", "list", "create", "update", "patch", "delete"]
  }
}

# For each namespace in rbac_namespaces, create a RoleBinding that binds the above Role to the ServiceAccount created by the Helm chart
# SA account name is always '<runner_name>-sa' per the included chart.
resource "kubernetes_role_binding" "this" {
  for_each = toset(var.rbac_namespaces)

  metadata {
    name      = "${var.runner_name}-binding"
    namespace = each.value
    labels    = var.shared_labels
  }

  role_ref {
    kind      = "Role"
    name      = kubernetes_role.this.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "${var.runner_name}-sa"
    namespace = var.kube_namespace
  }

  depends_on = [kubernetes_role.this]
}
