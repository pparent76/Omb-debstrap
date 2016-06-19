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
Usage: $0 ( build | create | install | start | stop | shell | erase )

Build the image, create the containter, and install own-mailbox:
    $0 build [debian-jessie]
    $0 create
    $0 install

Enter the shell of the container:
    $0 shell

When testing is done, clean up the container and the image:
    $0 erase

Otherwise, stop and start it as needed:
    $0 stop
    $0 start

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
        -v "$(dirname $(pwd))":/own-mailbox \
        -w /own-mailbox/ \
        $IMAGE /sbin/init
        #--privileged=true \
}

cmd_install() {
    cmd_start
    cmd_exec ./main.sh
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
    help|build|create|install|start|stop|shell|clear) cmd_$cmd "$@" ;;
    *) docker "$@" ;;
esac
