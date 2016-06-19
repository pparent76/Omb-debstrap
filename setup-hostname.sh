#!/bin/bash

echo "own-mailbox">/etc/hostname
if [ "$?" -ne "0" ]; then
  exit 1;
fi
echo "127.0.0.1 own-mailbox">>/etc/hosts
exit 0;
