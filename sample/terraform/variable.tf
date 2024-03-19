

variable "region" {
  description = "The aws region to deploy to."
  type        = string
  default     = "eu-west-1"
}

variable "availability_zones_count" {
  description = "The number of AZs."
  type        = number
  default     = 2
}

variable "project" {
  description = "Name of resources."
  # description = "Name of the project deployment."
  type = string
  default = "tes-app"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_bits" {
  description = "The number of subnet bits for the CIDR."
  type        = number
  default     = 8
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    "Project"     = "tes-app"
    "Environment" = "staging"
    "Owner"       = "Teslim"
  }
}
# define .env
variable "env" {
  description = "Environment"
  type        = string
  default     = "deployment"
}
############################################################################################################
variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  default = "tes-app-cluster"
}

# variable "kubeconfig_path" {
#   description = "Path to the kubeconfig file"
# }

# variable "prometheus_namespace" {
#   description = "Namespace to install Prometheus"
#   default     = "prometheus"
# }

# variable "grafana_namespace" {
#   description = "Namespace to install Grafana"
#   default     = "grafana"
# }

# variable "namespace" {
#   description = "Namespace to install pipeline"
#   default     = "argocd"
# }

# variable "grafana_password" {
#   description = "Password for Grafana admin user"
#     default     = "admin"
# }
