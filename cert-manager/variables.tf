variable "kube_namespace" {
  default     = "cert-manager"
  type        = string
  description = "Namespace where the cert-manager will be deployed"
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
