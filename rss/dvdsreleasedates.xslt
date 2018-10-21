<?xml version="1.0"?><!--hellohtm.xsl-->
<!--XSLT 1.0 - http://www.CraneSoftwrights.com/training -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml"
      version="1.0" >

  <xsl:variable name="siteurl" select="'https://www.dvdsreleasedates.com'" />
  <xsl:template match="xhtml:html">
    <rss version="2.0">
      <channel>
        <title>
          <xsl:value-of select="xhtml:head/xhtml:title"/>
        </title>
        <link><xsl:value-of select="$siteurl"/></link>
        <description>
          <xsl:value-of select="xhtml:head/xhtml:meta[@name='description']/@content"/>            
        </description>
        <language>en-us</language>
        <generator>ChaosServer RSS</generator>
        <xsl:for-each select="//xhtml:table[@class='fieldtable-inner']">
          <xsl:variable name="distance" select=".//xhtml:div[@class='distance']/text()" />
          <xsl:if test="contains($distance, 'this week')">
            <item>
              <title>
                <xsl:for-each select="xhtml:tr[1]/xhtml:td/text()">
                  <xsl:value-of select='.' />
                </xsl:for-each>
              </title>
              <link><xsl:value-of select="$siteurl"/></link>
              <description>
                <xsl:for-each select="xhtml:tr/xhtml:td/xhtml:a">
                  <xsl:if test="text() != ''">
                    <xsl:text>&lt;p&gt;</xsl:text>
                    <xsl:value-of select='text()' />
                    <xsl:text>&lt;/p&gt;</xsl:text>
                  </xsl:if>
                </xsl:for-each>
              </description>
            </item>
          </xsl:if>
        </xsl:for-each>
      </channel>
    </rss>
  </xsl:template>
</xsl:stylesheet>
