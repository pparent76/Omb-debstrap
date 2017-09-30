#!/bin/bash

while true; do

  # sleep 300 but restart tor if the process is down
  for i in $(seq 1 30); do
    ps -ae | grep -v tor-survey | grep tor
    if [ "$?" -ne "0" ]; then
        su tor -c tor&
    fi
    sleep 10
  done
  #### end sleep 400 #########################


  # Try to connect to our own tor hidden service
  host=$(cat /var/lib/tor/omb_hidden_service/hostname 2>/dev/null)

  if [ ${#host} -le 15 ]; then
    # Try to connect to the proxy server
    host=proxy.omb.one
  fi

  torsocks wget --tries=10 --timeout=45 http://$host/OK -O /tmp/wget-ok > /tmp/wget-tor-survey-res 2>&1
  ok=$(cat /tmp/wget-ok)

  # If we could not connect properly to the service, restart tor
  if [ "$ok" != "OK" ]; then
    killall tor
    su tor -c tor&
  fi
  

done
