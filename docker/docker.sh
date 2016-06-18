#!/bin/bash

# go to the directory of the script
cd $(dirname $0)

IMAGE=ownmailbox-image
CONTAINER=ownmailbox

docker() {
    sudo docker "$@"
}

cmd_help() {
    cat <<-_EOF
Usage: $0 ( build | create | test | start | stop | shell | erase )

First build the image and create the containter:
    $0 build [debian-jessie]
    $0 create

Then enter the shell of the container and install:
    $0 shell
    git clone https://github.com/pparent76/Own-Mailbox_debian_install.git
    cd Own-Mailbox_debian_install
    ./main.sh

When testing is done, clean up the container and the image:
    $0 erase

_EOF
}

cmd_build() {
    local dockerfile=${1:-"debian-jessie"}
    docker build --tag=$IMAGE --file="$dockerfile" .
}

cmd_create() {
    cmd_stop
    docker rm $CONTAINER 2>/dev/null
    docker create --name=$CONTAINER \
        $IMAGE /sbin/init
        #--privileged=true \
}

cmd_exec() {
    docker exec -it $CONTAINER env TERM=xterm \
        script /dev/null -c "$@" -q
}

cmd_shell() {
    cmd_start
    cmd_exec bash
}

cmd_start() {
    docker start $CONTAINER
    #cmd_exec "/etc/init.d/haveged start"
}

cmd_stop() {
    docker stop $CONTAINER 2>/dev/null
}

cmd_erase() {
    cmd_stop
    docker rm $CONTAINER 2>/dev/null
    docker rmi $IMAGE 2>/dev/null
}

# run the given command
cmd=${1:-help} ; shift
case $cmd in
    help|build|create|start|stop|shell|clear) cmd_$cmd "$@" ;;
    *) docker "$@" ;;
esac
