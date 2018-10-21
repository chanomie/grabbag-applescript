#!/bin/bash

# Requires: brew install tidy-html5

DOWNLOAD_URL="https://www.dvdsreleasedates.com"
DOWNLOAN_FILE="dvdsreleasedates"

curl -s ${DOWNLOAD_URL} > ${DOWNLOAN_FILE}.html
sed -i.bak 's/addthis://g' ${DOWNLOAN_FILE}.html
tidy --vertical-space no -b -q -i -asxml ${DOWNLOAN_FILE}.html > ${DOWNLOAN_FILE}.tidy.html 2>/dev/null
xsltproc dvdsreleasedates.xslt ${DOWNLOAN_FILE}.tidy.html

## Cleanup
rm ${DOWNLOAN_FILE}.html
rm ${DOWNLOAN_FILE}.html.bak
rm ${DOWNLOAN_FILE}.tidy.html