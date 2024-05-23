@echo off

echo Invoking Morgana XProc III engine for XProc 3 pipeline execution . . .
rem All arguments are passed to the script in the distribution.

rem NB - may need to update path and Saxon setting to your installed versions
rem TODO: port fallback logic / --help and other features from xproc3.sh

rem - add -silent to suppress credit notices

rem -config-uri=%~P0\lib\morgana-config.xml - must come first
rem -schematron-connector=schxslt
rem -xslt-connector=saxon12-3
rem -indent-errors - must come after pipeline designation

set PROFILE_IN=%1
shift

call %~P0\..\lib\MorganaXProc-IIIse-1.3.7\Morgana.bat -config=%~P0\..\lib\morgana-config.xml resolve-profile.xpl -input:oscal-profile=%PROFILE_IN% %* -indent-errors

pause
