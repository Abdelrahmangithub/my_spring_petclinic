pipeline {
    agent any
   /* tools {
        maven 'Maven 3.6.3' // Ensure Maven is configured in Jenkins
        jdk 'JDK 11'       // Ensure JDK is configured in Jenkins
    }*/
    

    environment {
        // Define any environment variables here
        //SLACK_TOKEN = credentials('slack-cred')
        NEXUS_REPO_ID = 'nexus-releases'
    }

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
       /* stage('Test') {
            steps {
                echo 'Testing...'
                sh 'mvn test'
            }
        }*/
        stage('run') {
            steps {
                echo 'run...'
                sh '''
                    docker rm -f petclinic_container
                    docker build -t spring-petclinic .
                    docker run -d -p 9193:9966 --name petclinic_container spring-petclinic
                ''' 
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonarLocal') {
                    /*sonarLocal is the server that i created in manage jenkins ==> system ==> sonarqube after download sonarqube plugin */
                    sh 'mvn clean verify sonar:sonar -Dsonar.projectKey=petclinic -Dsonar.projectName=petclinic'
                }
            }
         /*   def mvn = tool 'Default Maven';
            withSonarQubeEnv() {
                sh "${mvn}/bin/mvn clean verify sonar:sonar -Dsonar.projectKey=petclinic -Dsonar.projectName='petclinic'"
            }*/
        }
        stage('Deploy to Nexus') {
            steps {
                sh """
                    mvn deploy -DaltDeploymentRepository=nexus-releases::http://localhost:8081/repository/maven-releases_jenkins/ -s /var/lib/jenkins/.m2/settings.xml
                """
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



    
}























