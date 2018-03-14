install:
	cp filter/* /usr/lib/postfix/
	cp postfix-cfg/* /etc/postfix/
	cp script-config/* /usr/bin/
	echo "client.omb.one" > /etc/mailname
	mysql --defaults-file=/etc/mysql/debian.cnf <setup-database/setup.sql
	postmap /etc/postfix/relay_password
	service postfix restart
