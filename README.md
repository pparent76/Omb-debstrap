Own-Mailbox Debian install
=========
These scripts will allow you to transform a machine running Debian Jessie into an Own-Mailbox.

Pre-requisite
-----
Before running these steps make sure you have a clean and fresh install of debian Jessie with no particular configuration at all (except network), that is correctly connected to your local network in dhcp.

Warning: This will transform your machine into an Own-Mailbox, do not execute this on a machine that you use for something else than hosting Own-Mailbox. Do not Install on a computer that you use as a desktop or laptop computer. Do not install on a machine that is not on your local network.

Installation instructions
----
In order to install Own-Mailbox run this command:

+ ./main.sh

Docker 
----
It is possible to do a quick test of Own-Mailbox in Docker, so that you don't need a separate machine. You can do this on a laptop.

First install docker on your machine (https://docs.docker.com/engine/installation/linux/debian/)

+ ./docker.sh build
+ ./docker.sh create
+ ./docker.sh shell

Then you can access the web interface at the address http://localhost:8085/

Only use this for testing, not in production. There is no guaranty to have optimal security.
For example iptables blocking everything but tor and local network do not work on docker for now.
This will most probably trigger data leaks.