# End-to-End DevOps Project: Multi-Microservice Voting App on AKS (Azure Kubernetes Service)

This project demonstrates a production-grade CI/CD and GitOps pipeline automating the deployment of a containerized multi-tier voting application. It leverages **Azure DevOps** for continuous integration, **Docker** for containerization, **Azure Container Registry (ACR)** for image storage, and **Kubernetes (AKS)** for orchestration.

---

## 🏗️ Architecture & Workflow

https://github.com/dockersamples/example-voting-app/blob/main/architecture.excalidraw.png

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




