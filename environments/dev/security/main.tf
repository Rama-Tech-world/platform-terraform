data "terraform_remote_state" "networking" {

  backend = "s3"

  config = {

    bucket = "retail-platform-bootstrap-tf-state-219834006508"
    key    = "dev/networking/terraform.tfstate"
    region = "eu-north-1"
  }
}

module "security_group" {

  source = "../../../modules/security-group"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = data.terraform_remote_state.networking.outputs.vpc_id

}