resource "aws_ecr_repository" "docker_repo" {
  name                 = "docker_demo_app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "Docker_Demo_App"
    Environment = "Learning"
    Managed_By  = "Terraform"
  }
}


