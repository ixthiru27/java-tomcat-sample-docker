pipeline {

    agent any
 
    tools {

        jdk 'java21'

        maven 'maven-3'

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

                sh 'docker build -t $IMAGE_NAME:latest .'

            }

        }
 
        stage('Deploy on Docker (Tomcat)') {

            steps {

                sh '''

                docker stop $CONTAINER_NAME || true

                docker rm $CONTAINER_NAME || true
 
                docker run -d \

                  -p 9090:8080 \

                  --name $CONTAINER_NAME \

                  $IMAGE_NAME:latest

                '''

            }

        }

    }
 
    post {

        success {

            echo "Deployment successful!"

        }

        failure {

            echo "Deployment failed. Check logs."

        }

    }

}
 
