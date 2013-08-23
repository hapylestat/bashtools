#!/bin/sh

#
#extract ip from SSH_CLIENT Variable if exists
#return result via $(get_ssh_ip)
#
function get_ssh_ip(){
 ip="terminal login"
 if [ ! -z "$SSH_CLIENT" ]; then
  ip=$SSH_CLIENT
  ip=${ip%% *}
  
 fi
 echo $ip
}
