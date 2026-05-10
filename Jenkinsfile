pipeline {
    agent any

    tools {
        nodejs 'node16'
        'hudson.plugins.sonar.SonarRunnerInstallation' 'sonar-scanner'
    }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker')
        APP_NAME = "youtube-clone"
        DOCKER_USER = "h4rrybrwnie"
        SCANNER_HOME = tool 'sonar-scanner'
    }

    stages {
        stage('1. Lay Code') {
            steps {
                echo 'Dang keo code tu GitHub...'
                git credentialsId: 'github-token', branch: 'main', url: 'https://github.com/harrybrwnie/youtube-clone-devops.git'
            }
        }

//        stage('2. Quet code (SonarQube)') {
//            steps {
//                echo 'Gui code sang SonarQube kiem tra'
//                withSonarQubeEnv('sonar-server') { 
//                    sh '''
//                    $SCANNER_HOME/bin/sonar-scanner \
//                    -Dsonar.organization=harrybrwnie \
//                    -Dsonar.projectKey=harrybrwnie_youtube-clone-devops \
//                    -Dsonar.sources=src \
//                    -Dsonar.exclusions=**/node_modules/**
//                    '''
//                }
//            }
//        }


        stage('3. Quet Thu vien (Trivy FS)') {
            steps {
                echo 'Bat dau quet thu vien bang Trivy...'
                sh "trivy fs --format table -o trivy-fs-report.txt --severity HIGH,CRITICAL ."
            }
        }
        stage('4. Cai dat thu vien') {
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
