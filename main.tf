provider "aws"{
    region = "eu-west-2"
}

resource "aws_instance" "example" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instance.id]
    
    user_data = <<-EOF
           #!/bin/bash
           echo "Hello, World" > index.html
           nohup busybox httpd -f -p 8080 & 
           EOF
    
    tags = {
         Name = "CarteExample"
    }
}  

resource "aws_security_group" "instance"{
    name = "terraform-example-instance"
    ingress {
        from_port  = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
   


data "aws_ami" "ubuntu" {
most_recent = true
owners = ["099720109477"] # Canonical

  filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}




