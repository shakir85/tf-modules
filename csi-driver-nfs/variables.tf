variable "kube_namespace" {
  description = "Kubernetes namespace for csi-driver-nfs"
  type        = string
  default     = "kube-system"
}

variable "config_path" {
  description = "Path to the Kubernetes config file"
  type        = string
  default     = null
}

variable "config_context" {
  description = "Kubernetes context to use"
  type        = string
  default     = null
}
