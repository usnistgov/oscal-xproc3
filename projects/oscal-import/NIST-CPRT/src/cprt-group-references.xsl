<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xpath-default-namespace="http://csrc.nist.gov/ns/cprt"
   xmlns="http://csrc.nist.gov/ns/cprt"
   exclude-result-prefixes="#all"
   expand-text="true"
   version="3.0">

   <!-- XSLT groups back together references written out as literals in an earlier phase -->

   <xsl:mode on-no-match="shallow-copy"/>
   
   <xsl:key name="reference-by-id" match="reference" use="@id"/>
   
   <xsl:template match="/HIERARCHY">
      <xsl:copy>
         <xsl:apply-templates/>
         <REFERENCES>
            <xsl:for-each-group select="//reference" group-by="@id">
               <reference id="{ generate-id() }">
                  <label>{ current-grouping-key() }</label>
                  <!-- We copy only one member's offspring - they are all the same -->
                  <xsl:copy-of select="current-group()[1]/*"/>
               </reference>
            </xsl:for-each-group>
         </REFERENCES>
      </xsl:copy>
   </xsl:template>
   
   <xsl:template match="reference">
      <xsl:variable name="first" select="key('reference-by-id',@id)[1]"/>
      <link href="#{ $first/generate-id() }" rel="reference"/>
   </xsl:template>
   
</xsl:stylesheet>