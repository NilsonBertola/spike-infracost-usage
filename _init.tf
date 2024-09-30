provider "aws" {
  region = var.aws_region
}

module "ec2" {
  source     = "./modules/ec2"
  ami_id     = var.ami_id
  name       = var.name
  aws_region = var.aws_region
  instance_type = var.instance_type

}

module "eks" {
  source          = "./modules/eks"
}

