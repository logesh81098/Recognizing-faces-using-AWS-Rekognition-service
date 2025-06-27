module "s3" {
  source = "./module/s3"
}

module "iam" {
  source = "./module/iam"
}

module "lambda-function" {
  source                        = "./module/lambda-function"
  rekognition-collectionid-role = module.iam.rekognition-collectionid-role
  rekognition-faceprints-role = module.iam.rekognition-faceprints-role
}

module "dynamodb" {
  source = "./module/dynamodb"
}