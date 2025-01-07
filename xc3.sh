#!/bin/bash

# This script attempts to run XML Calabash 3

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

XML_CALABASH_VERSION=3.0.0-alpha9
XML_CALABASH_JAR="${SCRIPT_DIR}/lib/xmlcalabash-${XML_CALABASH_VERSION}/xmlcalabash-app-${XML_CALABASH_VERSION}.jar"
XML_CALABASH="java -jar ${XML_CALABASH_JAR}"

# java -jar lib/xmlcalabash-3.0.0-alpha5/xmlcalabash-app-3.0.0-alpha5.jar version

# echo $XML_CALABASH

usage() {
    cat <<EOF
Usage: ${BASE_COMMAND:-$(basename "${BASH_SOURCE[0]}")} XPROC_FILE [ADDITIONAL_ARGS]

Applies XML Calabash 3 processor to the designated pipeline, using Saxon for XSLT transformations

EOF
}

[[ -z "${1-}" ]] && { echo "The script requires an XProc 3 pipeline - try helloworld.xpl or TEST-XPROC3.xpl"; usage; exit 1; }

if [ ! -f "${XML_CALABASH_JAR}" ]; then

  echo "XML Calabash not found ... try running setup-xmlcalabash.sh ..."

elif [ "${1:-}" = '-h' ] || [ "${1:-}" = '--help' ]; then usage

else

  echo Applying XML Calabash version ${XML_CALABASH_VERSION}
  ${XML_CALABASH} $@

fi
