#!/bin/bash

set -e

modprobe ip_tables
cp ../startup-scripts/iptables.sh /etc/
iptables -F
ip6tables -F
/etc/iptables.sh
iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6

exit 0
