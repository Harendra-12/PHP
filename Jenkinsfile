pipeline {
    agent any

    environment {
        REPO_URL   = "https://github.com/Harendra-12/PHP.git"
        BRANCH     = "main"
        SSH_SERVER = "Webserver"
        IMAGE_NAME = "php_app"
        IMAGE_TAG  = "latest"
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

        stage('Transfer Docker Image to Webserver') {
            steps {
                sh """
                    docker save ${IMAGE_NAME}:${IMAGE_TAG} | \
                    ssh -o StrictHostKeyChecking=no root@${SSH_SERVER} 'docker load'
                """
            }
        }
    }

    post {
        success {
            echo "✅ Docker image transferred successfully to ${SSH_SERVER}"
        }
        failure {
            echo "❌ Pipeline failed. Check logs."
        }
    }
}
