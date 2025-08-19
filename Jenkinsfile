pipeline {
    agent any

    environment {
        REPO_URL   = "https://github.com/Harendra-12/PHP.git"
        BRANCH     = "main"
        SSH_SERVER = "Webserver"
        REMOTE_DIR = "/PHP"
        IMAGE_NAME = "php_app"
        IMAGE_TAG  = "latest"
        IMAGE_FILE = "php_app.tar"
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
                sh "docker save -o ${IMAGE_FILE} ${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }

        stage('Transfer Docker Image to Webserver') {
            steps {
                sshPublisher(publishers: [
                    sshPublisherDesc(
                        configName: "${SSH_SERVER}",
                        transfers: [
                            sshTransfer(
                                sourceFiles: "${IMAGE_FILE}",
                                remoteDirectory: "${REMOTE_DIR}",
                                flatten: true
                            )
                        ],
                        verbose: true
                    )
                ])
            }
        }
    }

    post {
        success {
            echo "✅ Docker image transferred successfully to ${SSH_SERVER}:${REMOTE_DIR}"
        }
        failure {
            echo "❌ Pipeline failed. Check logs."
        }
    }
}
