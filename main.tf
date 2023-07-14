terraform {
  required_version = ">=0.12"
  backend "s3" {
    bucket = "remotebucketidris"
    key = "OLWATOBI.tfstate"
    region = "us-east-2"
  }
}
module "my_network" {
  source = "./module/network"
  vpc_cidr_block  = var.vpc_cidr_block
  project_name = var.project_name
  public_subnet_cidr = var.public_subnet_cidr
  private_app_subnet_cidr = var.private_app_subnet_cidr
  data_base_subnet_cidr = var.data_base_subnet_cidr
}