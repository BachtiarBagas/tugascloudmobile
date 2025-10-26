pipeline {
    agent any
    environment {
        IMAGE_NAME = "bagasfathoni/react-bank-app" 
    }
    stages {
        stage('Checkout') {
            steps {
                // 1. Ambil kode dari GitHub
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                // 2. Build image menggunakan Dockerfile
                bat 'docker build -t %IMAGE_NAME%:%BUILD_NUMBER% .'
                bat 'docker tag %IMAGE_NAME%:%BUILD_NUMBER% %IMAGE_NAME%:latest'
            }
        }
        stage('Login to Docker Hub') {
            steps {
                // 3. Login ke Docker Hub (pastikan credentialsId sudah benar)
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', 
                                                   usernameVariable: 'USER', 
                                                   passwordVariable: 'PASS')]) {
                    bat 'docker login -u %USER% -p %PASS%'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                // 4. Push image ke Docker Hub
                bat 'docker push %IMAGE_NAME%:%BUILD_NUMBER%'
                bat 'docker push %IMAGE_NAME%:latest'
            }
        }
    }
}