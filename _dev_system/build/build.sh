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

EXITONERROR=1
#=============callbacks

do_build(){
    write_item "Starting build of" "$1"
    include $2/$1
}




#=============main

dirlist_callback do_build "$MYDIR/mods" "sh"