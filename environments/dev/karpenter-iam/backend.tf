terraform {

  backend "s3" {

    bucket       = "retail-platform-bootstrap-tf-state-219834006508"
    key          = "dev/karpenter-iam/terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }
}