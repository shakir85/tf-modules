variable "kube_namespace" {
  type        = string
  default     = "metallb-system"
  description = "Namespace where MetalLB should be installed. Default to `metallb-system` (this is a standard MetalLB namespace, don't change for no reason.)"
}

variable "create_namespace" {
  type        = bool
  description = "Whether to create the namespace"
}
