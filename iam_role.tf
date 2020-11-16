data "aws_iam_policy_document" "s3_policy" {
   statement {
      actions = ["s3:ListBucket"]
      resources = [aws_s3_bucket.ukba_uploads.arn,aws_s3_bucket.functions.arn]
   }
   statement {
      actions = ["s3:GetObject"]
      resources = ["${aws_s3_bucket.ukba_uploads.arn}/*","${aws_s3_bucket.functions.arn}/*"]
   }
}

data "aws_iam_policy_document" "lambda_assume_role" {
   statement {
      actions = ["sts:AssumeRole",]

      principals {
         type        = "Service"
         identifiers = ["lambda.amazonaws.com"]
      }
   }
}

resource "aws_iam_role" "lambda_role" {
   name               = "lambda-s3-call"
   assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
   path               = "/"
}

resource "aws_iam_policy" "lambda_role_policy" {
   name   = "lambda-call-policy"
   path   = "/"
   policy = data.aws_iam_policy_document.s3_policy.json
}

resource "aws_iam_policy_attachment" "lambda-call-policy-attach" {
   name           = "policy-attachment"
   roles          = [aws_iam_role.lambda_role.id]
   policy_arn     = aws_iam_policy.lambda_role_policy.arn
}


output "lambda_role" {
   value = [aws_iam_role.lambda_role.arn]
}
