locals {
  default_tags = {
    Terraform = "true"
    Env       = var.env
  }

  name = "tes-app-cluster"
  vpc_cidr = "10.0.0.0/16"
  azs      = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  create_workloads = true
}