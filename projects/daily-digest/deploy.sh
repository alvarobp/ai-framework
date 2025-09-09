#!/bin/bash

set -e

# Configuration
REGISTRY="registry.gitlab.com"
PROJECT="alvarobp/ai-framework"
IMAGE_NAME="daily-digest"
FULL_IMAGE_NAME="${REGISTRY}/${PROJECT}/${IMAGE_NAME}"

# Get git commit SHA for tagging
GIT_SHA=$(git rev-parse HEAD)
SHORT_SHA=$(git rev-parse --short HEAD)

echo "Building Docker image for daily-digest..."
echo "Git SHA: $GIT_SHA"
echo "Short SHA: $SHORT_SHA"

# Build the Docker image
echo "Building Docker image..."
docker build -t "${FULL_IMAGE_NAME}:${SHORT_SHA}" -t "${FULL_IMAGE_NAME}:latest" .

echo "Docker image built successfully!"

# Login to GitLab Container Registry
echo "Logging in to GitLab Container Registry..."
if [ -z "$CI_REGISTRY_PASSWORD" ]; then
    echo "Please login to GitLab Container Registry manually or set CI_REGISTRY_PASSWORD environment variable"
    docker login $REGISTRY
else
    echo "$CI_REGISTRY_PASSWORD" | docker login $REGISTRY -u "$CI_REGISTRY_USER" --password-stdin
fi

# Push both tags
echo "Pushing both tags: ${FULL_IMAGE_NAME}:${SHORT_SHA} and ${FULL_IMAGE_NAME}:latest"
docker push "${FULL_IMAGE_NAME}" --all-tags

echo "Deployment complete!"
echo "Image available at:"
echo "  - ${FULL_IMAGE_NAME}:${SHORT_SHA}"
echo "  - ${FULL_IMAGE_NAME}:latest"