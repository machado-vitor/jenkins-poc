# Kubernetes Deployment for Flask Application

## Prerequisites

- Minikube installed
- kubectl installed
- Helm 3 installed

### macOS specific prerequisites

For macOS users, especially on Apple Silicon (ARM):

- You can install prerequisites using Homebrew:
  ```bash
  brew install minikube kubectl helm
  ```

- For optimal performance, consider installing the hyperkit driver:
  ```bash
  brew install hyperkit
  ```

## Setup Minikube

Run the setup script to install and configure Minikube:

```bash
chmod +x minikube-setup.sh
./minikube-setup.sh
```

## Deploy the Application

### Manual Deployment

1. Start Minikube if not already running:
   ```bash
   minikube start
   ```

2. Build the Docker image:
   ```bash
   docker build -t flask-demo-app:latest -f app/Dockerfile app/
   ```

3. Load the Docker image into Minikube:
   ```bash
   minikube image load flask-demo-app:latest
   ```

4. Deploy using Helm:
   ```bash
   helm upgrade --install flask-app ./helm/flask-app \
     --set image.repository=flask-demo-app \
     --set image.tag=latest \
     --set image.pullPolicy=Never
   ```

### Jenkins Deployment

The Jenkins pipeline includes a stage to deploy the application to Kubernetes. Simply run the pipeline and it will:

1. Build the Docker image
2. Load it into Minikube
3. Deploy it using Helm

## Accessing the Application

1. Get the URL to access the application:
   ```bash
   minikube service flask-app --url
   ```

2. If using Ingress, add the hostname to your hosts file:
   ```bash
   echo "$(minikube ip) flask-app.local" | sudo tee -a /etc/hosts
   ```
   Then access the application at http://flask-app.local
# Kubernetes Deployment for Flask Application

## Prerequisites

- Minikube installed
- kubectl installed
- Helm 3 installed

## Setup Minikube

Run the setup script to install and configure Minikube:

```bash
chmod +x minikube-setup.sh
./minikube-setup.sh
```

## Project Structure

The Flask application and its Helm chart are located in the Flask app project repository.
This Jenkins repository accesses the Jenkinsfile from the Flask app project to build and deploy the application.

## Deploy the Application

### Manual Deployment

1. Start Minikube if not already running:
   ```bash
   minikube start
   ```

2. Build the Docker image:

   #### Linux:
   ```bash
   cd path/to/flask/app
   docker build -t flask-demo-app:latest .
   minikube image load flask-demo-app:latest
   ```

   #### macOS:
   ```bash
   # Configure Docker to use the Minikube daemon
   eval $(minikube docker-env)

   # Build the image directly in Minikube's Docker daemon
   cd path/to/flask/app
   docker build -t flask-demo-app:latest .
   ```

4. Deploy using Helm from the Flask app directory:
   ```bash
   cd path/to/flask/app
   helm upgrade --install flask-app ./helm/flask-app \
     --set image.repository=flask-demo-app \
     --set image.tag=latest \
     --set image.pullPolicy=Never
   ```

### Jenkins Deployment

The Jenkins pipeline includes a stage to deploy the application to Kubernetes. Simply run the pipeline and it will:

1. Build the Docker image
2. Load it into Minikube
3. Deploy it using the Helm chart from the Flask app repository

## Accessing the Application

1. Get the URL to access the application:
   ```bash
   minikube service flask-app --url
   ```

2. If using Ingress, add the hostname to your hosts file:
   ```bash
   echo "$(minikube ip) flask-app.local" | sudo tee -a /etc/hosts
   ```
   Then access the application at http://flask-app.local

## Troubleshooting

- Check the pod status:
  ```bash
  kubectl get pods
  ```

- Check pod logs:
  ```bash
  kubectl logs -l app.kubernetes.io/name=flask-app
  ```

- Check service status:
  ```bash
  kubectl get svc
  ```

- Check ingress status:
  ```bash
  kubectl get ingress
  ```
## Troubleshooting

- Check the pod status:
  ```bash
  kubectl get pods
  ```

- Check pod logs:
  ```bash
  kubectl logs -l app.kubernetes.io/name=flask-app
  ```

- Check service status:
  ```bash
  kubectl get svc
  ```

- Check ingress status:
  ```bash
  kubectl get ingress
  ```
