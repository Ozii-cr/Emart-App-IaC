#Print out the Public IP of the Instance 
output "PublicIP" {
  value = aws_instance.emart.public_ip
}

#Print out the Private IP of the Instance 
output "PrivateIP" {
  value = aws_instance.emart.private_ip
}