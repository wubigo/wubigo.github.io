#!/usr/bin/env bash

set -x 
NAME="$1"

if [ -z "$NAME" ]; then
    echo "POST NAME can't be empty"
    exit
fi

# replace multiple spaces with dash
# NAME=$(echo $NAME | sed -n 's/ \+/-/gp')   //doesn't work when name has dash
NAME=${NAME// /_}

if [ -z "$NAME" ]; then
    echo "sed NAME is empty"
    exit
fi

STATUS=$(hugo new post/$NAME/index.md)
ls -l $STATUS
