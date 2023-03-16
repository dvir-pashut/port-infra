
variable "vpc_name" {
  description = "vpc_name"
}

variable "subnet_name" {
  description = "subnet_name"
}

variable "region" {
  description = "region"
}

variable "project" {
  description = "project id"
}

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