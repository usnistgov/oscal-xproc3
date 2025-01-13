<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:math="http://www.w3.org/2005/xpath-functions/math"
   exclude-result-prefixes="xs math"
   version="3.0">
   
   <xsl:mode on-no-match="shallow-copy"/>
   
   <xsl:template match="/div">
      <catalog>
         <xsl:apply-templates />
      </catalog>
   </xsl:template>
   
   <xsl:template match="div[@class='inner_container']">
      <control id="{child::a[1]/@id}">
         <xsl:apply-templates select="h2"/>
         <part name="statement">
           <xsl:apply-templates select="h3[1]/preceding-sibling::* except h2"/>
         </part>
         <xsl:for-each-group select="h3/(.|following-sibling::*)" group-starting-with="h3">
            <part>
               <xsl:apply-templates select="current-group()"/>
            </part>
         </xsl:for-each-group>
      </control>
   </xsl:template>
   
   <xsl:template match="h2 | h3">
      <title><xsl:apply-templates/></title>
   </xsl:template>
   
   <xsl:template match="div/a | h6"/>
   
</xsl:stylesheet>