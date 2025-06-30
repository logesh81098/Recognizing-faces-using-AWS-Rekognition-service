##########################################################################################################################################
#                                                        EKS Cluster    
##########################################################################################################################################

#EKS Cluster

resource "aws_eks_cluster" "face-rekognition-cluster" {
  name = "Face-Rekogntion-Cluster"
  version = "1.30"
  role_arn = var.cluster-role
  vpc_config {
    subnet_ids = [ var.subnet-1, var.subnet-2 ]
    security_group_ids = [ var.eks-security-group, var.application-security-group ]
  }
  tags = {
    Name = "Face-Rekogntion-Cluster"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}



##########################################################################################################################################
#                                                        EKS Node Group   
##########################################################################################################################################

#EKS Node Group

