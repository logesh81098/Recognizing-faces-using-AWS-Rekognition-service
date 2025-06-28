##################################################################################################################################
#                                                     EC2 instance
##################################################################################################################################

#EC2 instance

resource "aws_instance" "Face-recognition-server" {
  ami = var.ami-id
  instance_type = var.instance-type
  key_name = var.keypair
  subnet_id = var.subnet-id
  security_groups = [var.security-group]
  iam_instance_profile = var.Face-Recognition-EC2-Instance-Profile
  tags = {
    Name = "Face-Recognition-Server"
    Project = "Recognizing-faces-using-AWS-Rekognition-service"
  }
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
}