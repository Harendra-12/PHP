pipeline {
    agent any

    environment {
        REPO_URL    = "https://github.com/Harendra-12/PHP.git"
        BRANCH      = "main"
        SSH_SERVER  = "root@18.223.151.223"   // SSH_USER@HOST
        IMAGE_NAME  = "php_app"
        IMAGE_TAG   = "latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: "${BRANCH}", url: "${REPO_URL}"
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Direct Transfer Docker Image') {
            steps {
                // Stream Docker image directly to remote server
                sh "docker save ${IMAGE_NAME}:${IMAGE_TAG} | ssh ${SSH_SERVER} 'docker load'"
            }
        }
    }

    post {
        success {
            echo "✅ Docker image ${IMAGE_NAME}:${IMAGE_TAG} transferred and loaded successfully on ${SSH_SERVER}"
        }
        failure {
            echo "❌ Pipeline failed. Check logs for details."
        }
    }
}
