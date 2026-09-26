#!/bin/bash

set -x

# Set the repository URL
REPO_URL="https://1JgLPYbM0ZdsQWEMU1QY7nMEzapwXEsJIhVmH3rlwqgI78r9jYHJJQQJ99CIACAAAAACgka9AAASAZDO1AxJ@dev.azure.com/LearnwithJain/Voting%20app/_git/Voting%20app"

# Clone the git repository into the /tmp directory
git clone "$REPO_URL" /tmp/temp_repo

# Navigate into the cloned repository directory
cd /tmp/temp_repo

# Configure git identity for the temporary clone
git config user.email "pipeline@azuredevops.com"
git config user.name "Azure Pipeline Agent"

# Make changes to the Kubernetes manifest file(s)
sed -i "s|image:.*|image: jainazurecicd.azurecr.io/$2:$3|g" k8s-specifications/$1-deployment.yaml

# Add the modified files
git add k8s-specifications/$1-deployment.yaml

# Commit the changes
git commit -m "Update Kubernetes manifest for $1 to tag $3"

# Push the changes back to the repository
git push origin HEAD:main

# Cleanup: remove the temporary directory
rm -rf /tmp/temp_repo