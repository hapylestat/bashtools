#!/bin/bash

ENABLED=1
VER=1.5.1
ARCH=x64
NAME=nginx-$VER
URL=http://nginx.org/download/$NAME.tar.gz
SPEC=$BUILDHOST-$NAME-$ARCH.spec