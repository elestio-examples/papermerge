#!/usr/bin/env bash

mv ./docker/prod/* ./
sed -i "s~docker/prod/~~g" ./Dockerfile
mv ./README-new.md ./README.md

docker buildx build . --output type=docker,name=elestio4test/papermerge:latest | docker load