#!/bin/bash

postconf -e "myhostname = $1";
echo "/$1/          ACCEPT">>/etc/postfix/mydestinations;
echo "$1"> /etc/mailname
service postfix restart;
