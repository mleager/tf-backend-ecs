data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "mleager"
    workspaces = {
      name = "aws-vpc"
    }
  }

  # backend = "s3"
  #
  # config = {
  #   bucket = "tf-state-8864"
  #   key    = "tf-networking/terraform.tfstate"
  #   region = var.region
  # }
}

locals {
  vpc_id          = data.terraform_remote_state.vpc.outputs.vpc_id
  public_subnets  = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  private_subnets = data.terraform_remote_state.vpc.outputs.private_subnet_ids
}

