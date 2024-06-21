#!/usr/bin/env bash

cp ./papermerge/Dockerfile ./Dockerfile
mv ./README-new.md ./README.md

docker buildx build . --output type=docker,name=elestio4test/papermerge:latest | docker load