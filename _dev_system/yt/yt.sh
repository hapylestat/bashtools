#!/bin/bash
#========================REQ List
# App's: xmlstarlet
#========================Global variables
APPVER="0.1a"
APPNAME="YT Manager"
#=======================App vars
YT_ID=hapylestat
#=======================Include base library
. /etc/system.conf
. $libROOT/functions

include filesystem terminal
#===print banner
echo "$APPNAME $APPVER, lib $CORENAME $COREVER (c) 2013, H.L."
#=============callback functions
#include libs
# $1 - lib
# $2 - path
do_mods(){
  include "$2/$1"
}

dirlist_callback do_mods  "$MYDIR/lib" "shlib"
dirlist_callback do_mods  "$MYDIR/mods" "shmod"


printhelp(){
echo "yt.sh [playlists]"
echo "playlists - show list of user playlists"
echo "playlist [name] - list playlist"
}

    
case "$1" in
   playlists)
     getplaylists
   ;;
   playlist)
     getplaylistitems $2
   ;;
   *)
    printhelp
   ;;
esac

