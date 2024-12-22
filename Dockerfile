FROM jenkins/jenkins:lts  

USER root  

RUN apt-get update && \  
    apt-get install -y apt-transport-https ca-certificates curl gnupg2 lsb-release && \  

    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \  

    echo "deb [arch=amd64] https://download.docker.com/linux/debian bookworm stable" | tee \
    /etc/apt/sources.list.d/docker.list && \  

    apt-get update && \  

    apt-get install -y docker-ce-cli  

USER jenkins  
