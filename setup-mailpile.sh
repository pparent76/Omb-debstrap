#!/bin/bash

set -e

cd /home/mailpile/
git clone https://github.com/Own-Mailbox/Mailpile.git
mv Omb-Mailpile Mailpile
# Move into the newly created source repo
cd /home/mailpile/Mailpile
# Get specific revisions in order to have reproductible results
git reset --hard 0ee9f218ebfbb395c4489c3680f4d00d5a541efe

# Create a virtual environment directory
virtualenv -p /usr/bin/python2.7 --system-site-packages mp-virtualenv

# Activate the virtual Python environment
source mp-virtualenv/bin/activate

exit 0
