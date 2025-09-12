pipeline {
    agent any
   /* tools {
        maven 'Maven 3.6.3' // Ensure Maven is configured in Jenkins
        jdk 'JDK 11'       // Ensure JDK is configured in Jenkins
    }*/

    /*environment {
        // Define any environment variables here
        SLACK_TOKEN = credentials('slack-cred')
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
                sh '''
                    docker build -t spring-petclinic .
                    docker run -d -p 9193:9966 spring-petclinic
                ''' 
            }
        }
    }

    post {
    success {
        
            slackSend (
                channel: '#social',
                tokenCredentialId: 'slack-cred',
                message: "✅ Pipeline ${env.JOB_NAME} - Build #${env.BUILD_NUMBER} succeeded! \nURL: ${env.BUILD_URL}"
            )
        
    }
    failure {
            slackSend (
                channel: '#social',
                tokenCredentialId: 'slack-cred',
                message: "❌ Pipeline ${env.JOB_NAME} - Build #${env.BUILD_NUMBER} failed! \nURL: ${env.BUILD_URL}"
            )
        
    }
}

   /* post {
    always {
        echo 'This will always run after the stages finish.'
    }
    success {
        slacksend channel: '#social', 
                  color: 'good', 
                  message: "The Pipeline ${env.JOB_NAME} - Build #${env.BUILD_NUMBER} was successful! \nCheck it out at ${env.BUILD_URL}"
    }
    failure {
        slacksend channel: '#social', 
                  color: 'danger', 
                  message: "The Pipeline ${env.JOB_NAME} - Build #${env.BUILD_NUMBER} has failed. \nCheck it out at ${env.BUILD_URL}"
    }
}*/

    
}









