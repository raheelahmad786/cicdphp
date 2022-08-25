pipeline {
    environment {
        registry = "raheelahmad20/cicd" 
        registryCredential = 'dockerhubphp' 
       // registry = 'cicdrepotemp'
        dockerImage = ''
    }
    agent any
    stages {
        stage('Build Docker Image PHP') {
            agent any
            steps {
                script {
                    dockerImage = docker.build registry + ":php$BUILD_NUMBER"
                }
            }
        }
        stage('Deploy our image') { 
            steps { 
                script { 
                    docker.withRegistry( '', registryCredential ) { 
                        dockerImage.push("php$BUILD_NUMBER") 
                    }
                } 
            }
        } 
        stage('Cleaning up') { 
            steps { 
                sh "docker rmi $registry:php$BUILD_NUMBER" 
            }
        }
        stage('Pull Image from Docker Hub & Deploy') { 
            steps { 
                sh 'docker ps -f name=phpc -q | xargs --no-run-if-empty docker container stop'
                sh 'docker container ls -a -fname=phpc -q | xargs -r docker container rm'
                sh "docker run -dt --name phpc -p 8080:80 $registry:php$BUILD_NUMBER" 
            }
        } 

    }
}
