#!/usr/bin/

pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage("Creating a Votingapp EKS Cluster") {
            steps {
                script {
                    dir('terraform') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }
        stage("Deploying to Votingapp EKS Cluster") {
            steps {
                script {
                    dir('kubernetes') {
                        sh "aws eks update-kubeconfig --name myapp-eks-cluster"
                        sh "kubectl apply -f mongodb-manifest.yaml"
                        sh "kubectl apply -f mongodb-service-manifest.yaml"
                        sh "kubectl apply -f votingapp-manifest.yaml"
                        sh "kubectl apply -f votingapp-service-manifest.yaml"
                    }
                }
            }
        }
    }
}
