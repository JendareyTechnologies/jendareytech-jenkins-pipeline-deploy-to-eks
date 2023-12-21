terraform {
  backend "s3" {
    bucket = "jendareybucketclass"
    key    = "terraform/backend/eks/terraform.tfstate"
    region = "us-east-1"
  }
}
