pipeline {
    agent any

    environment {
        IMAGE_NAME = 'my-node-app'
        DOCKER_HUB_USER='saisuma18' 
        DOCKER_IMAGE = "${DOCKER_HUB_USER}/my-node-app:latest"
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
                    dockerImage = docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Push Docker Image') {
    steps {
        withCredentials([usernamePassword(credentialsId: 1021d593-8e58-4683-bfb7-e7a6a5bad90e, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
            sh '''
                echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                docker push $DOCKER_IMAGE
                    '''
        }
    }
}

        stage('Run Tests') {
            steps {
                script {
                    docker.image("${IMAGE_NAME}").inside {
                        sh 'npm install'
                        echo "Skipping tests"
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG_FILE')]) {
                    sh '''
                        export KUBECONFIG=$KUBECONFIG_FILE
                        kubectl apply -f deployment.yaml
                        kubectl apply -f service.yaml
                    '''
                }
            }
        }
    }
}

