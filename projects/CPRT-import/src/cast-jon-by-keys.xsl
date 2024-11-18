<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:math="http://www.w3.org/2005/xpath-functions/math"
   xmlns:json="http://www.w3.org/2005/xpath-functions"
   xpath-default-namespace="http://www.w3.org/2005/xpath-functions"
   xmlns="http://csrc.nist.gov/ns/cprt"
   exclude-result-prefixes="xs math"
   version="3.0">
   
   <xsl:mode on-no-match="shallow-copy"/>
   
   <xsl:template match="map/*">
      <xsl:element name="{ @key }">
         <xsl:attribute name="type" select="local-name()"/>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>
   
   <xsl:template match="array/*">
      <xsl:variable name="n">
         <xsl:apply-templates select="parent::array" mode="member-key"/>
      </xsl:variable>
      <xsl:element name="{ $n }">
         <xsl:attribute name="type" select="local-name()"/>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>
   
   <xsl:template mode="member-key" priority="5" match="*[ends-with(@key,'s')]" expand-text="true">{ replace(@key,'s$','') }</xsl:template>
   
   <xsl:template mode="member-key" match="*" expand-text="true">{ @key }_</xsl:template>
   
</xsl:stylesheet>