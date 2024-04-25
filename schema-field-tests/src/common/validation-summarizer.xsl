<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:math="http://www.w3.org/2005/xpath-functions/math"
   xmlns:xvrl="http://www.xproc.org/ns/xvrl"
   xmlns:nm="http://csrc.nist.gov/ns/metaschema"
   exclude-result-prefixes="xs math"
    expand-text="true"
   version="3.0">
   
   
   <xsl:template match="/*">
      <xsl:variable name="anomalies"
         select="child::NOMINALLY-VALID/document[@SCHEMA-VALIDATION-STATUS='INVALID'] |
                 child::NOMINALLY-INVALID/document[@SCHEMA-VALIDATION-STATUS='VALID']"/>
      <REPORT>
         <progress>Examining { count(*/*) }{ if (count(*/*) eq 1) then ' document' else ' documents' } ...</progress>
         <xsl:apply-templates select="child::*/document"/>
         
         <xsl:if test="empty($anomalies)">
            <summary>ALL GOOD - confirming expected results from validation against reference sets</summary>
         </xsl:if>
      </REPORT>
   </xsl:template>
   
   <xsl:template match="NOMINALLY-VALID/document[@SCHEMA-VALIDATION-STATUS='INVALID']" priority="10">
      <finding href="{@href}">VALIDATION ANOMALY: a document collected as 'valid' is found to be INVALID - { @VALIDATION-MODE } validation using schema { @SCHEMA }</finding>
   </xsl:template>
   
   <xsl:template match="NOMINALLY-INVALID/document[not(@SCHEMA-VALIDATION-STATUS='INVALID')]" priority="11">
      <finding href="{@href}">VALIDATION ANOMALY: a document collected as 'invalid' is found to be VALID - { @VALIDATION-MODE } validation using schema { @SCHEMA }</finding>
   </xsl:template>
   
   <xsl:template match="document[@SCHEMA-VALIDATION-STATUS='INVALID']" priority="3">
      <finding href="{@href}">CONFIRMED (invalid)</finding>
   </xsl:template>
   
   <xsl:template match="document">
      <finding href="{@href}">CONFIRMED (valid)</finding>
   </xsl:template>
     
</xsl:stylesheet>