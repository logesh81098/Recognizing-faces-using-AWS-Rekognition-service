output "rekognition-server-sg" {
  value = aws_security_group.face-prints-sg.id
}