pipeline { 
    agent any

    stages { 
        stage('Checkout') {
            steps { 
                checkout scm
            } 
        } 

        stage('Build Docker Image') {
            steps { 
                script { 
                    def image = docker.build("architecture_image:${env.BUILD_ID}") 
                } 
            } 
        } 

        stage('Deploy') {
            steps { 
                script { 
                    sh 'docker stop architecture_container || true' 
                    
                    sh 'docker rm architecture_container || true' 
                    
                    sh "docker run -d --name architecture_container -p 8081:8080 architecture_image:${env.BUILD_ID}" 
                } 
            } 
        } 
    } 

    post { 
        always {
            script { 
                sh 'docker image prune -f' 
            } 
        } 
    } 
}
