#!/bin/bash

USERID=$(id -u)
IMAGE_NAME=${USER}/wine
BUILD_DIR=/tmp/docker-build

mkdir -p $BUILD_DIR
cp -f Dockerfile $BUILD_DIR

# setting the right user id
sed -i -e "s/_UID_/$USERID/g" $BUILD_DIR/Dockerfile

# building the image and clean up
docker build -t $IMAGE_NAME $BUILD_DIR
rm -rf $BUILD_DIR
