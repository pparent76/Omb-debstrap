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

cp startup-scripts/ttdnsd-survey.sh /etc/
cp startup-scripts/tor-survey.sh /etc/
chmod +x /etc/ttdnsd-survey.sh
chmod +x /etc/tor-survey.sh

exit 0;