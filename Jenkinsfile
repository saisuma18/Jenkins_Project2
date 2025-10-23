pipeline {
    agent any

    environment {
        IMAGE_NAME = 'my-node-app'
        DOCKER_HUB_USER = 'saisuma18@gmail.com' // Optional if pushing to Docker Hub
	DOCKER_HUB_CREDENTIALS = 'saisuma18@gmail.com' // Jenkins credentials ID for Docker Hub login
        AWS_REGION = 'ap-south-1'
        EKS_CLUSTER = 'my-eks-cluster-name'

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
	stage('Push Docker Image') {
            steps {
                script {
            docker.withRegistry('https://index.docker.io/v1/', 'saisuma18') {
                sh 'docker push my-node-app:latest'
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
 stage('Deploy to EKS') {
            steps {
                script {
                    // Configure kubectl to point to your EKS cluster
                    sh """
                    aws eks --region ${AWS_REGION} update-kubeconfig --name ${EKS_CLUSTER}
                    kubectl apply -f k8s/deployment.yaml
                    kubectl apply -f k8s/service.yaml
                    """
                }
            }
        }
    }
}
