FROM jenkins/jenkins:lts  
# Используется базовый образ Jenkins с поддержкой долгосрочной версии (LTS).

USER root  
# Переходим в пользователя root для выполнения команд установки, так как они требуют привилегий суперпользователя.

# Установка Docker CLI
RUN apt-get update && \  
    apt-get install -y apt-transport-https ca-certificates curl gnupg2 lsb-release && \  
    # Устанавливаем необходимые пакеты для загрузки и добавления репозитория Docker.

    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \  
    # Скачиваем и добавляем GPG-ключ для верификации пакетов Docker.

    echo "deb [arch=amd64] https://download.docker.com/linux/debian bookworm stable" | tee \
    /etc/apt/sources.list.d/docker.list && \  
    # Добавляем официальный репозиторий Docker для Debian (bookworm - кодовое имя версии).

    apt-get update && \  
    # Обновляем список пакетов с учетом нового репозитория.

    apt-get install -y docker-ce-cli  
    # Устанавливаем Docker CLI (инструмент командной строки для управления Docker).

USER jenkins  
# Возвращаемся к пользователю jenkins для безопасности, так как дальнейшая работа Jenkins не требует прав root.
