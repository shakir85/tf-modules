variable "arc_namespace" {
  description = "The name of the namespace where ARC will be deployed"
  type        = string
  default     = "arc-system"
}

variable "github_app_id" {
  description = "GitHub App ID"
  type        = string
}

variable "github_app_installation_id" {
  description = "GitHub App Installation ID"
  type        = string
}

variable "github_app_private_key" {
  description = "Path to the GitHub App private key file"
  type        = string
}
