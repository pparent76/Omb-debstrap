 #!/bin/bash
 
 mkdir  /etc/letsencrypt/
 cp options-ssl-apache.conf /etc/letsencrypt/

 a2enmod proxy_http
 a2enmod  cgi
 a2enmod ssl
 a2dissite "*"
 rm /etc/apache2/sites-available/*
 cp apache2-conf/* /etc/apache2/sites-available/
 a2ensite default
 a2ensite proxy
 service apache2 restart
 if [ "$?" -ne "0" ]; then
  exit 1;
  fi
 echo "OK">/var/www/OK 
 if [ "$?" -ne "0" ]; then
  exit 1;
 fi
  
exit 0;
