#!/bin/bash
#=====Report module template
#Required params:
#$1 - action to do
#$2 - root directory, where located functions

if [ ! -z $2 ]; then
. $2/functions.shinc
. $2/reports/report_ssh_ip.sh
fi


get_name(){
  return_s "sship"
}

get_title(){
 return_s "SSH Client IP"
}


get_value(){
 return_s "$(get_ssh_ip)"
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
