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
    curl -L -o "${morgana}.zip"  "${morgana_download}"
    unzip -qo "${morgana}.zip" -x __MACOSX/**
else
    echo "You have ${morgana} in directory lib"
fi


if [ ! -f ${morgana}/MorganaXProc-IIIse_lib/saxon-he-12.3.jar ]; then
    echo "Downloading Saxon 12.3 ..."
    curl -L -o SaxonHE12-3J.zip https://www.saxonica.com/download/SaxonHE12-3J.zip
    echo "Unzipping and installing Saxon HE jar into Morgana ..."
    unzip -q -o SaxonHE12-3J.zip "saxon-he-12.3.jar"
    mv -f saxon-he-12.3.jar ${morgana}/MorganaXProc-IIIse_lib
else
    echo "Saxon-HE is available with ${morgana}"
fi

echo "Morgana is available - next, try executing a pipeline with xp3.sh --"

popd > /dev/null

