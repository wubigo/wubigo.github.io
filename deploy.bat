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

REM build static resource to docs and config github page publish from docs
hugo -s back -d %~dp0/docs
git status
git add .
set MSG=deploy:%MSG%
git commit -a -m %MSG%
git push
git status


set LIFY=%2
REM  NETLIFY BUILD WEBHOOK TRIGGER DEPLOY
if [%LIFY%] == ["-n"] (
    echo "NETLIFY BUILD WEBHOOK TRIGGER DEPLOY"
    curl -X POST -d {} https://api.netlify.com/build_hooks/62c00259355a9e1243111768    
)



