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

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  for_each = var.s3_buckets
  bucket   = aws_s3_bucket.name[each.key].id

  rule {
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
    id      = "expire_old_files"
    status  = "Enabled"
    prefix  = ""

    transition {
      days          = 30
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }
}