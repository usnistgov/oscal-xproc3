#!/bin/bash

# This script attempts to run MorganaXProcIII


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
MORGANA="${SCRIPT_DIR}/lib/MorganaXProc-IIIse-1.3.7/Morgana.sh"

usage() {
    cat <<EOF
Usage: ${BASE_COMMAND:-$(basename "${BASH_SOURCE[0]}")} XPROC_FILE [ADDITIONAL_ARGS]

Applies Morgana XProc III processor to an OSCAL profile resolver pipeline, using Saxon for XSLT transformations

EOF
}

[[ -z "${1-}" ]] && { echo "The script requires an OSCAL profile as input"; usage; exit 1; }

[[ -z "${1-}" ]] && { echo "Error: please name an OSCAL profile to be resoved"; usage; exit 1; }
PROFILE_IN=$1

ADDITIONAL_ARGS=$(shift 1; echo ${*// /\\ })


if [ ! -f "${MORGANA}" ]; then

  echo "Morgana not found at ${MORGANA} ... try running acquire-morgana.sh ..."

elif [ "${1:-}" = '-h' ] || [ "${1:-}" = '--help' ]; then usage

else

  ${MORGANA} -config=lib/morgana-config.xml -input:oscal-profile=${PROFILE_IN} $@ -indent-errors

fi
