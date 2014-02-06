#!/bin/env python

#Description: net_pinger
#Author: h.l.

#=======================> Imports
import signal;
import time;
import sys, os, subprocess;
#=======================>Globals
HOST="8.8.8.8"

#=======================> Class
class tcolor:
    begin = '\033[';
    end = begin + '0m';
    green = begin + '92m';
    lime = begin + '38;05;46m';
    red = begin + '38;05;196m';
    cyan = begin + '38;05;51m';
    rose = begin + '38;05;181m';
    yellow = begin + '38;05;226m';
    blue = begin + '38;05;110m';

#=======================> Functions
def signal_handler(signal,frame):
    print('Was pressed Ctrl+C, exiting..');
    sys.exit(0);
    
def tprint(*args):
    for line in args:
	sys.stdout.write(str(line));
    sys.stdout.flush();
    
def ping(host):
    out=subprocess.Popen(["ping",host,"-c 1","-W 2","-qn"],stdout=subprocess.PIPE).communicate()[0];
    pos=out.find('rtt');
    if pos != -1:
	out=out[pos:];
	out=out[out.find('=')+2:out.find('ms')-1].split("/")[0];
	return int(float(out));
    else:
	return -1;
	
#   print out;


def main():
    print "Begin with host {0} =>".format(HOST)
    while True:
	t=ping(HOST);
	if t < 50:
	    tprint(tcolor.lime,".",tcolor.end);
	elif t < 130:
	    tprint(tcolor.yellow,".",tcolor.end);
	elif t < 250:
	    tprint(tcolor.red,".",tcolor.end);
	elif t == -1:
	    tprint(tcolor.red,"d",tcolor.end);
	    
	time.sleep(2);


#---------->sysinit
def init():
    #set SIGINT trap
    signal.signal(signal.SIGINT, signal_handler);

#=====================> Main

if __name__ == "__main__":
    init();
    main();