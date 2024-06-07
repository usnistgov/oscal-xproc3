@echo off

echo Invoking Morgana XProc III engine for XProc 3 pipeline execution . . .

rem - add -silent to suppress credit notices

rem -config-uri=%~P0\lib\morgana-config.xml - must come first
rem -schematron-connector=schxslt
rem -xslt-connector=saxon12-3
rem -indent-errors - must come after pipeline designation

rem profile must be named first or the pipeline won't find it

call %~P0..\lib\MorganaXProc-IIIse-1.3.7\Morgana.bat -config=%~P0..\lib\morgana-config.xml resolve-profile-and-save.xpl -input:source=%* -indent-errors

pause
