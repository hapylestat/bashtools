#!/bin/bash
#=====Report module template
#Required params:
#$1 - action to do
#$2 - root directory, where located functions

if [ ! -z $2 ]; then
. $2/functions.shinc
fi

get_name(){
  return_s "prevlogin"
}

get_title(){
 return_s "Previous login"
}


get_value(){
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
