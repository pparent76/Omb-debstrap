#!/bin/bash

echo "---------------------------------------------------------------------------------------------"
echo "Do you want to install rng-tools?"
echo "This will allow to use hardware accelerated random generator, to speed up Gpg key generation."
echo "Highly recommended for Raspbery Pi (It has hardward random number generator (RNG),"
echo "						and without Key generation may hang forever) "
echo "Not recommanded if you don't have a RNG hardware (may generate weak keys)."

test="";
while [ "$test" != "y" ] && [ "$test" != "n" ];
do
echo "Install (y/n)?"
read test;
done

if [ "$test" = "y" ]; then
echo "Installing rng-tools"
apt-get install rng-tools
if [ "$?" -ne "0" ]; then
  exit 1;
fi
fi

exit 0;
