#!/bin/bash
MOUNT_POINT="/Volumes/DRIVE"
SITE="https://www.example.com"
today=$(date +"%Y-%m-%d")

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
