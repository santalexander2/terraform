terraform {
  backend "s3" {
    bucket = "terraform-tfstate-sant" # create a bucket where you will store you tfstate file
    key    = "terraform.tfstate"  # the name of our tfstate file in s3 bucket
    region = "us-west-1"
    encrypt = true
    dynamodb_table = "terraform-state-lock"
  }
}