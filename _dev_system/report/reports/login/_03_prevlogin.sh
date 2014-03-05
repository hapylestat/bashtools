#!/bin/bash
#=====Report module template
#Required params:
#$1 - action to do
#$2 - root directory, where located functions

. /etc/system.conf
. $libROOT/functions

get_name(){
  return_s "prevlogin"
}

get_title(){
 return_s "Previous login"
}


get_value(){
 include system
 return_s "$(get_current_lastlog)"
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
