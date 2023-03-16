output "cluster_endpoint" {
  value       = google_container_cluster.primary.endpoint
  description = "endpoint for connections"
}


output "cluster_ca_certificate" {
  value       = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
  description = "cert for connections"
}

output "node_pull" {
  value       = google_container_node_pool.primary_preemptible_nodes
  description = "for the helm depends on"
}