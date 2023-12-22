availability_zones        = ["us-west-2a", "us-west-2b", "us-west-2c"]
private_subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnet_cidr_blocks  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
cluster_name               = "my-eks-cluster"
workstation_external_cidr  = "X.X.X.X/32"  # Replace with your actual CIDR block
