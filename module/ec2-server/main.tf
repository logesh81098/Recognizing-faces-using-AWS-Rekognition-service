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
  user_data = <<-EOF
  #!bin/bash
  sudo su
  set -eux
  dnf update -y
  dnf upgrade -y
  dnf install git -y
  git --version
  dnf install docker -y
  systemctl enable docker
  systemctl start docker
  sleep 10
  systemctl status docker
  usermod -aG docker ec2-user
  dnf install -y python3 python3-pip 
  pip install boto3
  cd /
  git clone https://github.com/logesh81098/Recognizing-faces-using-AWS-Rekognition-service.git
  cd Recognizing-faces-using-AWS-Rekognition-service/
  docker build -t logeshshanmugavel/face-rekognition-app .
  docker run -d -p 81:81 logeshshanmugavel/face-rekognition-app
  python3 upload-images-to-s3.py
  EOF
  tags = {
    Name = "Rekognition-Flask-Application-Server"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
}