output "vpc-id" {
  value = aws_vpc.face-rekognition-vpc.id
}

output "public-subnet-1" {
  value = aws_subnet.face-rekognition-public-subnet-1.id
}

output "public-subnet-2" {
  value = aws_subnet.face-rekognition-public-subnet-2.id
}