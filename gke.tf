resource "google_container_cluster" "cluster" {
  provider       = google-beta
  project        = var.project
  name           = var.cluster_name
  location       = var.region
  node_locations = var.cluster_node_locations

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  initial_node_count = 1

  network    = var.cluster_network_name
  subnetwork = var.cluster_subnetwork_id

  enable_autopilot = true

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.cluster_master_ipv4_cidr_block
  }

  # Configuration of cluster IP allocation for VPC-native clusters
  ip_allocation_policy {
    cluster_secondary_range_name  = var.cluster_secondary_range_name
    services_secondary_range_name = var.services_secondary_range_name
  }

  release_channel {
    channel = "REGULAR"
  }
  vertical_pod_autoscaling {
    enabled = true
  }

}

/******************************************
  CRD are broken in GKE
  https://github.com/kubernetes/kubernetes/issues/79739
 *****************************************/
resource "google_compute_firewall" "fix_webhooks" {
  # count       = var.add_cluster_firewall_rules || var.add_master_webhook_firewall_rules ? 1 : 0
  name        = "${var.cluster_name}-webhook"
  description = "Allow Nodes access to Control Plane"
  project     = var.project
  network     = var.cluster_network_name
  priority    = 1000
  direction   = "INGRESS"

  source_ranges = [
    "${google_container_cluster.cluster.endpoint}/32",
    var.cluster_master_ipv4_cidr_block
  ]

  allow {
    protocol = "tcp"
    ports    = ["443", "8443", "9443", "15017"]
  }

  depends_on = [
    google_container_cluster.cluster
  ]
}