#!/bin/bash
#=====Report module template
#Required params:
#$1 - action to do
#$2 - root directory, where located functions

. /etc/system.conf
. $srvDIR/_dev_system/functions

get_name(){
  return_s "date"
}

get_title(){
 return_s "date"
}


get_value(){
 return_s "`date`"
}

case "$1" in
  name)
   get_name
  ;;
  value)
   get_value
  ;;
  title)
   get_title
  ;;
  *)
  ;;
esac
