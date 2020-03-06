provider "aws"{
    region = "eu-west-2"
}

resource "aws_instance" "example" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    
    tags = {
         Name = "CarteExample"
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



