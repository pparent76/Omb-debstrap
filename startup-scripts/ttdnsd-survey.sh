#!/bin/bash

while true; do

  # Try 3 times to resolve own-mailbox.com
  dig own-mailbox.com +tries=3

  # If we can't resolve own-mailbox.com restart ttdnsd and reconfigure resolv.conf
  if [ "$?" -ne "0" ]; then
    killall ttdnsd
    echo "nameserver 127.0.0.1" > /etc/resolv.conf
    ttdnsd -l
  fi

  sleep 60

done
