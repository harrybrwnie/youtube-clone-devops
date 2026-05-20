resource "aws_instance" "jenkins_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  root_block_device {
    volume_size = var.root_volume_size
  }

  tags = {
    Name = "jenkins-sonarqube-server"
  }
}
