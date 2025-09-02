resource "kubernetes_role" "gha_target_ns_role" {
  for_each = toset(var.target_namespaces)

  metadata {
    name      = "${var.role_name}-role"
    namespace = each.value
    labels    = var.shared_labels
  }

  # Core API resources - pods, services, configmaps, SAs
  rule {
    api_groups = [""]
    resources  = ["pods", "services", "configmaps", "persistentvolumeclaims", "persistentvolumes", "serviceaccounts"]
    verbs      = ["get", "list", "create", "update", "patch", "delete"]
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["get", "list", "create", "update", "patch", "delete"]

  }

  # Workloads
  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "replicasets", "statefulsets", "daemonsets"]
    verbs      = ["get", "list", "create", "update", "patch", "delete"]
  }

  # Ingress resources
  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses"]
    verbs      = ["get", "list", "create", "update", "patch", "delete"]
  }

}

resource "kubernetes_role_binding" "gha_target_ns_binding" {
  for_each = toset(var.target_namespaces)

  metadata {
    name      = "${var.role_name}-binding"
    namespace = each.value
    labels    = var.shared_labels
  }

  role_ref {
    kind      = "Role"
    name      = kubernetes_role.gha_target_ns_role[each.value].metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    name      = var.runner_service_account_name      # runner-sa
    namespace = var.runner_service_account_namespace # pass from gha-runner module in root
  }

  depends_on = [kubernetes_role.gha_target_ns_role]
}
