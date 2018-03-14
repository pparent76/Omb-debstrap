#!/bin/bash

#############################################
#	Create necessary users
#############################################

set -e

mkdir -p /home/www-data/
chown www-data /home/www-data

adduser --disabled-password --system --shell /bin/bash tor
chown -R tor /var/lib/tor/

adduser --disabled-password --system --shell /bin/bash mailpile
mkdir -p /home/mailpile
chown mailpile /home/mailpile

touch /var/mail/mailpile
chown mailpile /var/mail/mailpile

exit 0
