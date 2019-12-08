#!/bin/bash
MOUNT_POINT="/Volumes/DRIVE"
SITE="https://www.example.com"
today=$(date +"%Y-%m-%d")

usage="Usage: $(basename $0) [-h][-m MOUNT_POINT][-s siteurl]
    -h - help
    -m - MOUNT_POINT such as /Volumes/Drobo
    -s - site url e.g. https://www.example.com

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
        -s)
            if [ -z "${2:-}" ]; then
                echo "Error: option $1 expects a parameter" 1>&2
                exit 1
            fi
            SITE="$2"
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
if [ -z "${SITE:-}" ]; then
  echo "Sitepoint should be set with -s"
  echo ""
  echo "$usage"
  exit 1
fi


read -d '' RSS_START << EOF
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title>ChaosServer New Videos</title>
    <link>${SITE}/tv_shows</link>
    <atom:link href='${SITE}/dvdsreleasedates/new-cs-video-files.rss' rel="self" type="application/rss+xml" />
    <description>Recently Downloaded Videos</description>
    <language>en-us</language>
    <generator>ChaosServer RSS</generator>
    <item>
      <title>Videos for Yesterday: ${today}</title>
      <guid>${SITE}/?name=tv_shows&amp;date=${today}</guid>
      <link>${SITE}/?name=tv_shows&amp;date=${today}</link>
      <description>
        &lt;h1&gt;Videos for Yesterday: ${today}&lt;/h1&gt;
EOF

read -d '' RSS_END << EOF
      </description>
    </item>
  </channel>
</rss>
EOF

echo "$RSS_START"
echo "        &lt;ul&gt;"
if [ -d "${MOUNT_POINT}" ]; then 
  for directory in "TV_Shows Movies"; do
    for newVideoFile in `find ${MOUNT_POINT}/${directory} -mtime -1 -name "*.m4v" 2>/dev/null`; do
      filename=$(echo "${newVideoFile}" | sed -e "s/^.*\/\([^\/]*\)$/\1/g")
      echo "          &lt;li&gt;${filename}&lt;/li&gt;"
    done
  done
fi
echo "        &lt;/ul&gt;"
echo "$RSS_END"
