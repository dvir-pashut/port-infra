##########project#############
project_id = "task-1-375619"
region     = "us-central1"
zone       = "us-central1-c"


##################argo#############
argo_namespace        = "argo"
application_namespace = "application"
app-of-apps-file      = "../applicationsfiles/app-of-apps.yaml"
argocd_helm_chart = {
  release_name = "argo"
  repository   = "https://argoproj.github.io/argo-helm"
  chart        = "argo-cd"
  namespace    = "argo"
  version      = "5.19.12"
  values_file  = "../argo_values/argo_values.yaml"
}

#################secrets#########################

google_secretes = {
  bitnami_tls-crt     = "bitnami_tls_cert"
  bitnami_tls-key     = "bitnami_tls_key"
  repo_sshPrivateKey2 = "sshPrivateKey2"
  repo_sshPrivateKey1 = "sshPrivateKey1"
}

gitops_repo1 = {
  name = "charts"
  url  = "git@github.com:dvir-pashut/port-charts.git"
}

gitops_repo2 = {
  name = "infra"
  url  = "git@github.com:dvir-pashut/port-infra.git"
}

####################################n3tw0rk###############

vpc = {
  name                    = "portfolio-vpc"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}

subnet = {
  ip_cidr_range = "10.10.0.0/24"
  name          = "portfolio-subnet"
}



firewall = {
  name          = "portfolio-firewall"
  ports         = ["443", "80", "22"]
  protocol      = "tcp"
  source_ranges = ["0.0.0.0/0"]
}


#################################compute###################

cluster_service_account = {
  account_id   = "for-the-nodes"
  display_name = "Service Account"
}

artifact_role = "roles/artifactregistry.reader"
bucket_role   = "roles/storage.admin"
cluster_name = "dvireview-gke"

primary_preemptible_nodes = {
  name                = "my-pool-of-nodes"
  node_count_per_zone = 1
  node_image          = "e2-highcpu-8"
  disk_size_gb        = 100

  oauth_scopes = [
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring",
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/servicecontrol",
    "https://www.googleapis.com/auth/service.management.readonly",
    "https://www.googleapis.com/auth/trace.append",
    "https://www.googleapis.com/auth/compute"
  ]

  node_locations = [
    "us-central1-c",
    "us-central1-b",
    "us-central1-f"
  ]
}