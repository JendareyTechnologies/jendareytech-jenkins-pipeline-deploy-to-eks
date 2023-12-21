module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 19.0"
    cluster_name = "votingapp-eks-cluster"
    cluster_version = "1.27"

    cluster_endpoint_public_access  = true

    vpc_id = module.jendarey_vpc_eks.vpc_id
    subnet_ids = module.jendarey_vpc_eks.private_subnets

    tags = {
        environment = "production"
        application = "votingapp"
    }

    eks_managed_node_groups = {
        prod = {
            min_size = 1
            max_size = 3
            desired_size = 2
            instance_types = ["t2.medium"]
            volume_size    = 20
        }
    }
}
