@echo off

set XML_CALABASH_VERSION=3.0.0-alpha14
set XML_CALABASH_JAR=%~P0\lib\xmlcalabash-%XML_CALABASH_VERSION%\xmlcalabash-app-%XML_CALABASH_VERSION%.jar
set XML_CALABASH=java -jar %XML_CALABASH_JAR%

echo Invoking XML Calabash %XML_CALABASH_VERSION% for XProc 3 pipeline execution . . .
rem All arguments are passed to the script in the distribution.

call %XML_CALABASH% %*

pause
