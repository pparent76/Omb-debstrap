#!/bin/bash

#################################################
#	Setup hardware random number generator
################################################

echo "---------------------------------------------------------------------------------------------"
echo "Do you want to install rng-tools?"
echo "This will allow to use hardware accelerated random generator, to speed up GPG key generation."
echo "Highly recommended for Raspbery Pi (It has hardward random number generator (RNG),"
echo "						and without Key generation may hang forever)"
echo "Not recommended if you don't have RNG hardware (may generate weak keys)."

test=""

if [ "$DEBIAN_FRONTEND" = "noninteractive" ]; then
  test="y"
fi

while [ "$test" != "y" ] && [ "$test" != "n" ]; do
  echo "Install (y/n)?"
  read test
done

if [ "$test" = "y" ]; then
  echo "Installing rng-tools"
  apt-get -y install rng-tools || exit 1
fi

exit 0
