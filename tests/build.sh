#!/usr/bin/env bash

rm -rf ./docker-compose.yaml
cp ./papermerge/Dockerfile ./Dockerfile
mv ./README-new.md ./README.md

docker buildx build . --output type=docker,name=elestio4test/papermerge:latest | docker load