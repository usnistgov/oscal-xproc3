<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="#all"
   expand-text="true">
   
<!-- Purpose: consumes results of validation-summarizer.xsl and emits plain text,
     with some ornamentation -->
   
   <xsl:mode on-no-match="text-only-copy"/>
   
   <xsl:template match="/*">
      <xsl:apply-templates/>
      <xsl:text>&#xA;{ (1 to 12) ! ':::::' }</xsl:text>
   </xsl:template>
   
   <xsl:template match="summary[starts-with(.,'ALL GOOD')]" priority="2">
      <xsl:text>&#xA;{ ((1 to count(../finding)) ! 'GOOD') => string-join('') }</xsl:text>
      <xsl:next-match/>
   </xsl:template>
   
   <xsl:template match="REPORT/*">
      <xsl:text>&#xA;</xsl:text>
      <xsl:apply-templates/>
      <xsl:apply-templates select="@href"/>
   </xsl:template>
   
   <xsl:template match="@href">: { . }</xsl:template>
   
</xsl:stylesheet>