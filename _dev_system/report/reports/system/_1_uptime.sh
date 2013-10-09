#!/bin/bash
#=====Report module template
#Required params:
#$1 - action to do
#$2 - root directory, where located functions

. /etc/system.conf
. $srvDIR/_dev_system/functions

get_name(){
  return_s "uptime"
}

get_title(){
 return_s "uptime"
}


get_value(){
 tmp=$(str_item "`uptime`" "," 1)
 return_s "`echo $tmp |cut -d ' ' -f 3,4`"
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
