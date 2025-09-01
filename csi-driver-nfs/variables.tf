variable "kube_namespace" {
  description = "Kubernetes namespace for csi-driver-nfs"
  type        = string
  default     = "kube-system"
}
