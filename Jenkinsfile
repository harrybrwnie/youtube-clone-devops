pipeline {
  agent any
  tools {
    nodejs 'node16'
  }
  environment {
  DOCKERHUB_CREDENTIALS = credentials('docker')
  APP_NAME = "youtube-clone"
  DOCKER_USER = "h4rrybrwnie"
  }
  stages {
    stage('Lay code') {
      steps {
        git branch: 'main', url: 'https://github.com/harrybrwnie/youtube-clone-devops.git'
      }
    }
     stage('Build & Test') {
        echo "Dang cai libs ..."
        sh 'npm install'
     }
    }
    stage('Push to DockerHub') {
      steps {
        echo "Login to DockerHub"
        sh "echo \$DOCKERHUB_CREDENTIALS_PSW | docker login -u \$DOCKERHUB_CREDENTIALS_USR --password-stdin"
        echo "Push Image len Hub"
        sh "docker push ${DOCKER_USER}/${APP_NAME}:latest"
     }
    }
}

    post {
        always {
           echo "Hoan tat Pipeline"
           sh "docker rmi ${DOCKER_USER}/${APP_NAME}:latest || true"
        }
     }
}
