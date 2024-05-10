provider "aws" {
  region     = var.region
  access_key = var.AWS_ACCESS_KEYS
  secret_key = var.AWS_SECRET_KEYS
}