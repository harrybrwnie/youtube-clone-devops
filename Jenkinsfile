pipeline {
    agent any

    tools {
        nodejs 'node18'
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

        stage('2. Quet code (SonarQube)') {
            steps {
                echo 'Gui code sang SonarQube kiem tra'
                withSonarQubeEnv('sonar-server') { 
                    sh '''
                    NODE_PATH=$(which node)
                    echo "Dung NodeJS tai $NODE_PATH"
                    $SCANNER_HOME/bin/sonar-scanner \
                    -Dsonar.organization=harrybrwnie \
                    -Dsonar.projectKey=harrybrwnie_youtube-clone-devops \
                    -Dsonar.sources=src \
                    -Dsonar.exclusions=**/node_modules/** \
                    -Dsonar.nodejs.executable=$NODE_PATH
                    '''
                }
            }
        }


        stage('3. Quet Thu vien (Trivy FS)') {
            steps {
                echo 'Bat dau quet thu vien bang Trivy...'
                sh "trivy fs --format table -o trivy-fs-report.txt --severity HIGH,CRITICAL ."
            }
        }

        stage('4. Cai dat thu vien & Build') {
            steps {
                echo 'Dang chay npm install...'
                sh 'npm install'
            }
        }

        stage('5. Build Docker Image') {
            steps {
                echo 'Dang build Docker Image...'
                sh "docker build -t ${DOCKER_USER}/${APP_NAME}:latest ."
            }
        }

        stage('6. Quet Docker Image (Trivy Image)') {
            steps {
                echo 'Kiem tra he dieu hanh cua Image vua Build...'
                sh "trivy image --format table -o trivy-image-report.txt --severity HIGH,CRITICAL ${DOCKER_USER}/${APP_NAME}:latest"
            }
        }

        stage('7. Push Image len DockerHub') {
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
            sh "docker rmi ${DOCKER_USER}/${APP_NAME}:latest || true"
        }
    }
}
