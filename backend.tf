terraform {
  backend "s3" {
    bucket = "terraformstate-my-project786"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}

