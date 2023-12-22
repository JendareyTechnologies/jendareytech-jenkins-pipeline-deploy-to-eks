# Define the EKS cluster
resource "aws_eks_cluster" "votingapp" {
  name     = var.cluster_name
  role_arn = aws_iam_role.votingapp-cluster.arn

  vpc_config {
    security_group_ids = [aws_security_group.votingapp-cluster.id]
    subnet_ids         = aws_subnet.public_subnets[*].id  # Using public subnets for simplicity, adjust as needed
  }

  depends_on = [
    aws_iam_role_policy_attachment.votingapp-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.votingapp-cluster-AmazonEKSServicePolicy,
  ]

  # Managed Node Groups
  eks_managed_node_groups = {
    prod-node = {
      min_size       = 1
      max_size       = 3
      desired_size   = 2
      instance_types = ["t2.medium"]
      volume_size    = 20
    }
    # Add more managed node groups if needed
  }
}
