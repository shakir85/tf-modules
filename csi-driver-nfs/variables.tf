variable "chart_version" {
  description = "Helm chart version for csi-driver-nfs"
  type        = string
}

variable "kube_namespace" {
  description = "Kubernetes namespace for csi-driver-nfs"
  type        = string
  default     = "kube-system"
}
