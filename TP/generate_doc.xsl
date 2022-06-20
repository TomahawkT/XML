<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output omit-xml-declaration="yes" method="text" indent="yes"/>

<xsl:template match ='/'>
    <xsl:choose>
        <xsl:when test=" //error">
            <xsl:value-of select="//error"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:call-template name="asciidoc_generator">
                <xsl:with-param name="artist" select="//artist"/>
            </xsl:call-template>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template name="asciidoc_generator">
    <xsl:param name="artist"/>
= <xsl:value-of select="$artist/name"/>
<xsl:if test="$artist/disambiguation !=''">
* Disambiguation: <xsl:value-of select="$artist/disambiguation"/></xsl:if>
* Type: <xsl:value-of select="$artist/type"/>
* Birth Place: <xsl:value-of select="$artist/area/origin"/>, <xsl:value-of select="$artist/area/name"/>
* Life-span: <xsl:value-of select="$artist/life-span/begin"/> - <xsl:if test="$artist/life-span/ended"><xsl:value-of select="$artist/life-span/end"/></xsl:if><xsl:if test="not($artist/life-span/ended)">present</xsl:if>

=== Recordings
<xsl:for-each select="//recording">
==== <xsl:value-of select="title"/>.<xsl:if test="length"> Length: <xsl:value-of select="length"/></xsl:if>.<xsl:if test="first-release-date"> First Release Date: <xsl:value-of select="first-release-date"/></xsl:if>
====== Releases
|===
|Title|Date|Country|Type|Track Number
<xsl:for-each select="release">
<xsl:sort order="descending" select="date"/>
|<xsl:value-of select="./title"/>|<xsl:value-of select="./date"/>|<xsl:value-of select="./country"/>|<xsl:value-of select="./type"/>|<xsl:value-of select="./track-number"/>
</xsl:for-each>
|===
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>