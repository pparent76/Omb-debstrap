#!/bin/bash

cd /home/mailpile/
git clone https://github.com/pparent76/Omb-Mailpile.git
mv Omb-Mailpile Mailpile
# move into the newly created source repo
cd /home/mailpile/Mailpile

# Get specific revisions in order to have reproductible results
git reset --hard f1d2c0f80c68b9c3a27cd1d4c986232a90a1a5d8
if [ "$?" -ne "0" ]; then
exit 1;
fi

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
