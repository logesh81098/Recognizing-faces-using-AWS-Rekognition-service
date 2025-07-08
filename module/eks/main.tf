##########################################################################################################################################
#                                                        EKS Cluster    
##########################################################################################################################################

#EKS Cluster

resource "aws_eks_cluster" "face-rekognition-cluster" {
  name = "Face-Rekogntion-Cluster"
  version = "1.33"
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

resource "aws_eks_node_group" "face-rekognition-node-group" {
  cluster_name = aws_eks_cluster.face-rekognition-cluster.name
  node_group_name = "Face-Rekognition-NodeGroup"
  node_role_arn = var.node-group-role
  subnet_ids = [ var.subnet-1, var.subnet-2 ]
  scaling_config {
    max_size = 2
    min_size = 1 
    desired_size = 1
  }
  instance_types = [ var.instance-type ]
  launch_template {
    id = var.launch-template-id
    version = "$Latest"
  }
  tags = {
    Name = "Face-Rekogntion--NodeGroup"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
  
}

##########################################################################################################################################
#                                                        Collecting Data of EKS Cluster
##########################################################################################################################################

#EKS Node Group

data "aws_eks_cluster" "face-rekognition-cluster-data" {
  name = "Face-Rekogntion-Cluster"
}
##########################################################################################################################################
#                                                        EKS OpenID Provider
##########################################################################################################################################

#Creating OpenID connect provider, So that Containers in Pod in EKS Cluster can able to access AWS services

resource "aws_iam_openid_connect_provider" "default" {
  url = data.aws_eks_cluster.face-rekognition-cluster-data.identity[0].oidc[0].issuer
  client_id_list = ["sts.amazonaws.com"]
}

