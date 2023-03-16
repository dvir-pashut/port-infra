
module "network" {
  source   = "./modules/networks"
  region   = var.region
  vpc      = var.vpc
  subnet   = var.subnet
  firewall = var.firewall
}

module "compute" {
  source                    = "./modules/cluster"
  subnet_name               = module.network.subnet_name
  vpc_name                  = module.network.vpc_name
  region                    = var.region
  project                   = var.project_id
  cluster_service_account   = var.cluster_service_account
  cluster_name              = var.cluster_name
  artifact_role             = var.artifact_role
  bucket_role               = var.bucket_role
  primary_preemptible_nodes = var.primary_preemptible_nodes
}


module "argo" {
  source                 = "./modules/argo"
  host                   = module.compute.cluster_endpoint
  cluster_ca_certificate = module.compute.cluster_ca_certificate
  node_pull              = module.compute.node_pull

  argo_namespace        = var.argo_namespace
  application_namespace = var.application_namespace
  argocd_helm_chart     = var.argocd_helm_chart
  app-of-apps-file      = var.app-of-apps-file
}


module "secrets" {
  source                 = "./modules/secrets"
  host                   = module.compute.cluster_endpoint
  cluster_ca_certificate = module.compute.cluster_ca_certificate
  node_pull              = module.compute.node_pull
  google_secretes        = var.google_secretes
  argo_namespace         = var.argo_namespace
  gitops_repo1           = var.gitops_repo1
  gitops_repo2           = var.gitops_repo2
}