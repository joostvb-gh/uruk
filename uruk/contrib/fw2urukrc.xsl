<?xml version="1.0" encoding="UTF-8"?>
<!--+
     | MIT Licence
     | 
     | Copyright (c) 2007 Tilburg University, http://www.uvt.nl/
     | 
     | Permission is hereby granted, free of charge, to any person obtaining a
     | copy of this software and associated documentation files (the "Software"),
     | to deal in the Software without restriction, including without limitation
     | the rights to use, copy, modify, merge, publish, distribute, sublicense,
     | and/or sell copies of the Software, and to permit persons to whom the
     | Software is furnished to do so, subject to the following conditions:
     |
     | The above copyright notice and this permission notice shall be included
     | in all copies or substantial portions of the Software.
     |
     | THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
     | OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
     | FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
     | AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
     | LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
     | FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
     | DEALINGS IN THE SOFTWARE.
     +-->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  xmlns:fw="http://www.mokolo.org/fwxml">
  
  <xsl:output method="text" media-type="text-plain" encoding="UTF-8"/>
  
  <xsl:key name="grants-by-service-ref" match="fw:grant" use="@service-ref"/>

  <xsl:template match="/fw:firewall">
    <xsl:apply-templates select="fw:interfaces" mode="list"/>
    <xsl:apply-templates select="fw:interfaces" mode="network"/>
    <xsl:apply-templates select="fw:sources/fw:source" mode="source"/>
    <xsl:text>
</xsl:text>

    <xsl:apply-templates select="fw:interfaces/fw:interface/fw:grants-tcp" mode="services">
      <xsl:with-param name="protocol">
        <xsl:text>tcp</xsl:text>
      </xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="fw:interfaces/fw:interface/fw:grants-udp" mode="services">
      <xsl:with-param name="protocol">
        <xsl:text>udp</xsl:text>
      </xsl:with-param>
    </xsl:apply-templates>
    <xsl:text>
</xsl:text>

    <xsl:apply-templates select="fw:interfaces/fw:interface/fw:grants-tcp" mode="sources">
      <xsl:with-param name="protocol">
        <xsl:text>tcp</xsl:text>
      </xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="fw:interfaces/fw:interface/fw:grants-udp" mode="sources">
      <xsl:with-param name="protocol">
        <xsl:text>udp</xsl:text>
      </xsl:with-param>
    </xsl:apply-templates>
    <xsl:text>
</xsl:text>

    <xsl:apply-templates select="fw:interfaces/fw:interface/fw:grants-tcp" mode="ports">
      <xsl:with-param name="protocol">
        <xsl:text>tcp</xsl:text>
      </xsl:with-param>
    </xsl:apply-templates>
    <xsl:apply-templates select="fw:interfaces/fw:interface/fw:grants-udp" mode="ports">
      <xsl:with-param name="protocol">
        <xsl:text>udp</xsl:text>
      </xsl:with-param>
    </xsl:apply-templates>
    <xsl:text>
</xsl:text>

  </xsl:template>

  <xsl:template match="fw:interfaces" mode="list">
    <xsl:text>interfaces="</xsl:text>
      <xsl:for-each select="fw:interface">
        <xsl:if test="position() &gt; 1">
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:value-of select="@name"/>
      </xsl:for-each>
    <xsl:text>"
</xsl:text>
    <xsl:text>interfaces_nocast="</xsl:text>
      <xsl:for-each select="fw:interface">
        <xsl:if test="position() &gt; 1">
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:value-of select="@name"/>
      </xsl:for-each>
    <xsl:text>"

</xsl:text>
  </xsl:template>
  
  <xsl:template match="fw:interfaces" mode="network">
    <xsl:for-each select="fw:interface">
      <xsl:text>ip_</xsl:text>
      <xsl:value-of select="@name"/>
      <xsl:text>=</xsl:text>
      <xsl:value-of select="@ip"/>
      <xsl:text>
</xsl:text>
      <xsl:text>net_</xsl:text>
      <xsl:value-of select="@name"/>
      <xsl:text>=</xsl:text>
      <xsl:value-of select="@network"/>
      <xsl:text>
</xsl:text>
      <xsl:text>bcast_</xsl:text>
      <xsl:value-of select="@name"/>
      <xsl:text>=</xsl:text>
      <xsl:value-of select="@broadcast"/>
      <xsl:text>
</xsl:text>
    </xsl:for-each>
      <xsl:text>
</xsl:text>
  </xsl:template>
  
  <xsl:template match="fw:source" mode="source">
    <xsl:text>source_</xsl:text>
    <xsl:variable name="source-name">
      <xsl:value-of select="@name"/>
    </xsl:variable>
    <xsl:value-of select="$source-name"/>
    <xsl:text>="</xsl:text>
    <xsl:for-each select="fw:network-refs/fw:network-ref/@name">
      <xsl:variable name="network-name">
        <xsl:value-of select="."/>
      </xsl:variable>
      <xsl:if test="position() &gt; 1">
        <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:value-of select="/fw:firewall/fw:networks/fw:network[@name = $network-name]/@ip-range"/>
    </xsl:for-each>
    <xsl:text>"
