##########################################################################################################################################
#                                                        EC2 Server
##########################################################################################################################################

resource "aws_instance" "face-rekognition-server" {
  ami = var.ami-id
  instance_type = var.instance-type
  key_name = var.keypair
  iam_instance_profile = var.server-iam-role
  subnet_id = var.subnet
  security_groups = [ var.security-group]
  
  tags = {
    Name = "Rekognition-Flask-Application-Server"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}