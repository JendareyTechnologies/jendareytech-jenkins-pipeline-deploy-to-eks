#!/usr/bin/

pipeline {
    agent any
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
                        sh "aws eks --region us-east-1 update-kubeconfig --name votingapp-eks-cluster"
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
