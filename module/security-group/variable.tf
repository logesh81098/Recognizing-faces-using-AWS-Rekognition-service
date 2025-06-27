variable "vpc-id" {
  default = {}
}


variable "anywhere-ip" {
  default = "0.0.0.0/0"
}


variable "SSH-Port" {
  default = "22"
}

variable "HTTPS-Port" {
  default = "443"
}

variable "Flask-Application-port" {
  default = "81"
}