<?xml version="1.0"?><!--hellohtm.xsl-->
<!--XSLT 1.0 - http://www.CraneSoftwrights.com/training -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml"
      version="1.0" >

<xsl:variable name="siteurl" select="'https://www.dvdsreleasedates.com'" />

<xsl:template match="xhtml:html">
    <rss version="2.00">
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
        </channel>
        <xsl:for-each select="//xhtml:table[@class='fieldtable-inner']">
          <item>
            <title>
              <xsl:for-each select="xhtml:tr[1]/xhtml:td/text()">
                <xsl:value-of select='.' />
              </xsl:for-each>
            </title>
            <link><xsl:value-of select="$siteurl"/></link>
          </item>
          <description>
            <xsl:for-each select="xhtml:tr/xhtml:td/xhtml:a">
              <xsl:if test="text() != ''">
                <p><xsl:value-of select='text()' /></p>
              </xsl:if>
            </xsl:for-each>
          </description>
        </xsl:for-each>
    </rss>
</xsl:template>
</xsl:stylesheet>

