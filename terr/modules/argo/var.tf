variable "host" {
  description = "host endpoint"
}

variable "cluster_ca_certificate" {
  description = "cluster_ca_certificate"
}

variable "node_pull" {
  description = "node_pull"
}

variable "argo_namespace" {
  description = "name space for argo"
}

variable "application_namespace" {
  description = "the namespace for the application"
}

variable "argocd_helm_chart" {
  type = object({
    release_name = string
    repository   = string
    chart        = string
    namespace    = string
    version      = string
    values_file  = string
  })
  description = "ArgoCD helm chart configuration"
}




variable "app-of-apps-file" {
  description = "the file itself"
}
