resource "aws_instance" "ec2_instance" {
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"

  # Tags for identifying the instance
  tags = {
    Name = "${var.name}-instance"
  }
}

resource "aws_ebs_volume" "ec2-instance-ebs" {
  availability_zone = "${var.aws_region}a"
  size              = 30
  type = "gp3"
  tags = {
    Name = "${var.name}-volume"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ec2-instance-ebs.id
  instance_id = aws_instance.ec2_instance.id
}

resource "aws_instance" "ec2_instance_2" {
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"

  # Tags for identifying the instance
  tags = {
    Name = "${var.name}-instance"
  }
}