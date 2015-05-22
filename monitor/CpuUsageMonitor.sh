#!/bin/sh

cpu=`top -o cpu -l 2 | grep kernel_task | tail -1 | cut -c 23-27`

if awk "BEGIN {exit !($cpu >= 100)}"
then 
  echo "`hostname` is burning CPU: ${cpu} %" | /usr/local/bin/growlnotify -n "Abzorbaloff" -a /Applications/Utilities/Disk\ Utility.app -t Warning
fi
