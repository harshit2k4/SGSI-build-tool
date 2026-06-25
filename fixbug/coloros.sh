#!/bin/bash

# Fix bug script for ColorOS
LOCALDIR=`cd "$( dirname ${BASH_SOURCE[0]} )" && pwd`
cd $LOCALDIR
source $LOCALDIR/../language_helper.sh

WORKSPACE=$LOCALDIR/../workspace
TARGETDIR=$WORKSPACE/out
systemdir="$TARGETDIR/system/system"

echo "ColorOS fixing"
# Add ColorOS specific fixes here
