pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                dir('app') {
                    sh 'docker build -t flask-demo:${BUILD_NUMBER} -f Dockerfile .'
                }
                echo 'Build completed successfully!'
            }
        }

        stage('Test') {
            steps {
                dir('app') {
                    sh '''
                        docker run --rm -v "$(pwd)":/app -w /app python:3.9-slim pip install -r requirements.txt
                        docker run --rm -v "$(pwd)":/app -w /app python:3.9-slim python -m pytest tests.py -v
                    '''
                }
                echo 'Tests completed successfully!'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
