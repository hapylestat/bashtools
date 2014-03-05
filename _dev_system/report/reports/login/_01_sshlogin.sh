#!/bin/bash
#=====Report module template
#Required params:
#$1 - action to do
#$2 - root directory, where located functions
. /etc/system.conf
. $libROOT/functions

get_name(){
  return_s "sship"
}

get_title(){
 return_s "SSH Client IP"
}


get_value(){
 include system
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
