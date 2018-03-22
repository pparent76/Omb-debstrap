#!/bin/bash

# go to the directory of the script
cd $(dirname $0)

IMAGE=ownmailbox-image
CONTAINER=ownmailbox

cmd_help() {
    cat <<-_EOF
Usage: $0 ( build | create | install | start | stop | shell | erase )

Build the image, create the container, and install own-mailbox:
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
    mkdir debstrap
    cp -r ../main.sh ../files ../cleanup.sh  ../config.sh ../startup-scripts ../setup-scripts debstrap/
    local dockerfile=${1:-"debian-jessie"}

    datestamp=$(date +%F | tr -d -)
    nohup_out=nohup-$datestamp.out
    rm -f $nohup_out
    nohup nice docker build --tag=$IMAGE --file="$dockerfile" . > $nohup_out &
    sleep 1
    tail -f $nohup_out
}

cmd_create() {
    cmd_stop
    docker rm $CONTAINER 2>/dev/null
    docker create --name=$CONTAINER \
        -v "$(pwd)":/own-mailbox \
        -w /own-mailbox/ \
        -p 8085:80 -p 4443:443 \
        $IMAGE ./docker-files/init.sh
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
