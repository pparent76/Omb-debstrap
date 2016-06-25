#!/bin/bash

cd /root/
git clone https://github.com/pparent76/Omb-ihm.git
cd Omb-ihm
# Get specific revisions in order to have reproductible results
git reset --hard cbd144730f45e364553d4cc1591f8145917d2006
if [ "$?" -ne "0" ]; then
exit 1;
fi
make
if [ "$?" -ne "0" ]; then
exit 1;
fi
cd /root/
git clone https://github.com/pparent76/Omb-cs-com.git
cd Omb-cs-com/client/ 
# Get specific revisions in order to have reproductible results
git reset --hard 664e581912222c9715bc2c9fc9219138527f5d0e
if [ "$?" -ne "0" ]; then
exit 1;
fi
make && make install
if [ "$?" -ne "0" ]; then
exit 1;
fi
cd /root/
git clone https://github.com/pparent76/ttdnsd.git
cd ttdnsd
# Get specific revisions in order to have reproductible results
git reset --hard b9be844df3b6e061a37f00f431c65c0416091730
if [ "$?" -ne "0" ]; then
exit 1;
fi
make install
if [ "$?" -ne "0" ]; then
exit 1;
fi

exit 0;