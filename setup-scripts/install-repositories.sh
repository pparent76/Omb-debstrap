#!/bin/bash

################################################
#	Install omb sub repositories
# (ihm, cs-com and ttdns)
################################################
set -e

cp config.sh /root/
cd /root/
rm -rf ihm/
git clone https://github.com/Own-Mailbox/ihm
cp config.sh ihm/omb-config.sh
cd ihm/
make

cd /root/
rm -rf cs-com/
git clone https://github.com/Own-Mailbox/cs-com
cd cs-com/client/
make && make install

cd /root/
rm -rf ttdnsd/
git clone https://github.com/Own-Mailbox/ttdnsd
cd ttdnsd/
make install

exit 0
