##########################################################################################################################################
#                                                        Key Pair
##########################################################################################################################################

resource "tls_private_key" "rekognition-server-key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "rekognition-application-server-keypair" {
  key_name = "Rekognition-Application-Server-Key"
  public_key = tls_private_key.rekognition-server-key.public_key_openssh
}


resource "local_file" "rekognition-application-server-private-key" {
  filename = "Rekognition-Application-Server-Key"
  content = tls_private_key.rekognition-server-key.private_key_openssh
}