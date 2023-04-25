#!/bin/bash

set -e

BASE_TAG=${BASE_TAG:-17}
TAG="harbor.ru/tools/maven"

docker build -t $TAG:${BASE_TAG} --build-arg "BASE_TAG=${BASE_TAG}" .
docker push $TAG:${BASE_TAG}
