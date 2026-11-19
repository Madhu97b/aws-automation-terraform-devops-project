//Here we are writing the code to search ami with the latest update. It will search the ami with the latest update.

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

// Here we will write the script for ec2 first instance with the 1a availability zone.

resource "aws_instance" "docker_ec2_1" {
  tags = {
    Name        = "Docker_Ec2_1"
    Environment = "Learning"
    ManagedBy   = "Terraform"
  }

  ami = data.aws_ami.amazon_linux.id

  //This is not required here,It will be taken from the above ami.It will be automatically taken from the latest version
  // architecture  = "x86_64"
  //Selected through the ami data source.

  instance_type = "t3.micro"

  // key-pair we are not going to use here, We will use the amazon SSM Here. So this for just the reference for the upcoming scripts.

  //key_name     = "Here we will write our existing key-pair"

  subnet_id = aws_subnet.public_subnet_1.id

  //We are not writing the logic for the availability zone here. We already wrote it in subnets.tf 

  //we are not writing the vpc also,Beacause we already attached the vpc to the subnet. So no need to explicitly write here.

  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 8
    encrypted             = true
    delete_on_termination = true
  }

  //File system we don't require here, So we are not going to write it here.

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data = file("${path.module}/user-data.sh")
  // we can also use the ./user-data.sh inside the file. But the The above one wi    ll suits if we running the script from some other directory currently our te    rraform dir and the shell script for the user-data present in same directory

  // we can also write the below code 
  // user_data            = file("${path.module"}/user-data.sh)
}

//Now Here we are writing the script for the second ec2 instance. 

resource "aws_instance" "docker_ec2_2" {
  tags = {
    Name        = "Docker_EC2_2"
    Environment = "Learning"
    ManagedBy   = "Terraform"
  }

  ami = data.aws_ami.amazon_linux.id

  //This is not required here,It will taken from the above ami part.It will be automatically taken from the new version.
  //  architecture  = "x86_64"
  //Selected through the ami data source

  instance_type = "t3.micro"

  //Key pair we are not going to use here,Just for a future scripts reference i am writing this here. In this project we are going to use the amazon SSM.

  subnet_id = aws_subnet.public_subnet_2.id

  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 8
    encrypted             = true
    delete_on_termination = true
  }
  //File system we are not going to use here in our project.

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  user_data            = file("${path.module}/user-data.sh")
}


