variable "cloud_env" {
  description = "can be either la or mine"
}
variable "vpc_creation" {
  description = "if we need to create VPC",
  default = true
}
variable "region" {
  type= "map"
}

variable "access_key" {
   type = "map"

}
variable "secret_key" {
  type = "map"
}

#### instance details ####
variable "instance_public_key" {}

variable "ansible_public_key" {}
variable "instance_ami" {}
variable "instance_type" {}
