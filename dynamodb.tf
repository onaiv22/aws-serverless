resource "aws_dynamodb_table" "terraform-locking" {
   name = "terraform-locking"
   hash_key = "LockID"
   read_capacity = 20
   write_capacity = 20

   attribute {
     name = "LockID"
     type = "S"
   }

   tags = {
     Name = "Dynamodb Terraform state lock Table"
     Environment = "serverless"
   }
}

output "dynamodb_table" {
   value = aws_dynamodb_table.terraform-locking.name
}
