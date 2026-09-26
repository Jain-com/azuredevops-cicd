# End-to-End DevOps Project: Multi-Microservice Voting App on AKS (Azure Kubernetes Service)

This project demonstrates a production-grade CI/CD and GitOps pipeline automating the deployment of a containerized multi-tier voting application. It leverages **Azure DevOps** for continuous integration, **Docker** for containerization, **Azure Container Registry (ACR)** for image storage, and **Kubernetes (AKS)** for orchestration.

---

# 🏗️ Architecture & Workflow

<img width="860" height="800" alt="image" src="https://github.com/user-attachments/assets/6e7b53cb-6413-46f7-9f72-7448f8f52d36" />


1. **Source Code Management:** Application code and Kubernetes configuration files are maintained in version control repositories.
2. **Continuous Integration (CI):** 
   - Azure DevOps pipelines automatically trigger on code changes.
   - Builds container images for the microservices.
   - Pushes the tagged images to Azure Container Registry (ACR).
3. **Manifest Automation (CD / GitOps):** 
   - A custom shell script (`updateK8Manifest.sh`) dynamically updates the image tags inside the Kubernetes deployment manifests (`k8s-specifications/`).
   - The changes are automatically committed and pushed back to track deployment versions.
4. **Deployment:** The application runs smoothly inside an Azure Kubernetes Service (AKS) cluster.

---

## 🚀 Tech Stack

* **Cloud Provider:** Microsoft Azure (AKS, ACR)
* **CI/CD Orchestrator:** Azure DevOps Pipelines
* **Containerization:** Docker & Dockerfiles
* **Orchestration:** Kubernetes (`kubectl`, Deployments, Services)
* **Scripting & Automation:** Bash, Git, WSL (Ubuntu Agent)

---

## 📂 Repository Structure

```text
├── k8s-specifications/         # Kubernetes deployment & service YAML files
│   ├── vote-deployment.yaml    # Deployment manifest for the voting app
│   └── ...
├── scripts/
│   └── updateK8Manifest.sh     # Automated script to update image tags in manifests
├── vote/                       # Source code for the voting microservice
│   └── Dockerfile              # Dockerfile for containerizing the app
└── azure-pipelines.yml         # Main Azure DevOps CI/CD pipeline definition
```

ArgoCD
<img width="1913" height="993" alt="Screenshot 2026-09-26 224938" src="https://github.com/user-attachments/assets/ff1e340a-3083-40ad-896f-475e6b3c6a0a" />


-----

# 🛠️ Project Command Reference Guide

Here is the complete sequence of terminal commands used during the setup, configuration, and troubleshooting of this end-to-end Azure DevOps CI/CD & Argo CD GitOps pipeline.

## 1. Connect to Azure Kubernetes Service (AKS)
```bash
# Get credentials for the AKS cluster to configure kubectl access
az aks get-credentials --name azuredevops --overwrite-existing --resource-group test-rg

# Verify node status
kubectl get nodes -o wide
```
-------------------

2. Install and Configure Argo CD
Bash
# Create the Argo CD namespace
kubectl create namespace argocd

# Install Argo CD manifests onto the cluster
kubectl apply -n argocd --server-side --force-conflicts -f [https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml](https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml)

# Check Argo CD pod status
kubectl get pods -n argocd

# Retrieve the initial auto-generated admin password for Argo CD
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d

# Expose the Argo CD server service (e.g., changing type to NodePort or LoadBalancer)
kubectl edit svc argocd-server -n argocd
kubectl get svc -n argocd

----------------------

3. Clone Sample Application Source Code
Bash
# Clone the example voting application repository
git clone [https://github.com/dockersamples/example-voting-app.git](https://github.com/dockersamples/example-voting-app.git)
cd example-voting-app/

--------------------------

4. Kubernetes Secret for Azure Container Registry (ACR)
Bash
# Create a Kubernetes secret to allow AKS to pull images from private ACR
kubectl create secret docker-registry acr-secret \
  --namespace default \
  --docker-server=jainazurecicd.azurecr.io \
  --docker-username=jainazurecicd \
  --docker-password=<your-acr-password-here>

  ------------------------

  5. WSL Agent & Script Troubleshooting
Bash
# Fix Windows line ending (CRLF to LF) conflicts for shell scripts on Linux/WSL agents
dos2unix /home/jain/myagent/_work/2/s/scripts/updateK8Manifest.sh
sed -i -e 's/\r$//' /home/jain/myagent/_work/2/s/scripts/updateK8Manifest.sh

# Check files and contents in the agent's script directory
ls /home/jain/myagent/_work/2/s/scripts

----------------------

6. Cluster Diagnostics & Pod Monitoring
Bash
# Monitor pods dynamically
kubectl get pods -w

# Delete a specific pod to force a restart/sync test
kubectl delete pod vote-<pod-hash-id>

# Inspect deployment manifests and cluster node configurations
kubectl get deploy vote -o yaml
kubectl get nodes -o yaml


