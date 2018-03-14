#!/bin/bash
 
# Simple shell-based filter. It is meant to be invoked as follows:
#       /path/to/script -f sender recipients...

# Localize these. The -G option does nothing before Postfix 2.3.
INSPECT_DIR=/tmp/
SENDMAIL="/usr/sbin/sendmail -G -i" # NEVER NEVER NEVER use "-t" here.

# Exit codes from <sysexits.h>
EX_TEMPFAIL=75
EX_UNAVAILABLE=69

# Clean up when done or when aborting.
trap "rm -f in.$$" 0 1 2 3 15

# Start processing.
cd $INSPECT_DIR || {
     echo $INSPECT_DIR does not exist; exit $EX_TEMPFAIL; }
 
cat >in.$$ || { 
    echo Cannot save mail to file; exit $EX_TEMPFAIL; }

    echo "$1 $2 $3 $4" >>/tmp/1;
    echo "$@" >>/tmp/3;
    
    i=0;
    
    
for var in "$@"
  do
 i=$((i+1));
    if [ "$i" -lt "4" ]; then
	continue;
    fi
   
    domain="$var";
    domain=$(echo $domain| sed 's/.*@//')

    #!!!!!!!!!!!!!!!!!!! Check for mysql injections: checking domain is really a domain !!!!!!!!!!!!!!
    domain=$( echo $domain | grep -P '(?=^.{5,254}$)(^(?:(?!\d+\.)[a-zA-Z0-9_\-]{1,63}\.?)+(?:[a-zA-Z]{2,})$)' )
    #
    echo "domain: $domain" >>/tmp/log_filter;
    
    isset=$(mysql --user="own-mailbox" --password="own-mailbox" --database="postfix"\
      --execute="SELECT COUNT(ID) FROM transport WHERE address = '$domain';");
    isset=$(echo $isset | awk '{print $2;}');
    echo "isset: $isset" >>/tmp/log_filter;   
    myhostname=$(cat /etc/mailname)
   
    if [ "$isset" -eq "0" ] && [ "$domain" != "$myhostname" ]; then
      #We suppose that we have ttdnsd running in order to do DNS requests through tor.
      result=$(dig +time=10 +tries=12 _tormx.$domain TXT +short );

      #Remove quotes
      result=${result#"\""}
      result=${result%"\""}
      echo $result
      echo "Result: $result" >>/tmp/log_filter;
      torhiddenservice=$(echo $result | awk '{print $1;}');
      
      #!!!!!!!!!!!!!!!!!!! Check for mysql injections: checking torhiddenservice is really a domain !!!!!!!!!!!!!!
      torhiddenservice=$( echo $torhiddenservice | grep -P '(?=^.{5,254}$)(^(?:(?!\d+\.)[a-zA-Z0-9_\-]{1,63}\.?)+(?:[a-zA-Z]{2,})$)' )
      #
      
      if [[ $torhiddenservice == *".onion" ]]; then
  
	  echo "New hidden service discovered :$torhiddenservice for $domain" >>/tmp/log_filter;
	  mysql --user="own-mailbox" --password="own-mailbox" --database="postfix"\
	  --execute="DELETE FROM transport WHERE address = '$domain';"
      
	  mysql --user="own-mailbox" --password="own-mailbox" --database="postfix"\
	  --execute="INSERT INTO transport(address, transportation) VALUES ('$domain','smtptor:[$torhiddenservice]')"
      else
	  if [[ $domain == *".omb.one" ]]; then
	      echo "Could not get .onion corresponding to .omb.one dropping email" >>/tmp/log_filter;
	      echo "Could not send your email because no tor hidden service was found for $domain"| /usr/sbin/sendmail -f $2 -- $2
	      exit;
	  fi
      fi
    else
	if [ "$domain" = "$myhostname" ]; then
	  echo "the Mail is for my own domain" >>/tmp/log_filter;
	  #Safety mesure,just to make sure no transportation was set on my domain
	  mysql --user="own-mailbox" --password="own-mailbox" --database="postfix"\
	      --execute="DELETE FROM transport WHERE address = '$domain';"
	else
	  echo "We allready have .onion for $domain" >>/tmp/log_filter;   
	fi
    fi

done    

# Specify your content filter here.
# filter <in.$$ || {
#   echo Message content rejected; exit $EX_UNAVAILABLE; }
 
$SENDMAIL "$@" <in.$$
 
exit $? 
