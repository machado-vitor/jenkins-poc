FROM jenkins/jenkins:lts

USER root

# Install Docker CLI
RUN apt-get update && \
    apt-get -y install apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    software-properties-common && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get -y install docker-ce-cli

# Install dependencies for building Scala projects
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk curl && \
    rm -rf /var/lib/apt/lists/*

# Switch back to jenkins user
USER jenkins

# Skip the initial setup wizard
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Install minimal core plugins and skip failures
RUN jenkins-plugin-cli --plugins git:latest workflow-aggregator:latest --skip-failed-plugins
