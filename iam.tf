//Creating the aws iam role and we will get the assume role policy in aws iam
resource "aws_iam_role" "ec2_role" {
  name = "Docker_EC2_role"

  assume_role_policy = jsonencode({
    "version" = "2012-10-17"

    "statement" = [
      {
        "Effect" = "Allow"
        "Action" = [
          "sts:AssumeRole"
        ],
        "Principal" = {
          "Service" = [
            "ec2.amazonaws.com"
          ]
        }
      }
    ]
  })
}

//Attaching the policies 01 AmazonEC2ContainerRegistryReadOnly and 02 AmazonSSMManagedInstanceCore 

resource "aws_iam_role_policy_attachment" "ecr_readonly" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "ssm_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

//Creating the iam instance profile for the ec2 instance

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "Docker_EC2_instance_profile"
  role = aws_iam_role.ec2_role.name

  tags = {
    Name        = "Docker_EC2_instance_profile"
    Environment = "Learning"
    ManagedBy   = "Terraform"
  }
}

