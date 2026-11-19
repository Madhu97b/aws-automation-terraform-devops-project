//creating the ebs volume
resource "aws_ebs_volume" "mongodb_data" {
  availability_zone = "us-east-1a"
  type              = "gp3"
  size              = 10
  encrypted         = true

  tags = {
    Name        = "mongodb_ebs_volume"
    Environment = "Learning"
    ManagedBy   = "Terraform"
  }
}

//Attaching the ebs volume to the aws instance

resource "aws_volume_attachment" "mongodb_data_attachment" {
  device_name = "/dev/sdf"
  instance_id = aws_instance.mongodb_instance.id
  volume_id   = aws_ebs_volume.mongodb_data.id
}

