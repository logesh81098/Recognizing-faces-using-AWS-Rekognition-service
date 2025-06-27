output "rekognition-collectionid-role" {
  value = aws_iam_role.collectionid-role.arn
}

output "rekognition-faceprints-role" {
  value = aws_iam_role.rekognition-faceprints-role.arn
}