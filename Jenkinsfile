pipeline {
    environment {
        registry = "raheelahmad20/cicd" 
        registryCredential = 'dockerhub' 
       // registry = 'cicdrepotemp'
        dockerImage = ''
    }
    agent any
    stages {
        stage('Build Docker Image PHP') {
            agent any
            steps {
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Deploy our image') { 
            steps { 
                script { 
                    docker.withRegistry( '', registryCredential ) { 
                        dockerImage.push() 
                    }
                } 
            }
        } 
        stage('Cleaning up') { 
            steps { 
                sh "docker rmi $registry:$BUILD_NUMBER" 
            }
        }
        stage('Pull Image from Docker Hub & Deploy') { 
            steps { 
                sh 'docker ps -f name=phpc -q | xargs --no-run-if-empty docker container stop'
                sh 'docker container ls -a -fname=phpc -q | xargs -r docker container rm'
                sh "docker run -dt --name phpc -p 8080:80 $registry:$BUILD_NUMBER" 
            }
        } 

    }
}
