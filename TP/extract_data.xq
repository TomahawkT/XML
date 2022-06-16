declare variable $artist_id external;
declare variable $a:= doc("artist_info.xml")//artist; 
declare variable $r:= doc("recordings_info.xml");

declare function local:valid_id ($artist_id) as xs:boolean
{
exists(for $var in doc("artists_list.xml")//artists_list/artist
    where $var/@arid eq $artist_id return $artist_id)
};


if(not(local:valid_id($artist_id)))
then(
    <artist_data>
        <error>ni el id pones bien sorete, si tan solo tu viejo se hubiera puesto bien el forro </error>
    </artist_data>
)
else(
    <artist_data xsi:noNamespaceSchemaLocation="artist_data.xsd">
        <artist>
            <name>{$a/name/string()}</name>
            <disambiguation>{$a/disambiguation/string()} </disambiguation>
            <type>{$a/@type/string()}</type>
            <area>
                <name>{$a/area/name/string()}</name>
                <origin>{$a/begin-area/name/string()}</origin>
            </area>
            <life-span> 
                <begin>{$a/life-span/begin/string()}</begin>
                <end>{$a/life-span/end/string()}</end>
                <ended>{$a/life-span/ended/string()}</ended>
            </life-span>
            <recordings>
                {for $recording in $r//recording
                return
                <recording>
                    <title>{$recording/title/string()}</title>
                    <length>{$recording/length/string()} </length>
                    if (exists($recording/first-release-date))
                    then (
                        <first-release-date>{$recording/first-release-date/string()}</first-release-date>
                        )
                    {for $release in $recording/release-list/release
                        return
                        <release>
                            <title>{$release/title/string()} </title>
                            <date> {$release/date/string()} </date>
                            if (exists($release/country))
                            then(<country>{$release/country/string()}</country>)
                            <type> {$release/release-group/primary-type/string()} </type> 
                            if(exists($release/release-group/secondary-type-list/secondary-type))
                            then(<subtype>{$release/release-group/secondary-type-list/secondary-type/string()} </subtype>)
                            <!-- {for $st in $release/release-group/secondary-type-list/secondary-type
                            return <subtype>{$st/string()} </subtype>}-->
                            <track-number>{$release/medium-list/medium/track-list/track/number/string()} (:MINOCCURS=0:) </track-number>
                        </release>}
                </recording>}
            </recordings>
        </artist>

    </artist_data>
)



