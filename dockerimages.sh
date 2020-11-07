#!/bin/bash -e

tag="kubernautslabs"

if [ "$1" != "" ]; then
    tag=$1
fi

echo "build image on base tag name: $tag"

docker build --tag="$tag/jmeter-base:latest" -f Dockerfile-base .
docker build --tag="$tag/jmeter-master:latest" -f Dockerfile-master .
docker build --tag="$tag/jmeter-slave:latest" -f Dockerfile-slave .
docker build --tag="$tag/jmeter-reporter" -f Dockerfile-reporter .
