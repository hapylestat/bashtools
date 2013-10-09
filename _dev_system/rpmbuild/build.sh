#!/bin/bash
#========================Global variables
APPVER="0.1b"
MYDIR=`echo $0`
FILENAME=`echo $MYDIR|rev|cut -d / -f 1|rev`
MYDIR=${MYDIR%%/$FILENAME}
#=======================Include base library

. /etc/system.conf
. $srvDIR/_dev_system/functions

EXITONERROR=1
BUILDUSER=makerpm
BUILDDIR=rpmbuild
BUILDHOST=sangou
#
#==================function
#
function prepare_build(){
 #clean build dir
 run "rm -rf /home/$BUILDUSER/$BUILDDIR" "Clear build dir"
 run "rm -f /home/$BUILDUSER/RPM-GPG-KEY-*" "Clear GPG Key"

 #make new repository
 run "rpmdev-setuptree" "Make new repo" "$BUILDUSER"
}


#==make spec file
# $1 - out spec file
# $2 - path to #spec folder
function make_spec(){
  SECTIONS="description prep build install clean files doc pre post preun postun changelog"
  OUT=$1
  rm -f $OUT

  cat $2/header >> $OUT
  for a in $SECTIONS; do
   echo >>$OUT
   echo "%$a" >>$OUT
  
   cat $2/$a >> $OUT
   echo >>$OUT
  done
  return 0
}
#
#==================callbacks
#

function do_buildpkg(){
   prepare_build
   #connect info about nginx package
   echo "Include source..."
   include "$2/$1"
   if [ $ENABLED -eq 1 ]; then
     run "wget $URL -O /home/$BUILDUSER/$BUILDDIR/SOURCES/$NAME.tar.gz" "Download source"
     
     run "make_spec $2/spec/$SPEC $2/#spec" "Build spec file"
     run "cp $2/spec/$SPEC /home/$BUILDUSER/$BUILDDIR/SPECS/" "Copy project configuration"

     run "cp -r $2/#source /home/$BUILDUSER/$BUILDDIR/SOURCES/" "Copy additional source"

     run "chown -R $BUILDUSER:$BUILDUSER /home/$BUILDUSER/$BUILDDIR" "Apply propertly permissions"
     run "rpmbuild -ba /home/$BUILDUSER/$BUILDDIR/SPECS/$SPEC" "Start project building" "$BUILDUSER"
     run "cp -rf /home/$BUILDUSER/$BUILDDIR/RPMS/* $MYDIR/#out/" "Copy binary package"
   else
     echo -e "${COLOR_RED}Aborting, module are not enabled for compiling${COLOR_END}"
   fi

}

function do_listpkgs(){
 write_header $1
 dirlist_callback do_buildpkg "$2/$1" "rpm.sh"
}


#==========================




#looking for packages
dirlist_callback do_listpkgs "$MYDIR/specs"

echo "No tasks left, exiting..."











