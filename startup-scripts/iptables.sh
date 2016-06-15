#!/bin/sh

# Accecpt incomming connections form local network
iptables -A INPUT   -s 192.168.0.0/16 -j ACCEPT
iptables -A INPUT   -s 10.0.0.0/8  -j ACCEPT
iptables -A INPUT  -s 127.0.0.0/8 -j ACCEPT
iptables -A INPUT  -s 172.16.0.0/12 -j ACCEPT

#For other than local network block all ports that we have openned.
iptables -A INPUT -p tcp  --destination-port 80  -j DROP
iptables -A INPUT -p tcp  --destination-port 443  -j DROP
iptables -A INPUT -p tcp  --destination-port 25  -j DROP
iptables -A INPUT -p tcp  --destination-port 22  -j DROP
iptables -A INPUT -p tcp  --destination-port 111  -j DROP
iptables -A INPUT -p tcp  --destination-port 993  -j DROP
iptables -A INPUT -p tcp  --destination-port 143  -j DROP
  


# forbid DNS outgoing connections
iptables -A OUTPUT   -d 192.168.0.0/16 -p udp  --destination-port 53 -j DROP
iptables -A OUTPUT   -d 10.0.0.0/8  -p udp  --destination-port 53 -j DROP
iptables -A  OUTPUT  -d 172.16.0.0/12 -p udp  --destination-port 53 -j DROP

#Accept tor output connections
iptables -A OUTPUT -m owner --uid-owner tor -j ACCEPT

#Accept local network outgoing connections
iptables -A OUTPUT   -d 192.168.0.0/16 -j ACCEPT
iptables -A OUTPUT   -d 10.0.0.0/8  -j ACCEPT
iptables -A OUTPUT  -d 127.0.0.0/8 -j ACCEPT
iptables -A  OUTPUT  -d 172.16.0.0/12 -j ACCEPT

#Drop all other outgoing connections
iptables -A OUTPUT -j DROP

ip6tables -A OUTPUT  -d ::1 -j ACCEPT
ip6tables -A OUTPUT -j DROP

ip6tables -A INPUT -s ::1 -d ::1 -j ACCEPT
ip6tables -A INPUT -p tcp  --destination-port 80  -j DROP
ip6tables -A INPUT -p tcp  --destination-port 443  -j DROP
ip6tables -A INPUT -p tcp  --destination-port 25  -j DROP
ip6tables -A INPUT -p tcp  --destination-port 22  -j DROP
ip6tables -A INPUT -p tcp  --destination-port 111  -j DROP
ip6tables -A INPUT -p tcp  --destination-port 993  -j DROP
ip6tables -A INPUT -p tcp  --destination-port 143  -j DROP

