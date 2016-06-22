#!/bin/bash

cd /home/mailpile/
git clone https://github.com/pparent76/Omb-Mailpile.git
mv Omb-Mailpile Mailpile
# move into the newly created source repo
cd /home/mailpile/Mailpile

# create a virtual environment directory
virtualenv -p /usr/bin/python2.7 --system-site-packages mp-virtualenv
if [ "$?" -ne "0" ]; then
  exit 1;
fi

# activate the virtual Python environment
source mp-virtualenv/bin/activate
if [ "$?" -ne "0" ]; then
  exit 1;
fi


exit 0;
