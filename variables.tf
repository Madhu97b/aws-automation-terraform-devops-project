variable "aws_region" {
  description = "Aws region where we create our infrastructure"
  type        = string
  default     = "us-east-1"
}

//Here in variable we need to use the type after the description not the value.

variable "ec2_key_name" {
  description = "The key name for the ec2 is"
  type        = string
}


