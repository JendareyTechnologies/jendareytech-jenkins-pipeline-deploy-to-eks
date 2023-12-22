# Define IAM role for the EKS cluster
resource "aws_iam_role" "votingapp-cluster" {
  name = "terraform-eks-votingapp-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Attach policies to the IAM role
resource "aws_iam_role_policy_attachment" "votingapp-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.votingapp-cluster.name
}

resource "aws_iam_role_policy_attachment" "votingapp-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.votingapp-cluster.name
}
