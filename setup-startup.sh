#!/bin/bash

set -e

cp startup-scripts/ttdnsd-survey.sh /etc/
cp startup-scripts/tor-survey.sh /etc/
cp startup-scripts/iptables.sh /etc/
cp startup-scripts/rc.local /etc/
chmod +x /etc/ttdnsd-survey.sh
chmod +x /etc/tor-survey.sh
chmod +x /etc/iptables.sh
chmod +x /etc/rc.local

exit 0
