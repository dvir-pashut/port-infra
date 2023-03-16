
############role for the nodes##############3
resource "google_service_account" "cluster-service_account" {
  account_id   = var.cluster_service_account.account_id
  display_name = var.cluster_service_account.display_name
}

resource "google_project_iam_member" "artifact_role" {
  role    = var.artifact_role
  member  = "serviceAccount:${google_service_account.cluster-service_account.email}"
  project = var.project
}


resource "google_project_iam_member" "bucket_role" {
  role    = var.bucket_role
  member  = "serviceAccount:${google_service_account.cluster-service_account.email}"
  project = var.project
}


##################the cluster himself+coustumed node pool##############
resource "google_container_cluster" "primary" {
  name       = var.cluster_name
  location   = var.region
  network    = var.vpc_name
  subnetwork = var.subnet_name
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}
resource "google_container_node_pool" "primary_preemptible_nodes" {
  name    = var.primary_preemptible_nodes.name
  cluster = google_container_cluster.primary.id

  node_locations = var.primary_preemptible_nodes.node_locations

  node_count = var.primary_preemptible_nodes.node_count_per_zone

  # autoscaling {
  #   min_node_count = 1
  #   max_node_count = 3
  # }

  node_config {
    preemptible  = true
    machine_type = var.primary_preemptible_nodes.node_image
    disk_size_gb = var.primary_preemptible_nodes.disk_size_gb

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.cluster-service_account.email
    oauth_scopes    = var.primary_preemptible_nodes.oauth_scopes
  }

  depends_on = [
    google_container_cluster.primary,
    google_project_iam_member.artifact_role
  ]
}