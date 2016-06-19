Own-Mailbox debian install
=========
These scripts will allow you to transphorm a machine running Debian Jessie into an Own-Mailbox.

Pre-requisit
-----
Before running these steps make sure you have a clean and fresh install of debian Jessie with no particular configuration at all (except network), that is correctly connected to your local network in dhcp.

Warning: This will transform your machine into an Own-Mailbox, do not execute this on a machine that you use for something else than hosting Own-Mailbox. Do not Install on a computer that you use as a desktop or laptop computer. Do not install on a machine that is not on your local network.

Installation instructions
----
In order to install Own-Mailbox run theses commands:

+ git clone https://github.com/pparent76/Own-Mailbox_debian_install.git
+ cd Own-Mailbox_debian_install
+ ./main.sh

Docker 
----
It is possible to do a quick test of Own-Mailbox in Docker, so that you don't need a seperate machine. You can do this on a laptop.

First install docker on your machine (https://docs.docker.com/engine/installation/linux/debian/)

+ ./docker.sh build
+ ./docker.sh create
+ ./docker.sh shell

Then you can access the web interface at the address http://localhost:8085/

Only use this for testing, not in production. It is not garanteed to have optimal security.
For exemple iptables blocking everyhting but tor and local network do not work on docker for now.
This will most probably trigger data leaks.