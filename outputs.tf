output "ecr_repository_name" {
  description = "ECR Repository Name"
  value       = aws_ecr_repository.docker_repo.name
}

output "ecr_repository_url" {
  description = "ECR Repository URL"
  value       = aws_ecr_repository.docker_repo.repository_url
}

output "ec2_instance_1a_1" {
  description = "First Instance 1a instance id"
  value       = aws_instance.docker_ec2_1.id
}

output "ec2_instance_1b_1" {
  description = "Second Instance 1b instance id"
  value       = aws_instance.docker_ec2_2.id
}

output "ec2_instance_1a_1_public_ip" {
  description = "First Instance 1a instance public ip"
  value       = aws_instance.docker_ec2_1.public_ip
}

output "ec2_instance_1b_1_public_ip" {
  description = "Second Instance 1b instance public ip"
  value       = aws_instance.docker_ec2_2.public_ip
}

//output for the mongodb instance
output "mongodb_instance_ec2" {
  description = "The ID of the mongodb instance is"
  value       = aws_instance.mongodb_instance.id
}

output "mongodb_private_ip" {
  description = "The private ip of the mongodb instance is"
  value       = aws_instance.mongodb_instance.private_ip
}

//output for the mongodb ebs volume
output "mongodb_ebs_volume_id" {
  description = "The ebs volume id for the mongodb is"
  value       = aws_ebs_volume.mongodb_data.id
}

//We will add the 2 target groups arn output now.

output "app_1_target_group_arn" {
  description = "The first target group arn for the app 1 is"
  value       = aws_lb_target_group.docker_tg_1.arn
}

//The  arn for the second target group for app2 
output "app_2_target_group_arn" {
  description = "The second target group arn for the app 2 is"
  value       = aws_lb_target_group.docker_tg_2.arn
}

//alb_arn and the alb_dns_name from the lb 

output "alb_dns_name" {
  description = "The dns name for the alb is"
  value       = aws_lb.docker_alb.dns_name
}

output "alb_arn" {
  description = "The alb_arn for the alb is"
  value       = aws_lb.docker_alb.arn
}


