##########################################################################################################################################
#                                                   S3 Bucket
##########################################################################################################################################

resource "aws_s3_bucket" "source-bucket" {
  bucket = "face-rekognition-source-bucket"
  tags = {
    Name = "face-rekognition-source-bucket"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}


##########################################################################################################################################
#                                           S3 to trigger Lambda Function
##########################################################################################################################################

#S3 bucket is added as trigger to faceprints lambda function to trigger it for each object creation

resource "aws_s3_bucket_notification" "s3-trigger-lambda" {
  bucket = aws_s3_bucket.source-bucket.bucket
  lambda_function {
    lambda_function_arn = var.rekognition-faceprints-function-arn
    events = ["s3:ObjectCreated:*"]
  }
}