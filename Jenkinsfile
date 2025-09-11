pipeline {
    agent any
   /* tools {
        maven 'Maven 3.6.3' // Ensure Maven is configured in Jenkins
        jdk 'JDK 11'       // Ensure JDK is configured in Jenkins
    }*/

    /*environment {
        // Define any environment variables here
        WEB_HOOK_URL = credentials('slack-webhook-url')
    }*/

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', 
                url: 'https://github.com/Abdelrahmangithub/spring-petclinic'
            }
        }
        stage('Build') {
            steps {
                echo 'Building...'
                sh 'mvn clean package -DskipTests'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                sh 'mvn test'
            }
        }
        stage('run') {
            steps {
                echo 'run...'
                sh 'chmod +x deploy.sh'
                sh './deploy.sh'
            }
        }
    }

    post {
    always {
        echo 'This will always run after the stages finish.'
    }
    success {
        slacksend channel: '#social', 
                  color: 'good', 
                  message: "The Pipeline ${env.JOB_NAME} - Build #${env.BUILD_NUMBER} was successful! \nCheck it out at ${env.BUILD_URL}"
        emailext subject: "Build Success: ${env.JOB_NAME} - #${env.BUILD_NUMBER}",
                 body: "The pipeline ${env.JOB_NAME} build #${env.BUILD_NUMBER} succeeded.\nCheck details at ${env.BUILD_URL}",
                 to: 'abdelrahmanayman000@gmail.com',
                 mimeType: 'text/plain'
    }
    failure {
        slacksend channel: '#social', 
                  color: 'danger', 
                  message: "The Pipeline ${env.JOB_NAME} - Build #${env.BUILD_NUMBER} has failed. \nCheck it out at ${env.BUILD_URL}"
        emailext subject: "Build Failed: ${env.JOB_NAME} - #${env.BUILD_NUMBER}",
                 body: "The pipeline ${env.JOB_NAME} build #${env.BUILD_NUMBER} failed.\nCheck details at ${env.BUILD_URL}",
                 to: 'abdelrahmanayman000@gmail.com',
                 mimeType: 'text/plain'
    }
}
}


