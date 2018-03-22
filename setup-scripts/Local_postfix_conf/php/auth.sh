#!/bin/bash
 echo $2 | su $1 -c "echo  1" -p $2
 #Need echo for the newline
echo $?
