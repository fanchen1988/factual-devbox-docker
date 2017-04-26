#! /bin/bash

source ./version
docker build --rm=true \
    -t $IMAGE:$VERSION .
