pipeline {
    agent any

    tools {
        // Tên 'node16' phải trùng với tên bạn đặt trong Manage Jenkins -> Tools
        nodejs 'node16'
    }

    environment {
        // ID 'docker' phải trùng với ID bạn tạo trong Credentials
        DOCKERHUB_CREDENTIALS = credentials('docker')
        APP_NAME = "youtube-clone"
        DOCKER_USER = "TEN_DANG_NHAP_DOCKER_CUA_BAN" // <-- Thay username của bạn
    }

    stages {
        stage('1. Lay Code') {
            steps {
                echo 'Dang keo code tu GitHub...'
                git branch: 'main', url: 'https://github.com/TEN_CUA_BAN/youtube-clone-devops.git' // <-- Thay URL của bạn
            }
        }

        stage('2. Cai dat thu vien') {
            steps {
                echo 'Dang chay npm install...'
                sh 'npm install'
            }
        }

        stage('3. Build Docker Image') {
            steps {
                echo 'Dang build Docker Image...'
                sh "docker build -t ${DOCKER_USER}/${APP_NAME}:latest ."
            }
        }

        stage('4. Push Image len DockerHub') {
            steps {
                echo 'Dang login va push...'
                sh "echo \$DOCKERHUB_CREDENTIALS_PSW | docker login -u \$DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh "docker push ${DOCKER_USER}/${APP_NAME}:latest"
            }
        }
    }

    post {
        always {
            echo 'Hoan tat Pipeline, dang don dep...'
            // Xóa image vừa build trên máy chủ Jenkins để tiết kiệm dung lượng
            sh "docker rmi ${DOCKER_USER}/${APP_NAME}:latest || true"
        }
    }
}
