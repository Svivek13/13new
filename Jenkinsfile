pipeline {
    
    agent any 
    
    environment{
        dockerImage = ''
        registry = 'vivek13s/java_app'
        CredentialId = 'docker_hub'
    }
    
    stages{
        stage('Checkout'){
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Svivek13/13new']]]) }
            }
        
        stage('Build Dockerimage'){
            steps {
                script{
                    dockerImage =  docker.build registry
                }
            }
        }
        
        stage('uploading Image'){
            steps{
                script{
                    docker.withRegistry(credentialsId: 'docker_hub', url: 'https://hub.docker.com/'){
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
