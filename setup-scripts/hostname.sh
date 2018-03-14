#!/bin/bash

#Setup the correct hostnme

set -e

echo "own-mailbox" > /etc/hostname
echo "127.0.0.1 own-mailbox" >> /etc/hosts

exit 0
