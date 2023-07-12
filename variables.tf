# From https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/variables.tf

################################################################################
# Cluster
################################################################################

variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "cluster_node_locations" {
  description = "AZ for nodes - this should match the region"
  type        = list(string)
}

################################################################################
# Network
################################################################################

variable "cluster_network_name" {
  description = "Network name for the cluster"
  type        = string
}
variable "cluster_subnetwork_id" {
  description = "Subnetwork name for the cluster."
  type        = string
}
variable "cluster_master_ipv4_cidr_block" {
  description = "Master nodes ipv4 cidr"
  type        = string
}

variable "cluster_secondary_range_name" {
  default     = "pods"
  type        = string
  description = "VPC Secondary range name for pods"
}

variable "services_secondary_range_name" {
  default     = "services"
  type        = string
  description = "VPC Secondary range name for services"
}

################################################################################
# Generic
################################################################################


variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "region"
  type        = string
}

variable "project" {
  description = "GCP Project"
  type        = string
}