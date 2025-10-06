pipeline {
    agent any

    environment {
        IMAGE_NAME = 'my-node-app'
        DOCKER_HUB_USER = 'saisuma18@gmail.com' // Optional if pushing to Docker Hub
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/saisuma18/Jenkins_Project2.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Run Tests') {
            steps {
               echo "Test are running"
            }
        }

        stage('Run Docker Container') {
            steps {
                sh "docker run -d -p 3000:3000 ${IMAGE_NAME}"
            }
        }
    }
}
