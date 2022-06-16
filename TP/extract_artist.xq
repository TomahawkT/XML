declare variable $artist_id external;

for $a in doc("artists_list.xml")//artists_list/artist
    where $a/@arid eq $artist_id return $a/@arid/string()
