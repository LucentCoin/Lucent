#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/..

DOCKER_IMAGE=${DOCKER_IMAGE:-LucentCoin/develop}
DOCKER_TAG=${DOCKER_TAG:-latest}

BUILD_DIR=${BUILD_DIR:-.}

rm docker/bin/*
mkdir docker/bin
cp $BUILD_DIR/src/lucentd docker/bin/
cp $BUILD_DIR/src/lucent-cli docker/bin/
cp $BUILD_DIR/src/lucent-tx docker/bin/
strip docker/bin/lucentd
strip docker/bin/lucent-cli
strip docker/bin/lucent-tx

docker build --pull -t $DOCKER_IMAGE:$DOCKER_TAG -f docker/Dockerfile docker
