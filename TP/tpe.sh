#!/bin/bash
artist_id=${1#*=};

curl -o artist_info.xml https://musicbrainz.org/ws/2/artist/${artist_id}?inc=works
curl -o recordings_info.xml https://musicbrainz.org/ws/2/recording?query=arid:${artist_id}&limit=100
sleep 3
echo "artist_info.xml created."
echo "recordings_info.xml created."

java net.sf.saxon.Transform -s:artist_info.xml -xsl:namespace_remover.xsl -o:artist_info.xml
java net.sf.saxon.Transform -s:recordings_info.xml -xsl:namespace_remover.xsl -o:recordings_info.xml
java net.sf.saxon.Query extract_data.xq artist_id=$artist_id > "artist_data.xml"
echo "artist_data.xml created."
java net.sf.saxon.Transform -s:artist_data.xml -xsl:generate_doc.xsl -o:artist_page.adoc
echo "artist_page.adoc created. Check in directory"
echo "If artist_page.adoc is empty, please check error in artist_data.xml"