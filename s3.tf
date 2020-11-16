resource "aws_s3_bucket" "bucket_logs" {
   bucket = "serverless-access-bucket-logs"
   acl    = "log-delivery-write"
}

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

resource "aws_s3_bucket" "functions" {
   bucket = "lambda-functions-101x1"
   acl    = "private"

   versioning {
      enabled = true
   }
}
//resource "aws_s3_bucket_policy" "bucket_policy" {
  // bucket = aws_s3_bucket.ukba_uploads.id
   //policy = data.aws_iam_policy_document.s3_policy.json
//}

output "s3_bucket_arn" {
   value = aws_s3_bucket.ukba_uploads.arn
}

output "lambda-function" {
   value = aws_s3_bucket.functions.arn
}
