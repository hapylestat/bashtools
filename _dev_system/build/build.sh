#!/bin/bash 
######################################
#            Shell script            #
# Author: H.L.                       #
# TPL Version: 0.1                   #
######################################

#========================Global variables
APPVER="0.1b"
MYDIR=`echo $0`
FILENAME=`echo $MYDIR|rev|cut -d / -f 1|rev`
MYDIR=${MYDIR%%/$FILENAME}
#=======================Include base library

. $MYDIR/functions.shinc

include  /etc/system.conf

EXITONERROR=1
#=============callbacks

do_build(){
    write_item "Starting build of" "$1"
    include $2/$1
}




#=============main

#check if any param are passed
if [ ! -z $1 ]; then
  if [ -e "$MYDIR/mods/$1.sh.disabled" ] || [ -e "$MYDIR/mods/$1.sh" ]; then
   echo "file exists"
  fi
else 
 dirlist_callback do_build "$MYDIR/mods" "sh"
fi