</xsl:text>
  </xsl:template>

  <xsl:template match="fw:grants-tcp | fw:grants-udp" mode="services">
    <xsl:param name="protocol"/>
    <xsl:variable name="interface-name">
      <xsl:value-of select="../@name"/>
    </xsl:variable>
    <xsl:variable name="grants">
      <xsl:copy-of select="fw:grant"/>
    </xsl:variable>
    <xsl:text>services_</xsl:text>
    <xsl:value-of select="$interface-name"/>
    <xsl:text>_</xsl:text>
    <xsl:value-of select="$protocol"/>
    <xsl:text>="</xsl:text>
    <xsl:call-template name="list-unique-services">
      <xsl:with-param name="grants" select="$grants"/>
    </xsl:call-template>
    <xsl:text>"
</xsl:text>
  </xsl:template>
  
  <xsl:template match="fw:grants-tcp | fw:grants-udp" mode="sources">
    <xsl:param name="protocol"/>
    <xsl:variable name="interface-name">
      <xsl:value-of select="../@name"/>
    </xsl:variable>
    <xsl:variable name="grants">
      <xsl:copy-of select="fw:grant"/>
    </xsl:variable>
    <xsl:call-template name="list-sources-for-services">
      <xsl:with-param name="interface-name" select="$interface-name"/>
      <xsl:with-param name="protocol" select="$protocol"/>
      <xsl:with-param name="grants" select="$grants"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="fw:grants-tcp | fw:grants-udp" mode="ports">
    <xsl:param name="protocol"/>
    <xsl:variable name="interface-name">
      <xsl:value-of select="../@name"/>
    </xsl:variable>
    <xsl:variable name="grants">
      <xsl:copy-of select="fw:grant"/>
    </xsl:variable>
    <xsl:variable name="services">
      <xsl:copy-of select="/fw:firewall/fw:services/fw:service"/>
    </xsl:variable>
    <xsl:call-template name="list-ports-for-services">
      <xsl:with-param name="interface-name" select="$interface-name"/>
      <xsl:with-param name="protocol" select="$protocol"/>
      <xsl:with-param name="grants" select="$grants"/>
      <xsl:with-param name="services" select="$services"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="list-unique-services">
    <xsl:param name="grants"/>
    <xsl:for-each select="exsl:node-set($grants)/fw:grant[generate-id()=generate-id(key('grants-by-service-ref', @service-ref))]">
      <xsl:if test="position() &gt; 1">
        <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:value-of select="@service-ref"/>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="list-sources-for-services">
    <xsl:param name="interface-name"/>
    <xsl:param name="protocol"/>
    <xsl:param name="grants"/>
    <xsl:for-each select="exsl:node-set($grants)/fw:grant[generate-id()=generate-id(key('grants-by-service-ref', @service-ref))]">
      <xsl:text>sources_</xsl:text>
      <xsl:value-of select="$interface-name"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="$protocol"/>
      <xsl:text>_</xsl:text>
      <xsl:variable name="service-name">
        <xsl:value-of select="@service-ref"/>
      </xsl:variable>
      <xsl:value-of select="$service-name"/>
      <xsl:text>="</xsl:text>
      <xsl:for-each select="../fw:grant[@service-ref = $service-name]">
        <xsl:if test="position() &gt; 1">
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:text>$source_</xsl:text>
        <xsl:value-of select="@source-ref"/>
      </xsl:for-each>
      <xsl:text>"
</xsl:text>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="list-ports-for-services">
    <xsl:param name="interface-name"/>
    <xsl:param name="protocol"/>
    <xsl:param name="grants"/>
    <xsl:param name="services"/>
    <xsl:for-each select="exsl:node-set($grants)/fw:grant[generate-id()=generate-id(key('grants-by-service-ref', @service-ref))]">
      <xsl:text>ports_</xsl:text>
      <xsl:value-of select="$interface-name"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="$protocol"/>
      <xsl:text>_</xsl:text>
      <xsl:variable name="service-name">
        <xsl:value-of select="@service-ref"/>
      </xsl:variable>
      <xsl:value-of select="$service-name"/>
      <xsl:text>="</xsl:text>
      <xsl:call-template name="list-ports">
        <xsl:with-param name="services" select="$services"/>
        <xsl:with-param name="service-name" select="$service-name"/>
      </xsl:call-template>
      <xsl:text>"
</xsl:text>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="list-ports">
    <xsl:param name="services"/>
    <xsl:param name="service-name"/>
    <xsl:for-each select="exsl:node-set($services)/fw:service[@name = $service-name]/fw:ports/fw:port">
      <xsl:if test="position() &gt; 1">
        <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:value-of select="@nr"/>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>

