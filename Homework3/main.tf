provider aws {
    region = "us-west-2"
}

resource "aws_key_pair" "deployer" {
  key_name   = "bastion1"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_ami" "linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}



resource "aws_instance" "web1" {
  ami           = data.aws_ami.linux.id
  instance_type = "t2.micro"
  subnet_id = "subnet-05cd05bb2682385b8"
  key_name = aws_key_pair.deployer.key_name
  vpc_security_group_ids =[aws_security_group.allow_tls.id]
  user_data = file("apache.sh")
    
      tags = {
    Name = "web-1"
        }
}

resource "aws_instance" "web2" {
  ami           = data.aws_ami.linux.id
  instance_type = "t2.micro"
  subnet_id = "subnet-0365eedbf531bf9f7"
  key_name = aws_key_pair.deployer.key_name
  vpc_security_group_ids =[aws_security_group.allow_tls.id]
  user_data = file("apache.sh")
    
      tags = {
    Name = "web-2"
        }
}

resource "aws_instance" "web3" {
  ami           = data.aws_ami.linux.id
  instance_type = "t2.micro"
  subnet_id = "subnet-02416cb8860207eb1"
  key_name = aws_key_pair.deployer.key_name
  vpc_security_group_ids =[aws_security_group.allow_tls.id]
  user_data = file("apache.sh")
    
      tags = {
    Name = "web-3"
        }
}

output ec2 {
    value = aws_instance.web1.public_ip
    sensitive = true
}

output ec2-1 {
    value = aws_instance.web2.public_ip
    sensitive = true
}

output ec2-2 {
    value = aws_instance.web3.public_ip
    sensitive = true
}