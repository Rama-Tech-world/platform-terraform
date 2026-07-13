aws_region   = "eu-north-1"
project_name = "retail-platform"
environment  = "dev"

vpc_cidr = "10.0.0.0/16"

availability_zones = [
  "eu-north-1a",
  "eu-north-1b",
  "eu-north-1c"
]

public_subnet_cidrs = [
  "10.0.0.0/20",
  "10.0.16.0/20",
  "10.0.32.0/20"
]

private_app_subnet_cidrs = [
  "10.0.48.0/20",
  "10.0.64.0/20",
  "10.0.80.0/20"
]

private_db_subnet_cidrs = [
  "10.0.96.0/20",
  "10.0.112.0/20",
  "10.0.128.0/20"
]

enable_flow_logs  = true
single_nat_gateway = true