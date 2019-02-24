#!/usr/bin/env bash

set -x

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -m|----message)
    MESSAGE="$2"
    shift # past argument
    shift # past value
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [ -z "$MESSAGE" ]; then
    
    echo "commit MESSAGE can't be empty"
    exit
fi
git status
git add .
git commit -a -m "$MESSAGE"
git push
# gen static resource
hugo -s back
git status
git commit -a -m "deploy:$MESSAGE"
git push
git status
