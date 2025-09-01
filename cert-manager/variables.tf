variable "kube_namespace" {
  default     = "cert-manager"
  type        = string
  description = "Namespace where the cert-manager will be deployed"
}
