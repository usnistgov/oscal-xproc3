<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xpath-default-namespace="http://csrc.nist.gov/ns/cprt"
   xmlns="http://csrc.nist.gov/ns/cprt"
   exclude-result-prefixes="#all"
   expand-text="true"
   version="3.0">
   

   <xsl:mode on-no-match="shallow-copy"/>
   
   <xsl:template match="requirement">
      <xsl:copy>
         <xsl:copy-of select="attribute::*"/>
         <xsl:apply-templates>
            <xsl:with-param name="odp-sequence" select="descendant::odp" tunnel="true"/>
         </xsl:apply-templates>
      </xsl:copy>
   </xsl:template>
   
   <!-- A couple of special cases link ODPs from inside ODPs -->
   <xsl:template match="odp_statement/text/assignment" priority="5">
      <xsl:copy>
         <xsl:copy-of select="attribute::*"/>
         <xsl:attribute name="odp-ref-id" select="../parent::odp_statement/preceding-sibling::odp[1]/@id"/>
         <xsl:apply-templates/>
      </xsl:copy>
   </xsl:template>

   <xsl:template match="selection | assignment">
      <xsl:param name="odp-sequence" tunnel="true" select="()" as="element(odp)*"/>
      <xsl:variable name="position">
         <xsl:number level="any" from="requirement" count="selection | assignment"/>
      </xsl:variable>
      <xsl:copy>
         <xsl:copy-of select="attribute::*"/>
         <xsl:attribute name="odp-ref-id" select="$odp-sequence[number($position)]/@id"/>
         <xsl:apply-templates/>
      </xsl:copy>
   </xsl:template>


   <!-- A few pointers are misdirected ... -->
   <xsl:template priority="11" match="security_requirement[@id=('SR-03.04.06.c','SR-03.11.02.b','SR-03.11.02.c')]//assignment">
      <xsl:copy>
         <xsl:attribute name="odp-ref-id" select="../../determination/odp/@id"/>
         <xsl:apply-templates/>
      </xsl:copy>
   </xsl:template>
</xsl:stylesheet>