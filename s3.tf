//bucket for access logs
resource "aws_s3_bucket" "bucket_logs" {
   bucket = "serverless-access-bucket-logs"
   acl    = "log-delivery-write"
}

//buckets containing upload objects
resource "aws_s3_bucket" "ukba_uploads" {
   bucket = "serverless-uploads-x101"
   acl    = "private"

   logging {
      target_bucket = aws_s3_bucket.bucket_logs.id
      target_prefix = "log/"
   }
   versioning {
      enabled = true
   }
}

//bucket containing lambda functions
resource "aws_s3_bucket" "functions" {
   bucket = "lambda-functions-101x1"
   acl    = "private"

   versioning {
      enabled = true
   }
}

// terraform backend access logs
resource "aws_s3_bucket" "backend-access" {
   bucket = "terraform-20201911-accesses"
   acl    = "log-delivery-write"
   force_destroy = true
}

// terraform backend buckets
resource "aws_s3_bucket" "backend" {
   bucket = "terrafor-20201911"
   acl    = "private"
   force_destroy = true

   versioning {
      enabled = true
   }
   lifecycle {
      prevent_destroy = false
   }
   logging {
      target_bucket = aws_s3_bucket.backend-access.id
      target_prefix = "log/"
   }
}

output "s3_bucket_arn" {
   value = aws_s3_bucket.ukba_uploads.arn
}

output "lambda-function" {
   value = aws_s3_bucket.functions.arn
}
