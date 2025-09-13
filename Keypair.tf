resource "aws_key_pair" "myapp-key" {
  key_name   = "server-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA4f/Peb7BDgflAM7s09Wdfe677N6OAfVz1JM9tBjVxp aadil@aadils-MacBook-Air.local"
}
