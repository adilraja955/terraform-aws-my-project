variable "region" {
  description = "AWS region"
}
variable "zone" {
  description = "availability zones"
  type        = list(string)
}
variable "cidr_block" {
  description = "cidr blocks for vpc and subnets"
  type        = list(string)
}
variable "route" {}
variable "instance_type" {}
variable "my_ip" {
  description = "Your IP address with CIDR notation"
}

