#!/usr/bin/env bash

mv ./docker/prod/* ./
sed -i "s~docker/prod/~~g" ./Dockerfile

docker buildx build . --output type=docker,name=elestio4test/papermerge:latest | docker load