#!/bin/sh
set -e
[ -n "$1" ] || { echo "Error: arg expected. Please provide path to where you git cloned mod-plugin-builder"; exit 1; }
modpluginbuilderdir="$1"

cpus=$(expr $(nproc) / 2)
if [ $cpus -le 1 ]; then
    cpus=1
fi

docker run -it \
    --cpus=$cpus --memory=4g \
    -v $modpluginbuilderdir:/home/mod/build-mod \
    -w "/home/mod/build-mod" \
    mod-image \
    bash
