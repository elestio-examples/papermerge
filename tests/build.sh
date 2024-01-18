#!/usr/bin/env bash

cp -rf ./papermerge/* ./
rm docker-compose.yaml
mv docker-compose-new.yml docker-compose.yml
docker buildx build . --output type=docker,name=elestio4test/papermerge:latest | docker load