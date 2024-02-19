#!/usr/bin/env bash

sed -i "s~docker/prod/~~g" ./Dockerfile

mv ./docker/prod/* ./
docker buildx build . --output type=docker,name=elestio4test/papermerge:latest | docker load