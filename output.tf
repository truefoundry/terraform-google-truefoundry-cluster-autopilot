# From https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/outputs.tf

################################################################################
# Cluster
################################################################################

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = google_container_cluster.cluster.endpoint
}

output "cluster_id" {
  description = "The name/id of the EKS cluster. Will block on cluster creation until the cluster is really ready"
  value       = google_container_cluster.cluster.id
}

output "cluster_master_version" {
  description = "Master version for the cluster"
  value       = google_container_cluster.cluster.master_version
}
