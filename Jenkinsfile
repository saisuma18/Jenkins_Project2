pipeline{
    agents {
        docker {image 'your-dockerhub-username/custom-node:16'}
    }
    
    stages
    {
        stage('Test')
        {
        steps
        {
            sh 'node --version'
        }
        }
        stage('Build')
        {
        steps
        {
            sh 'node --version'
        }
        }
    }
}