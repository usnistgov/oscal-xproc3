<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns="http://csrc.nist.gov/ns/cprt"
   xpath-default-namespace="http://csrc.nist.gov/ns/cprt"
   exclude-result-prefixes="#all"
   version="3.0">
   
  <xsl:mode on-no-match="shallow-copy"/>
   
   <!--removing projection layers
   collapsing links
    -->
   
   <xsl:template match="requirement">
      <xsl:copy>
         <xsl:copy-of select="@*"/>
         <xsl:variable name="subcontrols" select="*/child::security_requirement/parent::*"/>
         <xsl:variable name="references" select="*/child::reference/parent::*"/>
         <xsl:apply-templates select="* except ($subcontrols | $references)"/>
         <xsl:apply-templates select="$subcontrols"/>
         <xsl:apply-templates select="$references"/>
      </xsl:copy>
   </xsl:template>
   
   <xsl:template match="projection">
      <xsl:apply-templates/>
   </xsl:template>
   
   <xsl:template match="external_reference | addressed-by | incorporated_into" expand-text="true">
      <xsl:copy>{ @dest }</xsl:copy>
   </xsl:template>
   
</xsl:stylesheet>