##########################################################################################################################################
#                                               Archive File
##########################################################################################################################################
#Converting the Python code to Zip File

data "archive_file" "rekognition-python-to-zip" {
  type = "zip"
  source_dir = "module/lambda-function"
  output_path = "module/lambda-function/rekognition-collection-id.zip"
}


##########################################################################################################################################
#                                               Lambda Function
##########################################################################################################################################

resource "aws_lambda_function" "rekognition-collectionid" {
  function_name = "Rekognition-CollectionID"
  filename = "module/lambda-function/rekognition-collection-id.zip"
  handler = "rekognition-collection-id.lambda_handler"
  role = var.rekognition-collectionid-role
  runtime = "python3.8"
  timeout = 20
  tags = {
    Name = "Rekognition-CollectionID"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}


##########################################################################################################################################
#                                               Lambda Function
##########################################################################################################################################