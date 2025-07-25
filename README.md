# Jenkins on Docker
# Jenkins Docker Setup
# Flask Demo App with Jenkins Pipeline

## Overview

This project demonstrates a simple Jenkins CI/CD pipeline that:

## Jenkins Setup

1. Run the Jenkins container with Docker support:
   ```
   ./start-jenkins.sh
   ```

2. Access Jenkins at http://localhost:8080

3. Create a new Pipeline job:
   - Go to Jenkins Dashboard > New Item
   - Enter a name (e.g., "flask-pipeline")
   - Select "Pipeline" and click OK
   - In the Pipeline section, select "Pipeline script from SCM"
   - Select "Git" as SCM
   - Enter your repository URL
   - Set the Script Path to "Jenkinsfile"
   - Save the configuration

4. Run the pipeline by clicking "Build Now"

## Getting Started

1. Run the start script: `./start-jenkins.sh`
2. Access Jenkins at http://localhost:8080

## Prerequisites

- Docker and Docker Compose installed on your host machine

## Getting Started

1. Clone this repository
2. Run the following command to start Jenkins:

```bash
docker-compose up -d
```

3. Access Jenkins at http://localhost:8080

## Configure Jenkins for Scala/Java Projects

1. Create a new Pipeline job
2. Use the Jenkinsfile from your Scala project
3. Configure the job to use the appropriate JDK and sbt version

## Stopping Jenkins

```bash
docker-compose down
```

To remove all data including the Jenkins home volume:

```bash
docker-compose down -v
```

## Security Considerations

For production use, consider:

1. Setting up proper authentication
2. Using HTTPS
3. Restricting permissions on the Docker socket
4. Using credentials management for sensitive information
