#!/bin/bash

APPNAME=zabbix
APPVER=2.1.3


if [ ! -f $srvDOWNDIR/$APPNAME-$APPVER.tar.gz ]; then
 run "wget \"http://heanet.dl.sourceforge.net/project/$APPNAME/ZABBIX Latest Development/$APPVER/$APPNAME-$APPVER.tar.gz\" -O $srvDOWNDIR/$APPNAME-$APPVER.tar.gz" "Download source"
else
 echo "Source downloading skipped as allready downloaded"
fi

switch_dir $srvDOWNDIR
run "tar -xf $srvDOWNDIR/$APPNAME-$APPVER.tar.gz" "Prepare source"
switch_dir

#run "rm -rf $srvDIR/$APPNAME && rm -rf $srvBINDIR/$APPNAME-$APPVER" "Cleanup...."
#run "mkdir $srvBINDIR/$APPNAME-$APPVER && ln -s $srvBINDIR/$APPNAME-$APPVER $srvDIR/$APPNAME" "Make links"


#switch_dir $srvDOWNDIR/$APPNAME-$APPVER

#run "./configure --prefix=/usr/local --enable-network --enable-ipv6 --with-default-audio=pulse --with-cpu=x86-64" "Make configuration"


#run "make" "Compile project"
#run "make install" "Install project"
#switch_dir



