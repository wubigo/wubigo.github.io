REM echo off

set MSG=%1

echo MSG=%MSG%

IF [%MSG%] == [] (
    echo "Post MSG can be empty"
    GOTO:EOF
)

git status
git add .
git commit -a  -s -m %MSG%
git push

REM build static resource
hugo -s back
git status
git add .
set MSG=deploy:%MSG%
git commit -a -m %MSG%
git push
git status


REM  NETLIFY BUILD WEBHOOK TRIGGER DEPLOY
curl -X POST -d {} https://api.netlify.com/build_hooks/62c00259355a9e1243111768


