#!/bin/bash

# This script attempts to download XML Calabash 3.0

# NEEDED - a .bat version of this to run under Windows w/o bash

mkdir -p lib

pushd lib > /dev/null

VERSION=3.0.0-alpha9
RELEASES=https://github.com/xmlcalabash/xmlcalabash3/releases/download

# Acquiring, for example, https://github.com/xmlcalabash/xmlcalabash3/releases/download/3.0.0-alpha9/xmlcalabash-3.0.0-alpha5.zip

if [ ! -f "xmlcalabash-${VERSION}.zip" ]; then
    echo "Downloading XML Calabash 3 (may take a few seconds) ..."
    curl -s -L -o xmlcalabash-$VERSION.zip $RELEASES/$VERSION/xmlcalabash-$VERSION.zip
else
    echo "You have the XML Calabash ${VERSION} distribution (zip file) - delete it and run again for a fresh download"
fi

echo "Unzipping ${VERSION} ..."
unzip -q -o xmlcalabash-$VERSION.zip

echo "Smoke testing xmlcalabash-$VERSION:"
java -jar xmlcalabash-$VERSION/xmlcalabash-app-$VERSION.jar version

popd > /dev/null
