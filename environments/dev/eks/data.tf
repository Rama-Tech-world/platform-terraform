data "terraform_remote_state" "networking" {

  backend = "s3"

  config = {
    bucket = "retail-platform-bootstrap-tf-state-219834006508"
    key    = "dev/networking/terraform.tfstate"
    region = "eu-north-1"
  }
}

data "terraform_remote_state" "security" {

  backend = "s3"

  config = {
    bucket = "retail-platform-bootstrap-tf-state-219834006508"
    key    = "dev/security/terraform.tfstate"
    region = "eu-north-1"
  }
}

data "terraform_remote_state" "iam" {

  backend = "s3"

  config = {
    bucket = "retail-platform-bootstrap-tf-state-219834006508"
    key    = "dev/iam/terraform.tfstate"
    region = "eu-north-1"
  }
}

data "terraform_remote_state" "kms" {

  backend = "s3"

  config = {
    bucket = "retail-platform-bootstrap-tf-state-219834006508"
    key    = "dev/kms/terraform.tfstate"
    region = "eu-north-1"
  }
}