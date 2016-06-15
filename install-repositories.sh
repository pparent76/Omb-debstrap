#!/bin/bash

cd /root/
git clone https://github.com/pparent76/Own-Mailbox_first-time-setup-ihm
cd Own-Mailbox_first-time-setup-ihm && make
if [ "$?" -ne "0" ]; then
exit 1;
fi
cd /root/
git clone https://github.com/pparent76/Own-Mailbox_Client-Server_Commnucation
cd Own-Mailbox_Client-Server_Commnucation/client && make && make install
if [ "$?" -ne "0" ]; then
exit 1;
fi
cd /root/
git clone https://github.com/pparent76/Own-Mailbox_local_postfix_conf.git
cd Own-Mailbox_local_postfix_conf && make install
if [ "$?" -ne "0" ]; then
exit 1;
fi
cd /root/
git clone https://github.com/pparent76/ttdnsd.git
cd ttdnsd && make install
if [ "$?" -ne "0" ]; then
exit 1;
fi

exit 0;