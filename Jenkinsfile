pipeline { 
    agent any  // Указывает, что pipeline может выполняться на любом доступном агенте.

    stages { 
        stage('Checkout') {  // Этап проверки исходного кода из репозитория.
            steps { 
                checkout scm  // Извлекает код из системы управления версиями, настроенной для проекта.
            } 
        } 

        stage('Build Docker Image') {  // Этап сборки Docker-образа.
            steps { 
                script { 
                    def image = docker.build("architecture_image:${env.BUILD_ID}") 
                    // Создаём Docker-образ с тегом, включающим уникальный идентификатор сборки (${env.BUILD_ID}).
                } 
            } 
        } 

        stage('Deploy') {  // Этап развертывания контейнера.
            steps { 
                script { 
                    sh 'docker stop architecture_container || true' 
                    // Останавливаем контейнер с именем architecture_container, если он существует. Ошибки игнорируются.
                    
                    sh 'docker rm architecture_container || true' 
                    // Удаляем контейнер с именем architecture_container, если он существует. Ошибки игнорируются.
                    
                    sh "docker run -d --name architecture_container -p 8081:8080 architecture_image:${env.BUILD_ID}" 
                    // Запускаем новый контейнер из созданного Docker-образа:
                    // -d: работает в фоновом режиме.
                    // --name: задаём имя контейнера architecture_container.
                    // -p: перенаправляем порт 8080 контейнера на 8081 хоста.
                } 
            } 
        } 
    } 

    post { 
        always {  // Выполняется после всех этапов, независимо от успешности сборки.
            script { 
                sh 'docker image prune -f' 
                // Удаляем неиспользуемые Docker-образы, чтобы освободить место.
            } 
        } 
    } 
}
