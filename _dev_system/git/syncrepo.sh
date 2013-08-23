#!/bin/bash

#args: 
# <script> [repopath] [syncdir] [branch]

#====global variables
REPOPATH=$1
SYNCDIR=$2
BRANCH=$3
#====internal constants
HASHFILE=.lastgit_hash_$BRANCH
MAGICWORD=[publish]

cd $REPOPATH
GITMSG=`git log -b $BRANCH -n 1 --pretty=format:'%s'`
GITHASH=`git log -b $BRANCH -n 1 --pretty=format:'%H'`
if [[ "$GITMSG" == *"$MAGICWORD"* ]]; then
	
	 if [ -f $SYNCDIR/$BRANCH/$HASHFILE ]; then
	  LASTHASH=`cat $SYNCDIR/$HASHFILE`
	 else 
	  LASTHASH=0
	 fi

	 if [ "$LASTHASH" != "$GITHASH" ]; then
	  echo $GITHASH>$SYNCDIR/$HASHFILE
	  if [ -d $SYNCDIR/$BRANCH ] && [ "$SYNCDIR/$BRANCH" != "/" ]; then
           rm -rf $SYNCDIR/$BRANCH
          fi
	  cd $SYNCDIR
	  git clone -b $BRANCH file://localhost$REPOPATH $BRANCH 1>/dev/null 2>&1
	 fi
 fi

