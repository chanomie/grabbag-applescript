#!/bin/sh

trash=`du -d 0 -k ~/.Trash/ | awk '{print "scale=0; "$1"*1024/1000000000"}' | bc`
freespace=`df / | tail -n 1 | awk '{print "scale=0; "$4"*512/1000000000"}' | bc`
trashperc=`echo "scale=0; 100*$trash/$freespace"|bc`

if [ $freespace -lt 20 ]; then message="Free disk space is running low"
elif [ $trashperc -gt 100 ]; then message="Trash is more than half of the free disk space"
elif [ $trash -gt 50 ]; then message="Trash is getting big"
else exit
fi

if	[ $trash	-gt 0 ]; then hastrash="$trash GB in trash ($trashperc%)"
fi

echo "$message $freespace GB free $hastrash" | /usr/local/bin/growlnotify -n "Abzorbaloff" -a /Applications/Utilities/Disk\ Utility.app -t Warning
