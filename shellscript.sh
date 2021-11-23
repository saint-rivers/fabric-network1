#!/bin/bash

SCRIPT_NAME=$1
SCRIPT_FILE="$PWD"/scripts/"${SCRIPT_NAME}"

touch "${SCRIPT_FILE}"
echo "#!/bin/bash" > "${SCRIPT_FILE}"
chmod 755 "${SCRIPT_FILE}"
