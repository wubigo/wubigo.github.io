echo off

set NAME=%1

echo %NAME%

IF [%NAME%] == [] (
    echo "Post name can be empty"
    GOTO:EOF
)

set NAME=%NAME: =-%
set NAME=%NAME:"=%
echo %NAME%


FOR /F "tokens=* USEBACKQ" %%F IN (`hugo new post/%NAME%/index.md`) DO (
SET DIR=%%F
)

dir %DIR
