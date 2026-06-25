#!/bin/bash

# Fix bug script for OneUI
LOCALDIR=`cd "$( dirname ${BASH_SOURCE[0]} )" && pwd`
cd $LOCALDIR
source $LOCALDIR/../language_helper.sh

WORKSPACE=$LOCALDIR/../workspace
TARGETDIR=$WORKSPACE/out
systemdir="$TARGETDIR/system/system"

echo "OneUI fixing"
# Add OneUI specific fixes here
