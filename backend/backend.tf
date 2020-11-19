terraform {
   backend "s3" {
      bucket = aws_s3_bucket.backend.name
      key    = "terraform/tfstate"
      region = "eu-west-1"
      dynamodb_table = aws_dynamodb_table.terraform-locking.name
   }
}
