pipeline {
    agent any

    environment {
        IMAGE_NAME = 'my-node-app'
        DOCKER_HUB_USER = 'saisuma18@gmail.com' // Optional if pushing to Docker Hub
	    DOCKER_HUB_PASSWORD = credentials('docker-hub-password')
        KUBE_CONFIG = credentials('kubeconfig') // Jenkins secret text or file for kubectl access

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
                    dockerImage =docker.build("${IMAGE_NAME}")
                }
            }
        }
	stage('Push Docker Image') {
            steps {
                script {
            docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_HUB_USER}") {
                dockerImage.push("latest")
                    }
                }
            }
        }

        stage('Run Tests') {
             steps {
        script {
            docker.image('my-node-app').inside {
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