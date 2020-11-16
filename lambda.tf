resource "aws_lambda_function" "main" {
   s3_bucket         = "lambda-functions-101x1"
   s3_key            = "fcdba87d115b4fd88d7f1952e285d0b0"
   s3_object_version = "1"
   function_name     = "call-to-s3"
   role              = aws_iam_role.lambda_role.arn
   handler           = "app.lambda_handler"
   runtime           = "python2.7"
}
