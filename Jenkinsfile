pipeline {
    agent any

    environment {
        REPO_URL      = "https://github.com/Harendra-12/PHP.git"
        BRANCH        = "main"
        SSH_SERVER    = "Webserver"
        REMOTE_DIR    = "/root/webserver"
        IMAGE_NAME    = "php_app"
        IMAGE_TAG     = "latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: "${BRANCH}", url: "${REPO_URL}"
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image on Jenkins server
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Transfer Dockerfile to Webserver') {
            steps {
                // Using Publish Over SSH plugin
                sshPublisher(publishers: [
                    sshPublisherDesc(
                        configName: "${SSH_SERVER}",
                        transfers: [
                            sshTransfer(
                                sourceFiles: 'Dockerfile',
                                remoteDirectory: "${REMOTE_DIR}",
                                removePrefix: '',
                                flatten: true
                            )
                        ],
                        usePromotionTimestamp: false,
                        verbose: true
                    )
                ])
            }
        }
    }

    post {
        success {
            echo "✅ PHP Dockerfile transferred successfully to ${SSH_SERVER}:${REMOTE_DIR}"
        }
        failure {
            echo "❌ Pipeline failed. Check logs."
        }
    }
}
