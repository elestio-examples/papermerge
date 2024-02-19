#!/usr/bin/env bash

mv ./docker/prod/* ./
docker buildx build . --output type=docker,name=elestio4test/papermerge:latest | docker load