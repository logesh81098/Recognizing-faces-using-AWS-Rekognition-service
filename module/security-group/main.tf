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

  egress {
    from_port = 0
    to_port = 0
    cidr_blocks = [var.anywhere-ip]
    protocol = "-1"
  }

  tags = {
    Name = "Face-Rekognition-SG"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}



##########################################################################################################################################
#                                                    Security Group
##########################################################################################################################################

#Security group for EKS Cluster

resource "aws_security_group" "eks-cluster-sg" {
  name = "Face-Rekognition-EKS-Cluster"
  description = "This Security group is created to Face Rekogntion EKS Cluster"
  vpc_id = var.vpc-id

  ingress {
    from_port = var.API-Server
    to_port = var.API-Server
    protocol = "tcp"
    cidr_blocks = [ var.anywhere-ip ]
  }

  ingress {
    description = "Ingress Rule for Flask Application Port"
    from_port = var.Flask-Application-port
    to_port = var.Flask-Application-port
    cidr_blocks = [var.anywhere-ip]
    protocol = "tcp"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Face-Rekognition-EKS-Cluster-SG"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
    "kubernetes.io/cluster/Face-Rekogntion-Cluster" = "owned"
    "eks-cluster-name" = "Face-Rekognition-EKS-Cluster"
  }
}


##########################################################################################################################################
#                                                    Security Group
##########################################################################################################################################

#Security group for EKS Node Group

resource "aws_security_group" "eks-node-group-sg" {
  name = "Face-Rekognition-EKS-NodeGroup-SG"
  description = "This Security group is created to Face Rekogntion EKS Node Group"
  vpc_id = var.vpc-id

  ingress {
    from_port = var.API-Server
    to_port = var.API-Server
    protocol = "tcp"
    security_groups = [aws_security_group.eks-cluster-sg.id]
  }

  ingress {
    description = "Ingress Rule for Flask Application Port"
    from_port = var.Flask-Application-port
    to_port = var.Flask-Application-port
    cidr_blocks = [var.anywhere-ip]
    protocol = "tcp"
  }

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = [ aws_security_group.eks-cluster-sg.id ]
  }

  ingress {
    from_port = "0"
    to_port = "65535"
    protocol = "tcp"
    self = true
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Face-Rekognition-EKS-NodeGroup-SG"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
    "kubernetes.io/cluster/Face-Rekogntion-Cluster" = "owned"
    "eks-cluster-name" = "Face-Rekognition-EKS-Cluster"
  }
}
