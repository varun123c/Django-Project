#!/bin/bash

# Variables
DOCKER_IMAGE="jacksneel/socialmedia"
DOCKER_TAG="latest"
CONTAINER_NAME="con1"
HOST_PORT="8000"
CONTAINER_PORT="8000"

echo "🚀 Starting Docker deployment..."

# Stop and remove container if exists
echo "🔍 Checking for existing container..."
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "🛑 Removing existing container..."
    docker rm -f $CONTAINER_NAME
else
    echo "✅ No existing container found."
fi

# Remove all Docker images (CAUTION)
echo "⚠️ Removing all Docker images..."
docker rmi -f $(docker images -qa) 2>/dev/null || echo "No images to remove"

# Pull latest image
echo "⬇️ Pulling Docker image..."
docker pull $DOCKER_IMAGE:$DOCKER_TAG

# Run new container
echo "▶️ Running new container..."
docker run -d \
  --name $CONTAINER_NAME \
  -p $HOST_PORT:$CONTAINER_PORT \
  $DOCKER_IMAGE:$DOCKER_TAG

# Verify
echo "📦 Running containers:"
docker ps -a

echo "✅ Deployment completed successfully!"
