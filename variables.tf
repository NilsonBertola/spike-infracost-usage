variable "name" {
  description = "The Name of the environment."
  type        = string
}
variable "aws_region" {
  description = "The AWS region where resources will be created."
  type        = string
}

variable "ami_id" {
  description = "The ID of the AMI to use for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The ID of the subnet where the EC2 instance will be deployed."
  type        = string
}

variable "s3_enabled" {
  description = "Enable S3 bucket creation."
  type        = bool
  default     = false  
}

variable "env" {
  description = "The environment where the resources will be created."
  type        = string
  default = "test"
}
