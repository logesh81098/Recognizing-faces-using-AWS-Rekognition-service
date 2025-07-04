output "rekognition-collectionid-role" {
  value = aws_iam_role.collectionid-role.arn
}

output "rekognition-faceprints-role" {
  value = aws_iam_role.rekognition-faceprints-role.arn
}

output "rekognition-flask-server-instance-profile" {
  value = aws_iam_instance_profile.rekognition-flask-application-server.name
}

output "rekognition-cluster-role" {
  value = aws_iam_role.eks-cluster-role.arn
}

output "rekognition-nodegroup-role" {
  value = aws_iam_role.eks-node-group-role.arn
}