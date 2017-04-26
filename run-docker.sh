#! /bin/bash

source ./version
docker run -i --rm=true \
    --privileged=true \
    -e "START_SCRIPT=http://resources.prod.factual.com/services/hadoop/cdh5/scripts/devbox.sh" \
    -p 22:42088 \
    -t $IMAGE:$VERSION \
    /bin/bash
