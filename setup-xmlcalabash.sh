#!/bin/bash

# This script attempts to download XML Calabash 3.0

# NEEDED - a .bat version of this to run under Windows w/o bash

mkdir -p lib


pushd lib > /dev/null

VERSION=3.0.0-alpha9
RELEASES=https://github.com/xmlcalabash/xmlcalabash3/releases/download


if [ ! -f "xmlcalabash-${VERSION}.zip" ]; then
    echo "Downloading XML Calabash 3 (may take a few seconds) ..."
    curl -s -L -o xmlcalabash-$VERSION.zip $RELEASES/$VERSION/xmlcalabash-$VERSION.zip

    # unzip -qo "${morgana}.zip" -x __MACOSX/**
    # chmod +x "${morgana}/Morgana.sh"
else
    echo "You have XML Calabash ${VERSION} in directory lib"
fi

unzip -q xmlcalabash-$VERSION.zip

echo "Smoke test:"
java -jar xmlcalabash-$VERSION/xmlcalabash-app-$VERSION.jar version

popd > /dev/null

