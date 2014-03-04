#!/bin/bash
#========================Global variables
APPVER="0.1b"
MYDIR=`echo $0`
FILENAME=`echo $MYDIR|rev|cut -d / -f 1|rev`
MYDIR=${MYDIR%%/$FILENAME}
#=======================Include base library

. /etc/system.conf
. $libROOT/functions



#==================callback's
#Callback handler for modules items
#$1 mod name
#$2 mod path
do_moditem(){
   mtitle=$(get_mod_property "$2/$1" "title")
   mval=$(get_mod_property "$2/$1" "value")
   write_item "$mtitle" "$mval"
}

#Callback handler for modules list
#$1 mod name
#$2 mod path
do_mod(){
    write_header $1
    dirlist_callback do_moditem "$2/$1" "sh"
}

#=======helpers

# return module property
# $1 - full path to module
# $2 - property name
# - notem variable MYDIR should be defined
get_mod_property(){
 return_s "`$1 "$2" "$MYDIR"`"
}



#=======================MAIN==================================
#-print header
clear
write_center "${COLOR_LIME}`cat /etc/issue`${COLOR_END}"

#-list folders
dirlist_callback do_mod "$MYDIR/reports"

#-print bottom line
echo -e "${COLOR_BR}--gen. by report.sh $APPVER/$CORENAME $COREVER--${COLOR_END}"
