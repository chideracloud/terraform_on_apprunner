terraform {
  backend "s3" {
    bucket         = "my-app-states"     # your S3 bucket
    key            = "apprunner/terraform.tfstate" # unique path for this project
    region         = "us-east-1"       # for state locking
    encrypt        = true
  }
}
