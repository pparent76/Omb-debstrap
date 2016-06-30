#!/bin/bash

set -x

./cleanup.sh
./required_packages.sh
if [ "$?" -ne "0" ]; then
echo "Error while installing required debian packages";
echo "Please check your apt-get config";
exit 1;
fi
cd Local_postfix_conf && make install && cd ..
if [ "$?" -ne "0" ]; then
echo "Error while setting up postfix";
exit 1;
fi
./install-repositories.sh
if [ "$?" -ne "0" ]; then
echo "Error while installing Own-Mailbox git repositories.";
exit 1;
fi
./setup-apache.sh
if [ "$?" -ne "0" ]; then
echo "Error while setting up apache.";
exit 1;
fi
./make-users.sh
if [ "$?" -ne "0" ]; then
echo "Error while setting up users.";
exit 1;
fi
./setup-startup.sh
if [ "$?" -ne "0" ]; then
echo "Error while setting up startup.";
exit 1;
fi
./setup-rng-tool.sh
if [ "$?" -ne "0" ]; then
echo "Error while setting up rng-tools.";
exit 1;
fi
./setup-hostname.sh
if [ "$?" -ne "0" ]; then
echo "Error while setting up hostname.";
exit 1;
fi

pkill python2
su mailpile -c ./setup-mailpile.sh
if [ "$?" -ne "0" ]; then
echo "Error while setting up mailpile.";
exit 1;
fi

pip install -r /home/mailpile/Mailpile/requirements.txt
if [ "$?" -ne "0" ]; then
echo "Error while setting up mailpile.";
exit 1;
fi

mkdir /etc/omb/
echo "nameserver 127.0.0.1">/etc/resolv.conf
echo "nameserver 127.0.0.1">/etc/resolv.conf.head

cp torrc /etc/tor/torrc
echo "AllowInbound 1" >> /etc/tor/torsocks.conf 
if [ "$?" -ne "0" ]; then
echo "Error while setting up torsocks.";
exit 1;
fi

./setup-iptables.sh
if [ "$?" -ne "0" ]; then
echo "Error while setting up iptables.";
exit 1;
fi

if [ "$DOCKER" != "yes" ]; then
  echo "Rebooting in 5 seconds..."
  sleep 5;
  reboot
else
  exit 0;
fi
