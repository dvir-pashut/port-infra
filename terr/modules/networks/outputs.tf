output "vpc_name" {
  value       = google_compute_network.vpc.name
  description = "name of the vpc"
}


output "subnet_name" {
  value       = google_compute_subnetwork.subnet.name
  description = "name of the subnet"
}