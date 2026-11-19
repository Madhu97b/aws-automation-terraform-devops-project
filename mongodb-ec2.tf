//09 Things we need to consider before writing the script to create the instance
resource "aws_instance" "mongodb_instance" {
  //01.Name and tags
  tags = {
    Name        = "Docker_mongodb_ec2"
    Environment = "Learning"
    ManagedBy   = "Terraform"
  }

  //02.ami
  ami = data.aws_ami.amazon_linux.id

  //03.Architecture
  //Architecture is included in the ami

  //04.Instance type
  instance_type = "t3.micro"

  //05.key pair
  key_name = var.ec2_key_name

  //06.Network settings 
  subnet_id = aws_subnet.private_subnet_1.id

  associate_public_ip_address = false

  vpc_security_group_ids = [
    aws_security_group.mongodb_sg.id
  ]

  //07.configuration storage

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 8
    encrypted             = true
    delete_on_termination = true
  }
  //08.file system
  //we are going mention this seperately

  //09.iam_instance_profile

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  //connect the mongodb-user-data.sh to the ec2 of the mongodb.

  user_data = file("${path.module}/mongodb-user-data.sh")
}
