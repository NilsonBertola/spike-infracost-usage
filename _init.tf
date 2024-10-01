provider "aws" {
  region = var.aws_region
}

module "ec2" {
  source        = "./modules/ec2"
  ami_id        = var.ami_id
  name          = var.name
  aws_region    = var.aws_region
  instance_type = var.instance_type

}

module "eks" {
  source = "./modules/eks"
}

resource "aws_eks_cluster" "my_cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.my_eks_role.arn
  version  = "1.21"

  vpc_config {
    subnet_ids = [aws_subnet.my_subnet.id]
  }

  tags = {
    Environment = "dev"
    Service     = "eks"
  }
}

resource "aws_iam_role" "my_eks_role" {
  name = "my-eks-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    Environment = "dev"
    Service     = "eks"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "sa-east-1a"
  tags = {
    Name = "my_subnet"
    Service = "eks"
    Environment = "dev"
  }
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my_vpc"
    Service = "eks"
    Environment = "dev"
  }
}
