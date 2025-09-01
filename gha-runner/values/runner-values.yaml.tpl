name: ${runner_name}
repository: "${org}/${repo}"
namespace: "${kube_namespace}"
labels:
  app.kubernetes.io/managed-by: terraform
  repository/name: ${repo}
podLabels:
  app.kubernetes.io/managed-by: terraform
  repository/name: ${repo}
rbac:
  namespaces:
%{ for ns in rbac_namespaces ~}
    - ${ns}
%{ endfor ~}
