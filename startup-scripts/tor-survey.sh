#!/bin/bash


while true; do


  hidden_service=$(cat /var/lib/tor/omb_hidden_service/hostname 2>/dev/null)
  
  if [ ${#hidden_service} -gt 15 ]; then
    #Try to connect to our Own tor hidden service    
    torsocks wget  --tries=10  --timeout=45 http://$hidden_service/OK -O /tmp/wget-ok >/tmp/wget-tor-survey-res 2>&1
    ok=$(cat /tmp/wget-ok)
  else
    #Try to connect to the proxy server
    torsocks wget  --tries=10  --timeout=45 http://proxy.omb.one/OK -O /tmp/wget-ok >/tmp/wget-tor-survey-res 2>&1
    ok=$(cat /tmp/wget-ok)
  fi
  
  #if we could not connect properly to the service, restart tor.
  if [ "$ok" != "OK" ]; then
      killall tor;
      su tor -c tor&
  fi
  
   sleep 400;
    

done