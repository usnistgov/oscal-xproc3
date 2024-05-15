#!/bin/bash

# This script attempts to download MorganaXProcIII

# NEEDED - a .bat version of this to run under Windows w/o bash

# TBD - An XProc 1.0 pipeline to do the same thing
# (So we don't need a .bat if we have XML Calabash)

mkdir -p lib

pushd lib > /dev/null

morgana=MorganaXProc-IIIse-1.3.7

morgana_download="https://sourceforge.net/projects/morganaxproc-iiise/files/${morgana}/${morgana}.zip/download"

if [ ! -f "${morgana}.zip" ]; then
    echo "Downloading Morgana XProc III SE ..."
    curl -L -o "${morgana}.zip" "${morgana_download}"
    unzip -qo "${morgana}.zip" -x __MACOSX/**
    chmod +x "${morgana}/Morgana.sh"
else
    echo "You have ${morgana} in directory lib"
fi

echo "Morgana is available - next, try executing a bare pipeline such as smoketest/POWER-UP.xpl ..."
echo "Having run this .sh script you can probably figure out that ./xp3.sh smoketest/POWER-UP.xpl is the syntax to do that"
echo "Then run the pipeline lib/GRAB-SAXON.xpl to download, unzip and install the Saxon-HE processor, enabling XSLT and XQuery in your XProc pipelines"
echo "viz: ./xp3.sh lib/GRAB-SAXON.xpl"

popd > /dev/null

