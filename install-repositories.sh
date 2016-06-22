#!/bin/bash

cd /root/
git clone https://github.com/pparent76/Omb-ihm.git
cd Omb-ihm && make
if [ "$?" -ne "0" ]; then
exit 1;
fi
cd /root/
git clone https://github.com/pparent76/Omb-cs-com.git
cd Omb-cs-com/client/ && make && make install
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