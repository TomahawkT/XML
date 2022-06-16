#!/bin/bash
artist_id=${1#*=};

java net.sf.saxon.Query extract_artist.xq artist_id=$artist_id

curl -o artist_info.xml https://musicbrainz.org/ws/2/artist/${artist_id}?inc=works
echo "artist_info.xml created."

curl -o recordings_info.xml https://musicbrainz.org/ws/2/recording?query=arid:${artist_id}&limit=1000
echo "recordings_info.xml created."