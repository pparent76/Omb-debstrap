install:
	cp filter/* /usr/lib/postfix/
	cp postfix-cfg/* /etc/postfix/
	cp script-config/* /usr/bin/
	#Setup MASTER_DOMAIN
	$$(. ../../config.sh; echo "client.$$MASTER_DOMAIN" > /etc/mailname)
	$$(. ../../config.sh; sed -i "s/MASTER_DOMAIN/$$MASTER_DOMAIN/g" /usr/lib/postfix/filter_get_onion_associated.sh)
	$$(. ../../config.sh; sed -i "s/MASTER_DOMAIN/$$MASTER_DOMAIN/g" /etc/postfix/relay_password)
	#Reload conf
	mysql --defaults-file=/etc/mysql/debian.cnf <setup-database/setup.sql
	postmap /etc/postfix/relay_password
	service postfix restart
