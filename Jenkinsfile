pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/ifediniru/docker_local.git'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                script {
                    echo "Branch detected: ${env.BRANCH_NAME}"

                    if (env.BRANCH_NAME == 'dev') {
                        currentBuild.displayName = 'dev'
                        env.ENVIRONMENT = 'dev'
                    } else if (env.BRANCH_NAME == 'staging') {
                        currentBuild.displayName = 'staging'
                        env.ENVIRONMENT = 'staging'
                    } else if (env.BRANCH_NAME == 'main') {
                        currentBuild.displayName = 'production'
                        env.ENVIRONMENT = 'production'
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
                    def repoDir = "repo-${env.ENVIRONMENT}-${env.BUILD_ID}"
                    echo "Cloning repository from ${env.REPO_URL} into ${repoDir}..."
                    sh "git clone ${env.REPO_URL} ${repoDir}"
                    env.REPO_DIR = repoDir
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    echo "Building app for ${env.ENVIRONMENT}..."
                    // Build logic here
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    if (env.ENVIRONMENT == 'dev') {
                        deployToDev(env.REPO_DIR)
                    } else if (env.ENVIRONMENT == 'staging') {
                        deployToStaging(env.REPO_DIR)
                    } else if (env.ENVIRONMENT == 'production') {
                        deployToProduction(env.REPO_DIR)
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

def deployToDev(repoDir) {
    echo "Deploying to Dev..."
    sh "cd ${repoDir} && ./deploy_dev.sh"
}

def deployToStaging(repoDir) {
    echo "Deploying to Staging..."
    sh "cd ${repoDir} && ./deploy_staging.sh"
}

def deployToProduction(repoDir) {
    echo "Deploying to Production..."
    sh "cd ${repoDir} && ./deploy_prod.sh"
}
