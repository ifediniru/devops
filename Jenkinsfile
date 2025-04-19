pipeline {
    agent any

    environment {
        ENVIRONMENT = ''
        REPO_URL = 'https://github.com/ifediniru/docker_local.git'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                script {
                    echo "Branch detected: ${env.BRANCH_NAME}"

                    if (${env.BRANCH_NAME} == 'dev') {
                        ${env.BRANCH_NAME} = 'dev'
                    } else if (${env.BRANCH_NAME} == 'staging') {
                        ${env.BRANCH_NAME} = 'staging'
                    } else if (${env.BRANCH_NAME} == 'main') {
                        ${env.BRANCH_NAME} = 'production'
                    } else {
                        error "Unknown branch: ${env.BRANCH_NAME}"
                    }

                    echo "Environment set to: ${env.ENVIRONMENT}"
                }
            }
        }

        stage('Clone Repository') {
            steps {
                script {
                    echo "Cloning repository from ${env.REPO_URL}..."
                    sh "git clone ${env.REPO_URL} repo"
                }
            }
        }

        stage('Build') {
            steps {
                echo "Building app for ${env.ENVIRONMENT}..."
                // Build logic here
            }
        }

        stage('Deploy') {
            steps {
                script {
                    if (env.ENVIRONMENT == 'dev') {
                        deployToDev()
                    } else if (env.ENVIRONMENT == 'staging') {
                        deployToStaging()
                    } else if (env.ENVIRONMENT == 'production') {
                        deployToProduction()
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Successfully deployed to ${env.ENVIRONMENT} environment."
        }
        failure {
            echo "Deployment failed for ${env.ENVIRONMENT}."
        }
    }
}

def deployToDev() {
    echo "Deploying to Dev..."
    sh "cd repo && ./deploy_dev.sh"
}

def deployToStaging() {
    echo "Deploying to Staging..."
    sh "cd repo && ./deploy_staging.sh"
}

def deployToProduction() {
    echo "Deploying to Production..."
    sh "cd repo && ./deploy_prod.sh"
}
