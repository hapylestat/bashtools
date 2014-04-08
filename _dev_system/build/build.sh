#!/bin/bash 
######################################
#            Shell script            #
# Author: H.L.                       #
# TPL Version: 0.1                   #
######################################

#========================Global variables
APPVER="0.1b"
#=======================Include base library

. /etc/system.conf
. $libROOT/functions

MODDIR="mods"

include terminal,filesystem,system
include lib.system.args

EXITONERROR=1

if [ ! -z ${ARGS["noservice"]} ]; then
  include lib.disableservice
fi

do_list(){
 include $MODDIR.$1
 write_item "$1" "$APPNAME $APPVER"
}

go_list(){
 dirlist_callback do_list "$MYDIR/$MODDIR" "."
}

go_build(){
 include $MODDIR.${ARGS["app"]}
 if [ ! -z ${ARGS["ver"]} ]; then
  APPVER=${ARGS["ver"]}
 fi
 write_info "Building $APPNAME $APPVER..."
 mod_main
}

go_help(){
 echo "$FILENAME - list|build [--app=<name>] [--ver=<new version>] [-noservice]"
 echo "list - list available modules"
 echo "build - build selected module"
 echo "--app - module to build"
 echo "--ver - build this version instead of default"
 echo "-noservice - skip installation of service"
}


case "${ARGS["default"]}" in
 list)
     go_list
     ;;
 help)
     go_help
     ;;
 build)
     if [ -z ${ARGS["app"]} ]; then
       write_error "Please specify app param"
       go_help
       exit 1
     fi
     go_build
     ;;
 *)
     go_help
     ;;
esac

