name: ${runner_name}
repository: "${org}/${repo}"
namespace: "${kube_namespace}"
labels:
  app.kubernetes.io/managed-by: terraform
  repository/name: ${repo}
podLabels:
  app.kubernetes.io/managed-by: terraform
  repository/name: ${repo}
%{ for s in rbac_namespaces ~}
rbac:
  namespaces: ${s}
%{ endfor ~}
