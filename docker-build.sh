#!/bin/bash
set -e

# Configuration
IMAGE="ghcr.io/kspaeth/rag_api"
VERSION="0.1.1"
BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ')

echo "Starting multi-arch build for ${IMAGE}:${VERSION}..."

docker buildx build \
  --builder multiarch_builder \
  --platform linux/amd64,linux/arm64 \
  --label "org.opencontainers.image.source=https://github.com/kspaeth/rag_api" \
  --label "org.opencontainers.image.description=RAG API for PyCharm Project" \
  --label "org.opencontainers.image.created=${BUILD_DATE}" \
  --label "version=${VERSION}" \
  -t "${IMAGE}:${VERSION}" \
  -t "${IMAGE}:latest" \
  --push \
  .

echo "Build complete and pushed to GHCR."