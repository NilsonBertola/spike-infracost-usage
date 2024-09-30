# resource "aws_s3_bucket" "my_bucket" {
#   bucket = "my-app-bucket"
#   acl    = "private"

#   versioning {
#     enabled = true
#   }

#   tags = {
#     Name        = "MyAppBucket"
#     Environment = "dev"
#   }
# }


resource "aws_s3_bucket" "name" {
  for_each = var.s3_buckets
  bucket = "${var.name}-${each.key}"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "${var.name}-${each.key}"
    Environment = var.env
  }
}