resource "aws_key_pair" "emart-key" {
  key_name   = "dovekey"
  public_key = file("dovekey.pub")
}


resource "aws_instance" "emart" {
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t2.medium"
  key_name               = aws_key_pair.emart-key.key_name
  vpc_security_group_ids = [aws_security_group.emart_sg.id]

  tags = {
    Name = "Emart-App"
  }


  # Copy the Provisioning script
  provisioner "file" {
    source      = "main.sh"
    destination = "/tmp/main.sh"
  }
  # Execute the Provisioning script
  provisioner "remote-exec" {

    inline = [
      "chmod +x /tmp/main.sh",
      "sudo /tmp/main.sh"
    ]
  }

  #ssh into the instance to provision the script
  connection {
    type        = "ssh"
    user        = var.USER
    private_key = file("dovekey")
    host        = self.public_ip
  }

}
