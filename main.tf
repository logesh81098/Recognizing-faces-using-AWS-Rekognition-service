module "s3" {
  source                              = "./module/s3"
  rekognition-faceprints-function-arn = module.lambda-function.rekognition-faceprints-function-arn
}

module "iam" {
  source = "./module/iam"
  
}

module "lambda-function" {
  source                        = "./module/lambda-function"
  rekognition-collectionid-role = module.iam.rekognition-collectionid-role
  rekognition-faceprints-role   = module.iam.rekognition-faceprints-role
  source-bucket-arn             = module.s3.source-bucket-arn
}

module "dynamodb" {
  source = "./module/dynamodb"
}

module "vpc" {
  source = "./module/vpc"
}

module "security-group" {
  source = "./module/security-group"
  vpc-id = module.vpc.vpc-id
}

module "key-pair" {
  source = "./module/key-pair"
}

module "ec2-server" {
  source                                = "./module/ec2-server"
  keypair                               = module.key-pair.face-rekognition-server-keypair
  subnet-id                             = module.vpc.public-subnet-1
  security-group                        = module.security-group.rekognition-server-sg
  Face-Recognition-EC2-Instance-Profile = module.iam.rekognition-flask-server-instance-profile
}

module "eks" {
  source                     = "./module/eks"
  cluster-role               = module.iam.rekognition-cluster-role
  subnet-1                   = module.vpc.public-subnet-1
  subnet-2                   = module.vpc.public-subnet-2
  eks-security-group         = module.security-group.rekognition-eks-cluster-sg
  application-security-group = module.security-group.rekognition-server-sg
  node-group-role            = module.iam.rekognition-nodegroup-role
  launch-template-id         = module.launch-template.launch-template-id

}

module "launch-template" {
  source         = "./module/launch-template"
  nodegroup-sg   = module.security-group.rekognition-nodegroup-sg
  application-sg = module.security-group.rekognition-server-sg
  key-name       = module.key-pair.face-rekognition-server-keypair
}