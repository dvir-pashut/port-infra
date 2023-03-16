variable "host" {
  description = "host endpoint"
}

variable "cluster_ca_certificate" {
  description = "cluster_ca_certificate"
}

variable "node_pull" {
  description = "node_pull"
}


variable "google_secretes" {
  type = object({
    bitnami_tls-crt     = string
    bitnami_tls-key     = string
    repo_sshPrivateKey2 = string
    repo_sshPrivateKey1 = string
  })
  description = "all of the secrets from google-secret"
}



variable "argo_namespace" {
  description = "the namespace of argocd"
}

variable "gitops_repo1" {
  type = object({
    name = string
    url  = string
  })
  description = "gitops_repo1_stff"
}

variable "gitops_repo2" {
  type = object({
    name = string
    url  = string
  })
  description = "gitops_repo1_stff"
}