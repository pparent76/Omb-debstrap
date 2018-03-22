#!/bin/bash

################################################
#	Setup mailpile webmail
################################################
set -e

cd /home/mailpile/
rm -rf Mailpile/
git clone --branch alpha https://github.com/Own-Mailbox/Mailpile
# Move into the newly created source repo
cd /home/mailpile/Mailpile

# Create a virtual environment directory
virtualenv -p /usr/bin/python2.7 --system-site-packages mp-virtualenv

# Activate the virtual Python environment
source mp-virtualenv/bin/activate

exit 0
