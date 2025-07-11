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
  ebs_block_device {
    volume_size = var.root-volume-size
    volume_type = var.root-volume-type
    device_name = "/dev/xvda"
  }
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
  sleep 10
  sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
  sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
  sudo dnf install java-17-amazon-corretto -y
  sudo dnf install jenkins -y
  sudo systemctl enable jenkins
  sudo systemctl start jenkins
  sudo systemctl status jenkins
  usermod -aG docker jenkins
  EOF
}