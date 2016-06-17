#!/bin/bash


while true; do
  dig own-mailbox.com
  res=$?
  
  #retry to be sure
  if [ "$res" -ne "0" ]; then
  dig own-mailbox.com
  res=$?
  fi
  
  #retry to be sure
  if [ "$res" -ne "0" ]; then
  dig own-mailbox.com
  res=$?
  fi
  
  #if we can't resolve own-mailbox.com restart ttdnsd and reconfigure resolv.conf
  if [ "$res" -ne "0" ]; then
  killall ttdnsd
  echo "nameserver 127.0.0.1">/etc/resolv.conf;
  ttdnsd -l
  fi

  sleep 60;

done