variable "region" {
  description = "region"
}

variable "zone" {
  description = "zone"
}

variable "project_id" {
  description = "project id"
}

variable "argo_namespace" {
  description = "name space for argo"
}

variable "application_namespace" {
  description = "the namespace for the application"
}


#########################argooooooooooooooooo###############

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

##########################secrets############################3

variable "google_secretes" {
  type = object({
    bitnami_tls-crt     = string
    bitnami_tls-key     = string
    repo_sshPrivateKey2 = string
    repo_sshPrivateKey1 = string
  })
  description = "all of the secrets from google-secret"
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
  description = "gitops_repo2_stff"
}

####################################n3tw0rk###############


variable "vpc" {
  type = object({
    name                    = string
    auto_create_subnetworks = string
    routing_mode            = string
  })
  description = "vpc values"
}

variable "subnet" {
  type = object({
    name          = string
    ip_cidr_range = string
  })
  description = "subnets values"
}

variable "firewall" {
  type = object({
    name          = string
    protocol      = string
    ports         = list(string)
    source_ranges = list(string)
  })
}

#################################compute#########################


variable "cluster_service_account" {
  type = object({
    account_id   = string
    display_name = string
  })
  description = "the service acount to create"
}

variable "artifact_role" {
  type        = string ################bonus make iut a list ####################33
  description = "lists of role to add"
}

variable "bucket_role" {
  type        = string ################bonus make iut a list ####################33
  description = "lists of role to add"
}


variable "cluster_name" {
  type        = string
  description = "the cluster name"
}

variable "primary_preemptible_nodes" {
  type = object({
    name                = string
    node_count_per_zone = number
    node_image          = string
    oauth_scopes        = list(string)
    node_locations      = list(string)
    disk_size_gb        = number
  })
}