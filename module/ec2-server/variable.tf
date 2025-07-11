variable "ami-id" {
  default = "ami-0953476d60561c955"
}

variable "instance-type" {
  default = "t3.medium"
}

variable "keypair" {
  default = {}
}

variable "subnet-id" {
  default = {}
}

variable "security-group" {
  default = {}
}

variable "Face-Recognition-EC2-Instance-Profile" {
  default = {}
}

variable "root-volume-size" {
  default = "12"
}

variable "root-volume-type" {
  default = "gp3"
}