#!/bin/sh
#REMOTE=`who --ips -m -s | awk '{print $NF}'`
REMOTE=`echo $SSH_CONNECTION | awk '{print $1}'`
PREFIX="/ssh:$HOSTNAME:"
SSH='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
FILE=""

if [ ! -z "$@" ]; then
    if [ ! -f "$@" ]; then
        FILE="$PREFIX$PWD/$@"
    else
        FILE_PATH=`realpath $@`
        FILE="$PREFIX$FILE_PATH"
    fi
fi
#echo $REMOTE
if [ "$REMOTE" != "" ]; then
    $SSH $REMOTE '~/emacs-script' $FILE > /dev/null 2> /dev/null
fi
