#!/bin/bash

set -e

BASE_TAG=${BASE_TAG:-lts}-slim
TAG="harbor.ru/tools/node"

docker build -t $TAG:${BASE_TAG} --build-arg "BASE_TAG=${BASE_TAG}" .
docker push $TAG:${BASE_TAG}