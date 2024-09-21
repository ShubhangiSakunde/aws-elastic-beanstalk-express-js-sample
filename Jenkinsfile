pipeline {
            agent {
                docker {
                    image 'node:16'
                    args '-v ${WORKSPACE}:/app'
                }
            }
    environment {
        DOCKER_IMAGE = "shubh26/dind-node-jenkins"
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build and Test') {

            steps {
                echo "Installing Dependencies"
                sh "npm cache clean --force"
                sh 'npm install --save'
                sh "npm test"
            }
        }
        stage("SynkSecurity") {
            steps {
                echo 'Scanning using Snyk Security...'
                snykSecurity(
                    snykInstallation: 'synk',
                    snykTokenId: 'SYNK-TOKEN',
                    severity: "critical"
                )
            }
        }
        stage('Build and Push Docker Image') {
            agent any
            steps {
                script {
                    def timestamp = new Date().format("yyyyMMdd_HHmmss")
                    def imageTag = "${BUILD_NUMBER}-${timestamp}"
                    
                    sh "docker build -t ${DOCKER_IMAGE}:${imageTag} ."
                    
                    withCredentials([usernamePassword(credentialsId: 'dockerhub_id', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        sh 'echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin'
                    }
                    
                    sh "docker push ${DOCKER_IMAGE}:${imageTag}"
                    sh "docker tag ${DOCKER_IMAGE}:${imageTag} ${DOCKER_IMAGE}:latest"
                    sh "docker push ${DOCKER_IMAGE}:latest"
                }
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'snyk-report.json', allowEmptyArchive: true
        }
    }
}
