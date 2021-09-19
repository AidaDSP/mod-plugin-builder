#!/bin/sh

docker build --no-cache --progress=plain \
    --build-arg "host_uid=$(id -u)" \
    --build-arg "host_gid=$(id -g)" \
    --build-arg ssh_prv_key="$(cat ~/.ssh/id_rsa)" --build-arg ssh_pub_key="$(cat ~/.ssh/id_rsa.pub)" \
    --build-arg git_config="$(cat ~/.gitconfig)" \
    --tag "mod-image:latest" .
