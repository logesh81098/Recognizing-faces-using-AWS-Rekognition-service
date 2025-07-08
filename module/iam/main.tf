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


##########################################################################################################################################
#                                                   IAM Role
##########################################################################################################################################

#IAM Role for lambda function to create faceprints and store it in DynamoDB Table

resource "aws_iam_role" "rekognition-faceprints-role" {
  name = "Rekognition-Faceprints-Role"
  description = "IAM Role for lambda function to create faceprints from images on source S3 bucket and store it in DynamoDB Table"
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
      Name = "Rekognition-Faceprints-Role"
      Project = "Recognizing-faces-using-AWS-Rekognition-service"
    }
}

##########################################################################################################################################
#                                                   IAM Policy
##########################################################################################################################################

#IAM Policy for lambda function to create faceprints and store it in DynamoDB Table

resource "aws_iam_policy" "rekognition-faceprints-policy" {
  name = "Rekognition-Faceprints-Policy"
  description = "IAM Policy for lambda function to create faceprints from images on source S3 bucket and store it in DynamoDB Table"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "CreateCloudWatchLogGroup",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:*"
        },
        {
            "Sid": "GetObjectFromS3Bucket",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:HeadObject"
            ],
            "Resource": "arn:aws:s3:::face-rekognition-source-bucket/*"
        },
        {
            "Sid": "PutItemsInDynamoDBTable",
            "Effect": "Allow",
            "Action": [
                "dynamodb:PutItem"
            ],
            "Resource": "arn:aws:dynamodb:*:*:table/Faceprints-Table"
        },
        {
            "Sid": "IndexFacesUsingRekognitionService",
            "Effect": "Allow",
            "Action": [
                "rekognition:IndexFaces"
            ],
            "Resource": "arn:aws:rekognition:*:*:collection/*"
        }
    ]
}  
EOF
  tags = {
    Name = "Rekognition-Faceprints-Policy"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}

##########################################################################################################################################
#                                                        Role Policy Attachement
##########################################################################################################################################

#Attaching Role and Policy
resource "aws_iam_role_policy_attachment" "rekognition-faceprints" {
  role = aws_iam_role.rekognition-faceprints-role.id
  policy_arn = aws_iam_policy.rekognition-faceprints-policy.arn
}


##########################################################################################################################################
#                                                   IAM Role
##########################################################################################################################################

#IAM Role for EC2 instance to Create and Test Docker image of Flask Application

resource "aws_iam_role" "rekognition-flask-application-role" {
  name = "Rekognition-Flask-Application-Role"
  description = "IAM Role for EC2 instance to Create and Test Docker image of Flask Application"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            }
        }
    ]
}
EOF
  tags = {
    Name = "Rekognition-Flask-Application-Role"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}


##########################################################################################################################################
#                                                   IAM Policy
##########################################################################################################################################

#IAM Policy for for EC2 instance to Create and Test Docker image of Flask Application

resource "aws_iam_policy" "rekognition-flask-application-policy" {
  name = "Rekognition-Flask-Application-Policy"
  description = "IAM Policy for for EC2 instance to Create and Test Docker image of Flask Application"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "CloudWatchLogGroup",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:*"
        },
        {
            "Sid": "DynamoDBGetItems",
            "Effect": "Allow",
            "Action": [
                "dynamodb:*"
            ],
            "Resource": "arn:aws:dynamodb:*:*:*"
        },
        {
            "Sid": "RekognitionIndexFace",
            "Effect": "Allow",
            "Action": [
                "rekognition:*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "S3PutSourceImage",
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:PutObject",
                "s3:GetObject",
                "s3:HeadObject"
            ],
            "Resource": [
                "arn:aws:s3:::face-rekognition-source-bucket/*",
                "arn:aws:s3:::face-rekognition-source-bucket"
            ]
        }
    ]

}  
EOF
  tags = {
    Name = "Rekognition-Flask-Application-Policy"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}


##########################################################################################################################################
#                                                        Role Policy Attachement
##########################################################################################################################################

#Attaching Role and Policy

