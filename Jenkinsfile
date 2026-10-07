pipeline {

    agent any

    environment {
        IMAGE_NAME = "thotakoushikreddy/week9-devops-cicd"
        IMAGE_TAG = "latest"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Building application...'
                sh 'ls -la'
            }
        }

        stage('Test') {
            steps {
                echo 'Running automated tests...'
                sh 'chmod +x test.sh'
                sh './test.sh'
            }
        }

        stage('Package') {
    steps {
        echo 'Building Docker image...'
        sh '''
            export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
            docker --version
            docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
        '''
    }
}

        stage('Push Docker Image') {
    steps {
        echo 'Pushing Docker image...'

        withCredentials([
            usernamePassword(
                credentialsId: 'dockerhub-credentials',
                usernameVariable: 'DOCKER_USERNAME',
                passwordVariable: 'DOCKER_PASSWORD'
            )
        ]) {

            sh '''
                export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"

                echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                docker push ${IMAGE_NAME}:${IMAGE_TAG}
                docker logout
            '''
        }
    }
}

    post {
        success {
            echo 'CI/CD PIPELINE SUCCESSFUL'
        }

        failure {
            echo 'CI/CD PIPELINE FAILED'
        }
    }
}
