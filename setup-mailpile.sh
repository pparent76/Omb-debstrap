#!/bin/bash

cd /home/mailpile/
git clone https://github.com/pparent76/Omb-Mailpile.git
mv Omb-Mailpile Mailpile
# move into the newly created source repo
cd /home/mailpile/Mailpile

# Get specific revisions in order to have reproductible results
git reset --hard 0e87faf8e3d66863b5766380ca50770c366eb1ff
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
