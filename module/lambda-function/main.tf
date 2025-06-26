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

#Lambda Function to Create Rekognition CollectionID 

#[Note: Rekogntion CollectionID can be created only via AWS CLI, So we used Lambda Function to run AWS CLI command to create CollectionID]

resource "aws_lambda_function" "rekognition-collectionid" {
  function_name = "Rekognition-CollectionID"
  description = "Lambda Function to Create Rekognition CollectionID"
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
#                                            Invoke Lambda Function
##########################################################################################################################################

#Invoking Lambda function to run AWS CLI command to create CollectionID

resource "aws_lambda_invocation" "invoke-rekognition-collectionid" {
  function_name = aws_lambda_function.rekognition-collectionid.function_name
  input = jsonencode({
    "collection_id" = "face-rekognition-collection"
  })
}