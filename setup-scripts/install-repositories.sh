#!/bin/bash

set -e

cd /root/
rm -rf ihm/
git clone --branch alpha https://github.com/Own-Mailbox/ihm
cd ihm/
make

cd /root/
rm -rf cs-com/
git clone --branch alpha https://github.com/Own-Mailbox/cs-com
cd cs-com/client/
make && make install

cd /root/
rm -rf ttdnsd/
git clone --branch alpha https://github.com/Own-Mailbox/ttdnsd
cd ttdnsd/
make install

exit 0
