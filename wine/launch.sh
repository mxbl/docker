#!/bin/bash

IMAGE_NAME=${USER}/wine
CONTAINER_NAME=wine

( \
    echo 'Trying to run a new data container.' && \
    docker run -it \
        -e DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
        -v ${HOME}/.Xauthority:/home/wine/.Xauthority \
        -v /run/user/$(id -u)/pulse/native:/run/user/$(id -u)/pulse/native \
        -v ${HOME}/docker-shared:/home/wine/shared \
        --device /dev/snd \
        --device /dev/dri \
        --group-add audio \
        --group-add video \
        --net=host \
        --name "$CONTAINER_NAME" \
        $IMAGE_NAME \
    2>/dev/null \
) || ( \
    echo 'The container already exists, relaunching the old one.' && \
    docker start -ai "$CONTAINER_NAME" \
)

