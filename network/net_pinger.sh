#!/bin/bash

#----note: use "echo -e" is required
COLOR_BEGIN="\033["
COLOR_RED="${COLOR_BEGIN}0;31m"
COLOR_LIME="${COLOR_BEGIN}1;32m"
COLOR_BR="${COLOR_BEGIN}1;38;05;51m"
COLOR_ITEM="${COLOR_BEGIN}1;38;05;214m"
COLOR_VALUE="${COLOR_BEGIN}1;38;05;110m"
COLOR_END="\033[0m"
#===================================
HOST=8.8.8.8
TOEND=true
C=0

#########################signal handling
control_c(){
  TOEND=false
}

trap control_c SIGINT



#==============main
echo "Begin =>"

while [ $TOEND == true ]; do
  DATA=`ping $HOST -c 1 -W 2 -q -n|grep rtt|cut -d "=" -f 2`
  C=0
  if [ "$DATA" == "" ]; then
    echo -en "${COLOR_RED}d${COLOR_END}"
  else
    DATA=`echo $DATA |cut -d "/" -f 2| cut -d "." -f 1`
    
    if [ $DATA -lt 130 ] && [ $C -eq 0 ]; then
      echo -en "${COLOR_LIME}.${COLOR_END}"
      C=1
    fi
    if [ $DATA -lt 200 ] && [ $C -eq 0 ]; then
      echo -en "${COLOR_ITEM}.${COLOR_END}"
    fi
    if [ $DATA -lt 300 ] && [ $C -eq 0 ]; then
      echo -en "${COLOR_RED}.${COLOR_END}"
    fi    
  fi
  sleep 2
done