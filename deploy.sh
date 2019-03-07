#!/usr/bin/env bash

# set -x

# don't use positional parameter
: '
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
'

MESSAGE="$@"
if [ -z "$MESSAGE" ]; then
    
    echo "commit MESSAGE can't be empty"
    exit
fi
git status
git add .
git commit -a -m "$MESSAGE"
git push
# build static resource
hugo -s back
git status
git add .
git commit -a -m "deploy:$MESSAGE"
git push
git status
