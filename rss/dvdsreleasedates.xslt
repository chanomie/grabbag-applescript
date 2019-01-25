<?xml version="1.0"?><!--hellohtm.xsl-->
<!--XSLT 1.0 - http://www.CraneSoftwrights.com/training -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml"
      version="1.0" >

  <xsl:strip-space elements="xhtml:title" />
  <xsl:strip-space elements="xhtml:xhtml:td" />
  <xsl:variable name="siteurl" select="'https://www.dvdsreleasedates.com'" />
  <xsl:variable name="feedurl" select="'https://home.chaosserver.net/dvdsreleasedates/dvdsreleasedates.rss'" />
  <xsl:template match="xhtml:html">
    <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
      <channel>
        <xsl:variable name="title" select="normalize-space(xhtml:head/xhtml:title)"/>
        <title><xsl:value-of select="$title"/></title>
        <link><xsl:value-of select="$siteurl"/></link>
        <atom:link href='https://home.chaosserver.net/dvdsreleasedates/dvdsreleasedates.rss' rel="self" type="application/rss+xml" />
        <description>
          <xsl:value-of select="xhtml:head/xhtml:meta[@name='description']/@content"/>            
        </description>
        <language>en-us</language>
        <generator>ChaosServer RSS</generator>
        <xsl:for-each select="//xhtml:table[@class='fieldtable-inner']">
          <xsl:variable name="distance" select=".//xhtml:div[@class='distance']/text()" />
          <xsl:if test="contains($distance, 'this week')">
            <item>
              <title><xsl:for-each select="xhtml:tr[1]/xhtml:td/text()"><xsl:value-of select="normalize-space(translate(., '&#xA;', ''))" /></xsl:for-each></title>
              <guid>https://home.chaosserver.net/dvdsreleasedates/<xsl:for-each select="xhtml:tr[1]/xhtml:td/text()"><xsl:value-of select="translate(translate(., '&#xA;', ''), ' ', '')" /></xsl:for-each></guid>
              <link><xsl:value-of select="$siteurl"/></link>
              <description>
                <!-- xhtml:html//xhtml/table[@class='fieldtable-inner'] -->
                <xsl:for-each select="xhtml:tr/xhtml:td[@class='dvdcell']">
                  <xsl:text>&lt;p&gt;</xsl:text>
                  <xsl:for-each select=".//xhtml:img[@class='movieimg']">
                    <xsl:text>&lt;img src=&quot;</xsl:text>
	                <xsl:value-of select="./@src" />
                    <xsl:text>&quot; /&gt; &lt;br /&gt;</xsl:text>
                  </xsl:for-each>
                  
                  <xsl:for-each select="xhtml:a">
                    <xsl:if test="text() != ''">
                      <xsl:value-of select="normalize-space(translate(text(), '&#xA;', ''))" />
                    </xsl:if>
                  </xsl:for-each>
                  <xsl:for-each select=".//xhtml:td[@class='imdblink left']/xhtml:a">
                    <xsl:text> (imdb: </xsl:text><xsl:value-of select="text()" /><xsl:text>)</xsl:text>
                  </xsl:for-each>
                  <!-- TODO: Get the IMDB rating from xhtml:td[@class='imdblink']/xhtml:a/text() -->
                  <xsl:text>&lt;/p&gt;</xsl:text>
                </xsl:for-each>
              </description>
            </item>
          </xsl:if>
        </xsl:for-each>
      </channel>
    </rss>
  </xsl:template>
</xsl:stylesheet>
