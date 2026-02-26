pipeline {
    agent any
 
    tools {
        jdk 'java21'
        maven 'local_maven'
    }
 
    environment {
        IMAGE_NAME = "java-tomcat-app"
        CONTAINER_NAME = "tomcat-app"
    }
 
    stages {
 
        stage('Checkout Code') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/ixsnehith/java-tomcat-sample-docker.git'
            }
        }
 
        stage('Build WAR with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }
 
        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }
 
        stage('Deploy on Docker (Tomcat)') {
            steps {
                sh """
                echo "Stopping old container if exists..."
                docker stop ${CONTAINER_NAME} || true
                docker rm ${CONTAINER_NAME} || true

                echo "Running new container..."
                docker run -d -p 9090:8080 --name ${CONTAINER_NAME} ${IMAGE_NAME}:latest

                echo "Listing running containers..."
                docker ps
                """
            }
        }
    }
 
    post {
        success {
            echo "Deployment successful! Access app at http://<EC2-PUBLIC-IP>:9090"
        }
        failure {
            echo "Deployment failed. Check logs."
        }
    }
}
