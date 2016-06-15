#!/bin/bash
adduser --disabled-password --system --shell /bin/bash tor
mkdir /home/www-data/ 
chown www-data /home/www-data
if [ "$?" -ne "0" ]; then
  exit 1;
fi
chown -R tor /var/lib/tor/
if [ "$?" -ne "0" ]; then
  exit 1;
fi

adduser --disabled-password --system --shell /bin/bash mailpile
mkdir /home/mailpile
chown mailpile /home/mailpile
if [ "$?" -ne "0" ]; then
  exit 1;
fi

touch /var/mail/mailpile
chown mailpile /var/mail/mailpile

exit 0;