#!/usr/bin/env bash

set -x 
NAME="$1"

if [ -z "$NAME" ]; then
    echo "POST NAME can't be empty"
    exit
fi

# replace multiple spaces with dash
NAME=$(echo $NAME | sed -n 's/ \+/-/gp')
echo $NAME 

STATUS=$(hugo new post/$NAME/index.md)
ls -l $STATUS
