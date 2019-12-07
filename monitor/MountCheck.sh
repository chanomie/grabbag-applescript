#!/bin/sh
NOTIFY="/Users/$(whoami)/Documents/grabbag-applescript/notify/prowlnotify"

usage="Usage: $(basename $0) [-h][-m MOUNT_POINT]
    -h - help
    -m - MOUNT_POINT such as /Volumes/Drobo

e.g.
    $(basename $0) -d refer.client.com
"

while [ $# -gt 0 ]; do
    case "$1" in
        -h|-\?)
            echo "$usage"
            exit 0
        ;;
        -m)
            if [ -z "${2:-}" ]; then
                echo "Error: option $1 expects a parameter" 1>&2
                exit 1
            fi
            MOUNT_POINT="$2"
            shift
        ;;
        -*)
             echo "Error: unexpected option: $1" 1>&2
             exit 1
        ;;
        *)
            break
        ;;
    esac
    shift
done

if [ -z "${MOUNT_POINT:-}" ]; then
  echo "Mount Point should be set with -m"
  echo ""
  echo "$usage"
  exit 1
fi

if [ ! -d "${MOUNT_POINT}" ]; then 
  # echo "Volume not mounted at ${MOUNT_POINT}" | /usr/local/bin/growlnotify -n "Abzorbaloff" -a /Applications/Utilities/Disk\ Utility.app -t Warning
  ${NOTIFY} -a "Abzorbaloff" -e "Alert: Volume Mount Error" -d "Volume not mounted at ${MOUNT_POINT}" 
fi