resource "aws_iam_role_policy_attachment" "rekognition-flask-application" {
  role = aws_iam_role.rekognition-flask-application-role.id
  policy_arn = aws_iam_policy.rekognition-flask-application-policy.arn
}


##########################################################################################################################################
#                                                        IAM Instance Profile
##########################################################################################################################################

#IAM Instance profile for EC2 server

resource "aws_iam_instance_profile" "rekognition-flask-application-server" {
  name = "Rekognition-Flask-Application-Server-Role"
  role = aws_iam_role.rekognition-flask-application-role.id
}


##########################################################################################################################################
#                                                   IAM Role
##########################################################################################################################################

#IAM Role for EKS Cluster

resource "aws_iam_role" "eks-cluster-role" {
  name = "Rekognition-EKS-Cluster-Role"
  description = "IAM Role for EKS Cluster"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "eks.amazonaws.com"
            }
        }
    ]
}  
EOF
  tags = {
    Name = "Rekognition-EKS-Cluster-Role"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}


##########################################################################################################################################
#                                                        Role Policy Attachement
##########################################################################################################################################

#Attaching Role and Policy

resource "aws_iam_role_policy_attachment" "eks-cluster-policy" {
  role = aws_iam_role.eks-cluster-role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks-cni-policy" {
  role = aws_iam_role.eks-cluster-role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "eks-block-storage-policy" {
  role = aws_iam_role.eks-cluster-role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSBlockStoragePolicy"
}

resource "aws_iam_role_policy_attachment" "eks-compute-policy" {
  role = aws_iam_role.eks-cluster-role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSComputePolicy"
}

resource "aws_iam_role_policy_attachment" "eks-loadbalancing-policy" {
  role = aws_iam_role.eks-cluster-role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy"
}

resource "aws_iam_role_policy_attachment" "eks-networking-policy" {
  role = aws_iam_role.eks-cluster-role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSNetworkingPolicy"
}

resource "aws_iam_role_policy_attachment" "eks-application-policy" {
  role = aws_iam_role.eks-cluster-role.id
  policy_arn = aws_iam_policy.rekognition-flask-application-policy.arn
}



##########################################################################################################################################
#                                                   IAM Policy
##########################################################################################################################################

#IAM Role for EKS Node Group

resource "aws_iam_role" "eks-node-group-role" {
  name = "Rekognition-EKS-NodGroup-Role"
  description = "IAM Role for EKS Node Group"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            }
        }
    ]
}
EOF
}




##########################################################################################################################################
#                                                   IAM Policy
##########################################################################################################################################

#IAM Policy for Node Group to create Load Balance and create Security Group

resource "aws_iam_policy" "face-rekognition-k8s-policy" {
  name = "Rekognition-k8s-policy"
  description = "IAM Policy for Node Group to create Load Balance and create Security Group"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
          "ec2:Describe*",
          "elasticloadbalancing:*",
          "ec2:CreateSecurityGroup",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupIngress",
          "ec2:DeleteSecurityGroup"
      ],
      "Resource": "*"
    }
  ]
}  
EOF
  tags = {
    Name = "Rekognition-k8s-policy"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}


##########################################################################################################################################
#                                                        Role Policy Attachement
##########################################################################################################################################

#Attaching Role and Policy

resource "aws_iam_role_policy_attachment" "eks-ecr-policy" {
  role = aws_iam_role.eks-node-group-role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
}

resource "aws_iam_role_policy_attachment" "eks-cni-node-group-policy" {
  role = aws_iam_role.eks-node-group-role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "eks-worker-node-policy" {
  role = aws_iam_role.eks-node-group-role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks-application-node-group-policy" {
  role = aws_iam_role.eks-node-group-role.id
  policy_arn = aws_iam_policy.rekognition-flask-application-policy.arn
}

resource "aws_iam_role_policy_attachment" "eks-k8s-policy" {
  role = aws_iam_role.eks-node-group-role.id
  policy_arn = aws_iam_policy.face-rekognition-k8s-policy.arn
}


