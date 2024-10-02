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
  count = var.s3_enabled ? 1 : 0
  bucket = "my-app-bucket-"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "test"
    Environment = "tset"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  count = var.s3_enabled ? 1 : 0
  bucket = aws_s3_bucket.name[0].bucket
  rule {
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

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }

    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }
}