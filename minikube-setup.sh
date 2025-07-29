#!/bin/bash

# Detect OS and architecture
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m)"

# Map architecture names
case "${ARCH}" in
    x86_64) ARCH="amd64" ;;
    aarch64|arm64) ARCH="arm64" ;;
esac

# Install Minikube
echo "Installing Minikube for ${OS}-${ARCH}..."
if [ "${OS}" = "darwin" ]; then
    # For macOS, use brew if available
    if command -v brew >/dev/null 2>&1; then
        brew install minikube
    else
        curl -LO "https://storage.googleapis.com/minikube/releases/latest/minikube-${OS}-${ARCH}"
        chmod +x minikube-${OS}-${ARCH}
        sudo mv minikube-${OS}-${ARCH} /usr/local/bin/minikube
    fi
else
    curl -LO "https://storage.googleapis.com/minikube/releases/latest/minikube-${OS}-${ARCH}"
    chmod +x minikube-${OS}-${ARCH}
    sudo mv minikube-${OS}-${ARCH} /usr/local/bin/minikube
fi

# Install kubectl
echo "Installing kubectl for ${OS}-${ARCH}..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/${OS}/${ARCH}/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Start Minikube
echo "Starting Minikube..."
if [ "${OS}" = "darwin" ]; then
    # For macOS, use hyperkit or docker driver
    if command -v hyperkit >/dev/null 2>&1; then
        minikube start --driver=hyperkit
    else
        minikube start --driver=docker
    fi
else
    minikube start --driver=docker
fi

# Enable Ingress addon
echo "Enabling Ingress addon..."
minikube addons enable ingress

# Install Helm
echo "Installing Helm..."
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

echo "Minikube setup complete!"
echo "Run 'minikube status' to verify the installation."
# Install Minikube
echo "Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Install kubectl
echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Start Minikube
echo "Starting Minikube..."
minikube start --driver=docker

# Enable Ingress addon
echo "Enabling Ingress addon..."
minikube addons enable ingress

# Install Helm
echo "Installing Helm..."
if [ "${OS}" = "darwin" ] && command -v brew >/dev/null 2>&1; then
    # For macOS, use brew if available
    brew install helm
else
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    rm get_helm.sh
fi

echo "Minikube setup complete!"
echo "Run 'minikube status' to verify the installation."
