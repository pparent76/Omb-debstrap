#!/bin/sh

# Accept incoming connections from local network
iptables -A INPUT -s 127.0.0.0/8    -j ACCEPT
iptables -A INPUT -s 192.168.0.0/16 -j ACCEPT
iptables -A INPUT -s 10.0.0.0/8     -j ACCEPT
iptables -A INPUT -s 172.16.0.0/12  -j ACCEPT

# Allow established or related connections
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT 

# Drop everyhting else
iptables -A INPUT -j DROP

# Drop DNS outgoing connections
iptables -A OUTPUT -d 192.168.0.0/16 -p udp --destination-port 53 -j DROP
iptables -A OUTPUT -d 10.0.0.0/8     -p udp --destination-port 53 -j DROP
iptables -A OUTPUT -d 172.16.0.0/12  -p udp --destination-port 53 -j DROP

# Accept tor output connections
iptables -A OUTPUT -m owner --uid-owner tor -j ACCEPT

# Accept local network outgoing connections
iptables -A OUTPUT -d 127.0.0.0/8    -j ACCEPT
iptables -A OUTPUT -d 192.168.0.0/16 -j ACCEPT
iptables -A OUTPUT -d 10.0.0.0/8     -j ACCEPT
iptables -A OUTPUT -d 172.16.0.0/12  -j ACCEPT

# Drop all other outgoing connections
iptables -A OUTPUT -j DROP

################################################################
#			IPV6
################################################################

#Drop all outgoing connection except for ::1
ip6tables -A OUTPUT -d ::1 -j ACCEPT
ip6tables -A OUTPUT -j DROP

# Allow connections incoming for ::1
ip6tables -A INPUT -s ::1 -d ::1 -j ACCEPT

# Allow established or related connections
ip6tables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT 

# Drop everyhting else
ip6tables -A INPUT -j DROP

