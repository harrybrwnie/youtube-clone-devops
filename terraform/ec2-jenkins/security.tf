resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Security group for Jenkins and SonarQube server"

  ingress {
    description = "Allow SSH from trusted IP only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  ingress {
    description = "Allow Jenkins web UI from trusted IP only"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.allowed_web_cidr]
  }

  ingress {
    description = "Allow SonarQube web UI from trusted IP only"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = [var.allowed_web_cidr]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-sonarqube-sg"
  }
}
