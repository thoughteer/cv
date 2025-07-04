#!/bin/sh

docker run --rm -v $(pwd):/cv thoughteer/cv:latest "$@"
