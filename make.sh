#!/bin/sh

docker run --rm -v $(pwd):/cv:z thoughteer/cv "$@"
