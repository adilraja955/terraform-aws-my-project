variable "region" {
  default = "us-east-1"
}
variable "zone" {
  description = "availability zones"
  type        = list(string)
}
variable "cidr_block" {
  description = "cidr blocks for vpc and subnets"
  type        = list(string)
}
variable "route" {
  description = "default route table"
}