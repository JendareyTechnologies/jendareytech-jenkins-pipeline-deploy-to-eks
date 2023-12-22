variable "availability_zones" {
  description = "List of availability zones for subnets"
  type        = list(string)
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
}

variable "workstation_external_cidr" {
  description = "CIDR block for the external workstation"
}

# Add any additional variables you may need
