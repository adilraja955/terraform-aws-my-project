data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "myapp_server" {
    ami           = data.aws_ami.latest_amazon_linux.id
    instance_type = var.instance_type
    key_name      = aws_key_pair.myapp-key.key_name
    subnet_id     = aws_subnet.development_subnet_pub_1.id
    vpc_security_group_ids = [aws_security_group.development_sg.id]
    availability_zone = var.zone[0]
    associate_public_ip_address = true
    tags = {
        Name = "myapp-server"
    }
    user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y && sudo yum install docker -y
                sudo systemctl start docker
                sudo systemctl enable docker
                sudo usermod -a -G docker ec2-user
                sudo docker run -d -p 8080:80 --name myapp nginx
                EOF
}

resource "aws_instance" "myapp_db_1" {
    ami           = data.aws_ami.latest_amazon_linux.id
    instance_type = var.instance_type
    subnet_id     = aws_subnet.development_subnet_priv_1.id
    availability_zone = var.zone[0]
    tags = {
        Name = "myapp-db-server-1"
    }
}
resource "aws_instance" "myapp_db_2" {
    ami           = data.aws_ami.latest_amazon_linux.id
    instance_type = var.instance_type
    subnet_id     = aws_subnet.development_subnet_priv_2.id
    availability_zone = var.zone[1]
    tags = {
        Name = "myapp-db-server-2"
    }
}