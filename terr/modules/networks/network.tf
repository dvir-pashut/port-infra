# VPC
resource "google_compute_network" "vpc" {
  name                    = var.vpc.name
  auto_create_subnetworks = var.vpc.auto_create_subnetworks
  routing_mode            = var.vpc.routing_mode ### for the subnets
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet.name
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = var.subnet.ip_cidr_range
}



# resource "google_compute_firewall" "example_firewall" {
#   name    = var.firewall.name
#   network = google_compute_network.vpc.name

#   allow {
#     protocol = var.firewall.protocol
#     ports    = var.firewall.ports
#   }

#   source_ranges = var.firewall.source_ranges

#   depends_on = [
#     google_compute_network.vpc,
#     google_compute_subnetwork.subnet
#   ]
# }