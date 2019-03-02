#!/usr/bin/env bash

set -x 
NAME="$1"

if [ -z "$NAME" ]; then
    echo "POST NAME can't be empty"
    exit
fi

# replace multiple spaces with dash
# doesn't work when name has dash
N=$(echo $NAME | sed -n 's/ \+/-/gp') 

if [ -z "$N" ]; then
 NAME=${NAME// /-}
 if [ -z "$NAME" ]; then
    echo "sed NAME is empty"
    exit
 fi
else
 NAME=$N
fi

STATUS=$(hugo new post/$NAME/index.md)
ls -l $STATUS
