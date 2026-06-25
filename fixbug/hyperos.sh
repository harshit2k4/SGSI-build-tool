#!/bin/bash

# Fix bug script for HyperOS
LOCALDIR=`cd "$( dirname ${BASH_SOURCE[0]} )" && pwd`
cd $LOCALDIR
source $LOCALDIR/../language_helper.sh

WORKSPACE=$LOCALDIR/../workspace
TARGETDIR=$WORKSPACE/out
systemdir="$TARGETDIR/system/system"

echo "HyperOS fixing"
# Add HyperOS specific fixes here
