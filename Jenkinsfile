pipeline {

  agent any
tools {
    maven 'Maven'
    jdk 'JDK1.8'
}
  stages {
    stage('Docker Build') {
      steps {
        sh "docker build -t kunal514/spring-example ."
      }
    }
    stage('Docker Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'https://hub.docker.com/', passwordVariable: 'Kunal@1234', usernameVariable: 'kunal514')]) {
          sh "docker login -u kunal514 -p Kunal@1234"
          sh "docker push kunal514/spring-example"
        }
      }
    }
    stage('Docker Remove Image') {
      steps {
        sh "docker rmi kunal514/spring-example"
      }
    }
    stage('Apply Kubernetes Files') {
      steps {
          withKubeConfig([credentialsId: 'kubeconfig']) {
          sh 'cat deployment.yaml | sed "s/{{BUILD_NUMBER}}/$BUILD_NUMBER/g" | kubectl apply -f -'
          sh 'kubectl apply -f service.yaml'
        }
      }
  }
}
post {
    success {
      slackSend(message: "sbmvn Pipeline is successfully completed.")
    }
    failure {
      slackSend(message: "sbmvn Pipeline failed. Please check the logs.")
    }
}
}
