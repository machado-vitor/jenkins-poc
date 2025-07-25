# Jenkins on Docker
# Jenkins Docker Setup
# Flask Demo App with Jenkins Pipeline

## Overview

This project demonstrates a simple Flask application with a Jenkins CI/CD pipeline that:

1. Builds the application Docker image
2. Runs unit tests

## Application Structure

- `app/app.py` - The main Flask application
- `app/tests.py` - Unit tests for the application
- `app/requirements.txt` - Python dependencies
- `app/Dockerfile` - Docker configuration for the application
- `Jenkinsfile` - Jenkins pipeline definition

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

## Running the Application Locally

```bash
cd app
pip install -r requirements.txt
python app.py
```

Then access the application at http://localhost:5000

## Running Tests Locally

```bash
cd app
pip install -r requirements.txt
python -m pytest tests.py
```
## Getting Started

1. Run the start script: `./start-jenkins.sh`
2. Access Jenkins at http://localhost:8080
3. Use the printed admin password to log in

## Post-Installation

After Jenkins is running, you may need to install additional plugins through the Jenkins UI:

1. Go to "Manage Jenkins" > "Manage Plugins" > "Available"
2. Search for and install the following plugins:
   - Scala Plugin
   - SBT Plugin
   - JUnit Plugin
   - Docker Pipeline

This approach is more reliable than pre-installing all plugins during image build.

## Troubleshooting

If you encounter plugin installation issues:

1. Try installing plugins one by one through the Jenkins UI
2. Check Jenkins logs: `docker logs jenkins`
3. For persistent issues, use the LTS version of plugins instead of 'latest'
This repository contains configuration to run Jenkins in Docker optimized for Scala/Java development with sbt.

## Features

- Jenkins LTS with Docker CLI support
- Pre-installed plugins for Scala/Java development
- Persistent Jenkins home directory
- Docker socket mounted to allow Jenkins to use the host's Docker daemon

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
