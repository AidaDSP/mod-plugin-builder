FROM ubuntu:18.04
LABEL maintainer="Alexandre Cunha <ale@moddevices.com>"
ENV DEBIAN_FRONTEND noninteractive

# Enable i386, armhf and arm64
RUN dpkg --add-architecture i386
RUN dpkg --add-architecture armhf
RUN dpkg --add-architecture arm64

RUN echo "deb [arch=amd64,i386] http://archive.ubuntu.com/ubuntu/ bionic main restricted universe multiverse"                > /etc/apt/sources.list && \
    echo "deb [arch=amd64,i386] http://archive.ubuntu.com/ubuntu/ bionic-updates main restricted universe multiverse"       >> /etc/apt/sources.list && \
    echo "deb [arch=amd64,i386] http://archive.ubuntu.com/ubuntu/ bionic-backports main restricted universe multiverse"     >> /etc/apt/sources.list && \
    echo "deb [arch=amd64,i386] http://security.ubuntu.com/ubuntu bionic-security main restricted universe multiverse"      >> /etc/apt/sources.list && \
    echo "deb [arch=armhf,arm64] http://ports.ubuntu.com/ubuntu-ports bionic main restricted universe multiverse"           >> /etc/apt/sources.list && \
    echo "deb [arch=armhf,arm64] http://ports.ubuntu.com/ubuntu-ports bionic-updates main restricted universe multiverse"   >> /etc/apt/sources.list && \
    echo "deb [arch=armhf,arm64] http://ports.ubuntu.com/ubuntu-ports bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list

# Update and upgrade system
RUN apt-get update && apt-get upgrade -qy && apt-get clean

# NOTE multiarch-support:armhf is installed but not multiarch-support:arm64, everything still works though

# Install packages for buildroot
RUN apt-get install -qy multiarch-support:armhf qemu-user-static && \
    apt-get install -qy libmxml1:armhf libfftw3-3:armhf liblo7:armhf libsndfile1:armhf zlib1g:armhf libstdc++6:armhf && \
    apt-get install -qy libmxml1:arm64 libfftw3-3:arm64 liblo7:arm64 libsndfile1:arm64 zlib1g:arm64 libstdc++6:arm64 && \
    apt-get install -qy locales acl bash bash-completion bc curl cvs git mercurial rsync subversion sudo wget dosfstools && \
    apt-get install -qy bison bundler bzip2 cpio flex gawk gperf gzip help2man nano perl patch python tar texinfo unzip python3-dev python3-setuptools && \
    apt-get install -qy automake binutils build-essential device-tree-compiler premake4 sunxi-tools libtool-bin ncurses-dev libc6:i386 libstdc++6:i386 zlib1g:i386 jq && \
    apt-get install -qy libfreetype6-dev libx11-dev libxcursor-dev libxinerama-dev libxrandr-dev pkg-config && \
    apt-get clean
RUN wget http://archive.ubuntu.com/ubuntu/pool/universe/p/premake/premake_3.7-1_amd64.deb && \
    dpkg -i premake_3.7-1_amd64.deb && \
    rm premake_3.7-1_amd64.deb

# Configuring a UTF8-capable locale.
RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV USER_NAME mod
ENV PROJECT mod

# Create a user with same uid and gid of the current host's user
ARG host_uid=1001
ARG host_gid=1001
RUN groupadd -g $host_gid $USER_NAME && \
    useradd -g $host_gid -m -s /bin/bash -u $host_uid $USER_NAME

ARG ssh_prv_key=""
ARG ssh_pub_key=""

# Create .ssh path and set permissions, then authorize remote server
RUN mkdir -p /home/$USER_NAME/.ssh && \
    chmod 0700 /home/$USER_NAME/.ssh && \
    ssh-keyscan github.com > /home/$USER_NAME/.ssh/known_hosts

# Add the keys and set permissions
RUN echo "$ssh_prv_key" > /home/$USER_NAME/.ssh/id_rsa && \
    echo "$ssh_pub_key" > /home/$USER_NAME/.ssh/id_rsa.pub && \
    chmod 600 /home/$USER_NAME/.ssh/id_rsa && \
    chmod 600 /home/$USER_NAME/.ssh/id_rsa.pub && \
    chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/.ssh

ARG git_config=""

# Add .gitconfig and set permissions
RUN echo "$git_config" > /home/$USER_NAME/.gitconfig && \
    chmod 664 /home/$USER_NAME/.gitconfig && \
    chown $USER_NAME:$USER_NAME /home/$USER_NAME/.gitconfig

# @TODO: check
RUN echo "source /etc/bash_completion" >> /home/$USER_NAME/.bashrc

# From this line below all commands run as user
USER $USER_NAME

RUN mkdir -p /home/$USER_NAME/build-mod
