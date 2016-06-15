 #!/bin/bash
 
 cp apache2-conf/* /etc/apache2/sites-available/
 a2enmod proxy_http
 a2enmod  cgi
 a2dissite "*"
 a2ensite default
 a2ensite proxy
 service apache2 restart
 if [ "$?" -ne "0" ]; then
  exit 1;
  fi

exit 0;
