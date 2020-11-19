terraform {
   backend "s3" {
      bucket = "terrafor-20201911"
      key    = "terraform/tfstate"
      dynamodb_table = "terraform-locking"
      profile        = "femi-devop"
      region         = "eu-west-1"
   }
}
