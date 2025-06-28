##########################################################################################################################################
#                                                    Security Group
##########################################################################################################################################

#Security group for Ec2 instance to run docker image of Face Rekognition Flask Application

resource "aws_security_group" "face-prints-sg" {
  name = "Face-Rekognition-SG"
  description = "Security Group created for EC2 instance to allow SSH, HTTPS and Flask Application port"
  vpc_id = var.vpc-id

  ingress {
    description = "Ingress Rule for SSH"
    from_port = var.SSH-Port
    to_port = var.SSH-Port
    cidr_blocks = [var.anywhere-ip]
    protocol = "tcp"
  }

  ingress {
    description = "Ingress Rule for HTTPS"
    from_port = var.HTTPS-Port
    to_port = var.HTTPS-Port
    cidr_blocks = [var.anywhere-ip]
    protocol = "tcp"
  }

  ingress {
    description = "Ingress Rule for Flask Application Port"
    from_port = var.Flask-Application-port
    to_port = var.Flask-Application-port
    cidr_blocks = [var.anywhere-ip]
    protocol = "tcp"
  }


  tags = {
    Name = "Face-Rekognition-SG"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}