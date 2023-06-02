#!/usr/bin/env bash

Xephyr :1 -ac -br -screen 1024x768 -resizeable -reset -terminate &
docker run -e DISPLAY=:1 -v /tmp/.X11-unix:/tmp/.X11-unix --rm -it --name new-computer --mount type=bind,source="$(pwd)",target=/home/zi/sys-arch new-computer bash

#docker run --rm -it --name new-computer --mount type=bind,source="$(pwd)",target=/home/zi/sys-arch new-computer bash
