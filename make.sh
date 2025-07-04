#!/bin/sh

docker run --rm -u $(id -u):$(id -g) -v $(pwd):/cv thoughteer/cv:latest "$@"
