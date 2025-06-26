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