#!/usr/bin/env bash
# run the container
sudo xhost +si:localuser:root

sudo docker run --runtime nvidia -it --rm --security-opt  seccomp=unconfined --network host -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix/:/tmp/.X11-unix \
    -v /tmp/argus_socket:/tmp/argus_socket \
    -v /etc/enctune.conf:/etc/enctune.conf \
    --device /dev/video0 \
    --device /dev/video1 \
    -v $PWD/notebooks:/jetson-inference/notebooks \
    -v $PWD/images:/jetson-inference/images \
    ai-applications
