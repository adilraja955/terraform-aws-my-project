resource "aws_security_group" "development_sg" {
  name        = "development-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.development_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.route]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.route]
  }
  tags = {
    Name = "development-sg"
  }
}