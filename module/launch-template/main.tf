##########################################################################################################################################
#                                                        Launch Template 
##########################################################################################################################################

#Launch Template for EKS Cluster

resource "aws_launch_template" "face-rekogntion-launch-template" {
  name = "Face-Rekogntion-Launch-Template"
  vpc_security_group_ids = [ var.application-sg, var.cluster-sg]
  key_name = var.key-name
  tag_specifications {
    resource_type = "instance"
    tags = {
        Name = "Face-Rekogntion-WorkerNodes"
        Project = "Recognizing-faces-using-AWS-Rekognition-service"
    }
  }
  tags = {
    Name = "Face-Rekogntion-Launch-Template"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}