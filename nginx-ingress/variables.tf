variable "kube_namespace" {
  description = "The namespace where the ingress controller will be deployed"
  type        = string
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
