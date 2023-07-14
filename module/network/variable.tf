variable "vpc_cidr_block" {}
variable "project_name" {}
variable  "public_subnet_cidr" {
  description= "this is for public_subnet"
  type =  list(object({
    cidr_block = string
    name = string}))
}
variable  "private_app_subnet_cidr" {
  description= "this is for private_app_subnet"
  type =  list(object({
    cidr_block = string
    name = string}))
}

variable  "data_base_subnet_cidr" {
  description= "this is for private_app_subnet"
  type =  list(object({
    cidr_block = string
    name = string}))
}

