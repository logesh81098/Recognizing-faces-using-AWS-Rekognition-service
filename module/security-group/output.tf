output "rekognition-server-sg" {
  value = aws_security_group.face-prints-sg.id
}

output "rekognition-eks-cluster-sg" {
  value = aws_security_group.eks-cluster-sg.id
}

output "rekognition-nodegroup-sg" {
  value = aws_security_group.eks-node-group-sg.id
}