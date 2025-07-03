##########################################################################################################################################
#                                                        VPC    
##########################################################################################################################################

#VPC to deploy Face Rekognition application on EKS Cluster

resource "aws_vpc" "face-rekognition-vpc" {
  cidr_block = var.vpc-cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "Face-Rekognition-VPC"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}


##########################################################################################################################################
#                                                   Public Subnets   
##########################################################################################################################################

resource "aws_subnet" "face-rekognition-public-subnet-1" {
  vpc_id = aws_vpc.face-rekognition-vpc.id
  cidr_block = var.subnet-1-cidr
  availability_zone = var.az-1
  map_public_ip_on_launch = true
  tags = {
    Name = "Face-Rekognition-Public-Subnet-1"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/Face-Rekogntion-Cluster" = "shared"
  }
}


resource "aws_subnet" "face-rekognition-public-subnet-2" {
  vpc_id = aws_vpc.face-rekognition-vpc.id
  cidr_block = var.subnet-2-cidr
  availability_zone = var.az-2
  map_public_ip_on_launch = true
  tags = {
    Name = "Face-Rekognition-Public-Subnet-2"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/Face-Rekogntion-Cluster" = "shared"
  }
}


##########################################################################################################################################
#                                                   Internet Gateway  
##########################################################################################################################################

resource "aws_internet_gateway" "face-rekognition-igw" {
  vpc_id = aws_vpc.face-rekognition-vpc.id
  tags = {
    Name = "Face-Rekognition-IGW"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}


##########################################################################################################################################
#                                                    Route Table  
##########################################################################################################################################

resource "aws_route_table" "face-rekognition-rt" {
  vpc_id = aws_vpc.face-rekognition-vpc.id
  route {
    gateway_id = aws_internet_gateway.face-rekognition-igw.id
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = "Face-Rekognition-RouteTable"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}


##########################################################################################################################################
#                                                Route Table  Association
##########################################################################################################################################

resource "aws_route_table_association" "subnet-1" {
  route_table_id = aws_route_table.face-rekognition-rt.id
  subnet_id = aws_subnet.face-rekognition-public-subnet-1.id
}

resource "aws_route_table_association" "subnet-2" {
  route_table_id = aws_route_table.face-rekognition-rt.id
  subnet_id = aws_subnet.face-rekognition-public-subnet-2.id
}