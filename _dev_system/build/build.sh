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
SCRIPTFILE=null
#=============callbacks

do_build(){
    write_item "Starting build of" "$1"
    include $2/$1
}




#=============main

#check if any param are passed
if [ ! -z $1 ]; then
  if [ -e "$MYDIR/mods/$1.sh.disabled" ]; then
     SCRIPTFILE="$MYDIR/mods/$1.sh.disabled"
  fi
  if [ -e "$MYDIR/mods/$1.sh" ]; then
     SCRIPTFILE="$MYDIR/mods/$1.sh"
  fi
  #-----------------pass inside script arguments
  ARG1=$2
  ARG2=$3
  write_item "Starting build of" "$1"
  include $SCRIPTFILE
  #--------------------------------------------
else 
 dirlist_callback do_build "$MYDIR/mods" "sh"
fi

