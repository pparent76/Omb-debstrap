#!/bin/bash

cp startup-scripts/rc.local /etc/
if [ "$?" -ne "0" ]; then
  exit 1;
fi
cp startup-scripts/iptables.sh /etc/
if [ "$?" -ne "0" ]; then
  exit 1;
fi
chmod +x /etc/rc.local
if [ "$?" -ne "0" ]; then
  exit 1;
fi
chmod +x /etc/iptables.sh
if [ "$?" -ne "0" ]; then
  exit 1;
fi

exit 0;