# Define VPC
resource "aws_vpc" "votingapp" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "terraform-eks-votingapp"
  }
}

# Define private subnets
resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.votingapp.id
  cidr_block              = var.private_subnet_cidr_blocks[count.index]
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}

# Define public subnets
resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.votingapp.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

# Define security group rule for allowing workstation to communicate with the cluster API Server
resource "aws_security_group_rule" "votingapp-cluster-ingress-workstation-https" {
  cidr_blocks       = [var.workstation_external_cidr]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.votingapp-cluster.id
  to_port           = 443
  type              = "ingress"
}



# Define security group for EKS cluster communication
resource "aws_security_group" "votingapp-cluster" {
  name        = "terraform-eks-votingapp-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.votingapp.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-votingapp"
  }
}

# Define security group rule for allowing workstation to communicate with the cluster API Server
resource "aws_security_group_rule" "votingapp-cluster-ingress-workstation-https" {
  cidr_blocks       = [local.workstation_external_cidr]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.votingapp-cluster.id
  to_port           = 443
  type              = "ingress"
}

