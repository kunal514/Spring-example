pipeline {

  agent any
tools {
    maven 'Maven'
    jdk 'JDK1.8'
}
  stages {
    stage('Docker Build') {
      steps {
        sh "docker build -t kunal514/spring-example:${env.BUILD_NUMBER}"
      }
    }
    stage('Docker Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: '77bae009-0a0e-43ea-9c2e-293306a3e131', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
          sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
          sh "docker push kunal514/spring-example"
        }
      }
    }
/*     stage('Docker Remove Image') {
      steps {
        sh "docker rmi kunal514/spring-example"
      }
    } */
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
