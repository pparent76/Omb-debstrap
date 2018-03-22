#!/bin/bash

set -x

msg_if_failed() {
if [ "$?" -ne "0" ]; then
  echo $1
  exit 1
fi
}

./cleanup.sh

./setup-scripts/required-packages.sh
msg_if_failed "Error while installing required debian packages.\n Please check your apt-get config."

./setup-scripts/apache.sh
msg_if_failed "Error while setting up apache."

cd ./setup-scripts/Local_postfix_conf && make install && cd ../..
msg_if_failed "Error while setting up postfix."

./setup-scripts/install-repositories.sh
msg_if_failed "Error while installing Own-Mailbox git repositories."

./setup-scripts/make-users.sh
msg_if_failed "Error while setting up users."

./setup-scripts/startup.sh
msg_if_failed "Error while setting up startup."

./setup-scripts/rng-tool.sh
msg_if_failed  "Error while setting up rng-tools."

./setup-scripts/hostname.sh
msg_if_failed  "Error while setting up hostname."

pkill python2
su mailpile -c ./setup-scripts/mailpile.sh
msg_if_failed  "Error while setting up mailpile."

pip install -r /home/mailpile/Mailpile/requirements.txt
msg_if_failed  "Error while setting up mailpile."


mkdir /etc/omb/
chown www-data /etc/omb/
echo "nameserver 127.0.0.1" > /etc/resolv.conf.head

cp files/torrc /etc/tor/torrc
touch /var/log/tor.log
chown tor /var/log/tor.log

echo "AllowInbound 1" >> /etc/tor/torsocks.conf
msg_if_failed  "Error while setting up torsocks."

./setup-scripts/iptables.sh
msg_if_failed  "Error while setting up iptables."

# Temporarily use google dns server and flush iptables
# to make sure the upgrade will be overwritten at first startup
echo "nameserver 8.8.8.8" > /etc/resolv.conf
iptables -F
ip6tables -F
apt-get upgrade -y

# Make sure to fetch time every hour in the crontab
(crontab -l 2>/dev/null; echo "00 * * * * service ntp stop; ntpdate -s ntp.univ-lyon1.fr; service ntp start") | crontab -

# Make sure to sync every minute
(crontab -l 2>/dev/null; echo "* * * * * sync") | crontab -

echo "Installation done, please reboot."

exit 0
