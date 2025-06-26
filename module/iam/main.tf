##########################################################################################################################################
#                                                   IAM Role
##########################################################################################################################################

#IAM Role for lambda function to create collectionid in Rekognition service

resource "aws_iam_role" "collectionid-role" {
  name = "Rekognition-CollectionID-Role"
  description = "IAM Role for Lambda function to create Rekognition Collection ID"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            }
        }
    ]
}  
EOF
    tags = {
      Name = "Rekognition-CollectionID-Role"
      Project = "Recognizing-faces-using-AWS-Rekognition-service"
    }
}



##########################################################################################################################################
#                                                        IAM Policy
##########################################################################################################################################

#IAM Policy for lambda function to create collectionid in Rekognition service

resource "aws_iam_policy" "rekognition-collectionid-policy" {
  name = "Rekognition-CollectionID-Policy"
  description = "IAM Policy for Lambda function to create Rekognition Collection ID"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "CreateLogGroup",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:*"
        },
        {
            "Sid": "CreateCollectionID",
            "Effect": "Allow",
            "Action": [
                "rekognition:CreateCollection",
                "rekognition:DeleteCollection",
                "rekognition:ListCollections"
            ],
            "Resource": "*"
        }
    ]
}  
EOF
    tags = {
      Name = "Rekognition-CollectionID-Policy"
      Project = "Recognizing-faces-using-AWS-Rekognition-service"
    }
}



##########################################################################################################################################
#                                                        Role Policy Attachement
##########################################################################################################################################

#Attaching Role and Policy

resource "aws_iam_role_policy_attachment" "collection-id" {
  role = aws_iam_role.collectionid-role.id
  policy_arn = aws_iam_policy.rekognition-collectionid-policy.arn
}