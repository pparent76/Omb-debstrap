#!/bin/bash

sleep 100

while true; do

  # Try to connect to our own tor hidden service
  host=$(cat /var/lib/tor/omb_hidden_service/hostname 2>/dev/null)

  #if we allready have a tor hostname
  if [ ${#host} -gt 14 ]; then
    torsocks wget --tries=10 --timeout=45 http://$host/OK -O /tmp/wget-ok > /tmp/wget-tor-survey-res 2>&1
    ok=$(cat /tmp/wget-ok)

    # If we could not connect properly to the service, restart tor
    if [ "$ok" != "OK" ]; then
        killall tor
        su tor -c tor&
    fi

    sleep 400
  else
    sleep 10
  fi
  
done
