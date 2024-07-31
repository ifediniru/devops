pipeline{
  agent any
  stages{
    stage("Cloning Repo"){
      steps{
        echo "Cloning Repository"
      }
    }
    stage("Running Test"){
      parallel{
        stage("Running Sonarqube Test"){
          steps{
            echo "Running Sonarqube Test"
            sh "sleep 5"
          }
        }
        stage("Running JUnit Test"){
          steps{
            echo "Running JUnit Test"
            sh "sleep 5"
          }
        }
      }
    }
    stage("Building Package"){
      steps{
        echo "Building Maven Package"
        sh "sleep 5"
      }
    }
  }
}
