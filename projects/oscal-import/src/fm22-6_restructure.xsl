<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:math="http://www.w3.org/2005/xpath-functions/math"
   exclude-result-prefixes="xs math"
   
   xmlns="http://www.w3.org/1999/xhtml"
   xpath-default-namespace="http://www.w3.org/1999/xhtml"
   version="3.0">
   
   <xsl:mode on-no-match="shallow-copy"/>
   
   <xsl:template match="head"/>
   
   <xsl:template match="section[h2=../h1]">
      <xsl:apply-templates/>
   </xsl:template>
   
   <xsl:template match="section[h1='Chapter 4']">
      <xsl:apply-templates/>
   </xsl:template>
   
   <xsl:template match="h2[.=../../h1]"/>
   
   <xsl:template match="p[string(.) => normalize-space() => not()]"/>
   
   <xsl:template match="@bgcolor" priority="2">
      <xsl:copy-of select="."/>
   </xsl:template>
   
   <xsl:template match="span[@class='s15']">
      <b>
         <xsl:apply-templates/>
      </b>
   </xsl:template>
   
   <xsl:template match="span[@class='s16']">
      <br/>
      <b>
         <xsl:apply-templates/>
      </b>
   </xsl:template>
   
   <xsl:template match="@colspan | @rowspan">
      <xsl:copy-of select="."/>
   </xsl:template>
   
   <xsl:template match="@*"/>
   
</xsl:stylesheet>