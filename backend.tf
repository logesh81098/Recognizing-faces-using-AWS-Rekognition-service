terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "terraform-backend-files-logesh"
    key = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}