data "terraform_remote_state" "eks" {

  backend = "s3"

  config = {

    bucket = "retail-platform-bootstrap-tf-state-219834006508"

    key = "dev/eks/terraform.tfstate"

    region = "eu-north-1"
  }
}