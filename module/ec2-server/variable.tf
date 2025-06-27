variable "ami-id" {
  default = "ami-0953476d60561c955"
}

variable "instance-type" {
  default = "t3.micro"
}

variable "subnet" {
  default = {}
}

variable "server-iam-role" {
  default = {}
}

variable "security-group" {
  default = {}
}

variable "keypair" {
  default = {}
}