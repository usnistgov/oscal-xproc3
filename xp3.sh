#!/bin/bash

# This script attempts to run MorganaXProcIII

# TODO: harden so this can be run from anywhere
# TODO: test in a GUI for drag-and-drop support on simple XProcs (no args)

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
MORGANA="${SCRIPT_DIR}/lib/MorganaXProc-IIIse-1.4/Morgana.sh"

usage() {
    cat <<EOF
Usage: ${BASE_COMMAND:-$(basename "${BASH_SOURCE[0]}")} XPROC_FILE [ADDITIONAL_ARGS]

Applies Morgana XProc III processor to the designated pipeline, using Saxon for XSLT transformations

EOF
}

[[ -z "${1-}" ]] && { echo "The script requires an XProc 3 pipeline - try XPROC3-SMOKETEST.xpl"; usage; exit 1; }

if [ ! -f "${MORGANA}" ]; then

  echo "Morgana not found at ${MORGANA} ... try running acquire-morgana.sh ..."

elif [ "${1:-}" = '-h' ] || [ "${1:-}" = '--help' ]; then usage

else

  ${MORGANA} -config="${SCRIPT_DIR}/lib/morgana-config.xml" $@ -indent-errors

fi
