#!/bin/bash

# Requires: brew install tidy-html5

CACHE=0
while getopts ":c" opt; do
  case ${opt} in
    c ) CACHE=1
      ;;
    \? ) echo "Usage: cmd [-c]"
      ;;
  esac
done

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
DOWNLOAD_URL="https://www.dvdsreleasedates.com"
DOWNLOAN_FILE="dvdsreleasedates"

curl -s ${DOWNLOAD_URL} > ${DIR}/${DOWNLOAN_FILE}.html
sed -i.bak 's/addthis://g' ${DIR}/${DOWNLOAN_FILE}.html
tidy --vertical-space no -b -q -i -asxml ${DIR}/${DOWNLOAN_FILE}.html > ${DIR}/${DOWNLOAN_FILE}.tidy.html 2>/dev/null
xsltproc ${DIR}/dvdsreleasedates.xslt ${DIR}/${DOWNLOAN_FILE}.tidy.html

## Cleanup
if [ "$CACHE" -eq "0" ]; then
  rm ${DIR}/${DOWNLOAN_FILE}.html
  rm ${DIR}/${DOWNLOAN_FILE}.html.bak
  rm ${DIR}/${DOWNLOAN_FILE}.tidy.html
fi
