<?xml version="1.0" encoding="UTF-8"?>
<!--+
     | MIT Licence
     | 
     | Copyright (c) 2007 Fred Vos - Mokolo.org
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
  xmlns:fw="http://www.mokolo.org/fwxml">
  
  <xsl:output method="text" media-type="text-plain" encoding="UTF-8"/>
  
  <xsl:template match="/fw:firewall">
    <xsl:text>digraph firewall {
  rankdir=LR;
  graph [bgcolor=transparent];
  node [shape=ellipse style=filled fontname=Arial fontsize=12]; /* default */
  edge [arrowhead=none]; /* default */

</xsl:text>

    <!-- Ports: -->
    
    <xsl:text>  subgraph cluster_0 {
    label="Ports";
    node [color=green];

</xsl:text>
    <xsl:for-each select="fw:services/fw:service/fw:ports/fw:port">
      <xsl:text>    port_</xsl:text><xsl:value-of select="@nr"/><xsl:text> [label="</xsl:text><xsl:value-of select="@nr"/><xsl:text>"];
</xsl:text>
    </xsl:for-each>
    <xsl:text>
  }
  
</xsl:text>

    <!-- Services: -->
    
    <xsl:text>  subgraph cluster_1 {
    label="Services";
    node [color=yellow];

</xsl:text>
    <xsl:for-each select="fw:services/fw:service">
      <xsl:text>    service_</xsl:text><xsl:value-of select="@name"/><xsl:text> [label="</xsl:text><xsl:value-of select="@name"/><xsl:text>"];
</xsl:text>
    </xsl:for-each>
    <xsl:text>
  }
  
</xsl:text>

    <!-- Sources: -->
    
    <xsl:text>  subgraph cluster_2 {
    label="Sources";
    node [color=orange];

</xsl:text>
    <xsl:for-each select="fw:sources/fw:source">
      <xsl:text>    source_</xsl:text><xsl:value-of select="@name"/><xsl:text> [label="</xsl:text><xsl:value-of select="@name"/><xsl:text>"];
</xsl:text>
    </xsl:for-each>
    <xsl:text>
  }
  
</xsl:text>

    <!-- Networks: -->
    
    <xsl:text>  subgraph cluster_3 {
    label="Networks";
    node [shape=record color=lightblue];

</xsl:text>
    <xsl:for-each select="fw:networks/fw:network">
      <xsl:text>    network_</xsl:text><xsl:value-of select="@name"/><xsl:text> [label="</xsl:text><xsl:value-of select="@name"/><xsl:text>|{</xsl:text><xsl:value-of select="@ip-range"/><xsl:text>}"];
</xsl:text>
    </xsl:for-each>
    <xsl:text>
  }
  
</xsl:text>

  <!-- Ports - Services: -->

    <xsl:for-each select="fw:services/fw:service/fw:ports/fw:port">
      <xsl:text>  port_</xsl:text>
      <xsl:value-of select="@nr"/>
      <xsl:text> -&gt; </xsl:text>
      <xsl:text>service_</xsl:text>
      <xsl:value-of select="../../@name"/>
      <xsl:text>;
</xsl:text>
    </xsl:for-each>

  <!-- Services - Sources: -->

    <xsl:for-each select="fw:interfaces/fw:interface/fw:grants/fw:grant">
      <xsl:text>  service_</xsl:text>
      <xsl:value-of select="@service-ref"/>
      <xsl:text> -&gt; </xsl:text>
      <xsl:text>source_</xsl:text>
      <xsl:value-of select="@source-ref"/>
      <xsl:text> [taillabel=</xsl:text>
      <xsl:value-of select="../../@name"/>
      <xsl:text> headlabel=</xsl:text>
      <xsl:value-of select="@protocol"/>
      <xsl:text>];
</xsl:text>
    </xsl:for-each>

  <!-- Sources - Networks: -->

    <xsl:for-each select="fw:sources/fw:source/fw:network-refs/fw:network-ref">
      <xsl:text>  source_</xsl:text>
      <xsl:value-of select="../../@name"/>
      <xsl:text> -&gt; </xsl:text>
      <xsl:text>network_</xsl:text>
      <xsl:value-of select="@name"/>
      <xsl:text>;
</xsl:text>
    </xsl:for-each>

  <xsl:text>
}
</xsl:text>

  </xsl:template>
  
</xsl:stylesheet>