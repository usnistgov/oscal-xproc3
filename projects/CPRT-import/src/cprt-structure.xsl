<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns="http://csrc.nist.gov/ns/cprt"
   xpath-default-namespace="http://csrc.nist.gov/ns/cprt"
   exclude-result-prefixes="#all"
   version="3.0">
   
   <!--
   For XSLT:
   
   link up statement hierarchies
   connect up
     external references
     addressed by
     incorporated into
   cross-check - do all elements/* come across into result?
   -->
   
   <xsl:template match="/CPRT">
      <HIERARCHY>
         <xsl:apply-templates mode="build" select="elements/family">
            <xsl:sort select="@id"/>
         </xsl:apply-templates>
      </HIERARCHY>
   </xsl:template>
   
   <xsl:template mode="build" match="*">
      <xsl:message expand-text="true">build stopped on { name() }"</xsl:message>
   </xsl:template>
      
   
   <xsl:template mode="build" match="elements/*">
      <xsl:copy>
         <xsl:copy-of select="@id"/>
         <xsl:copy-of select="*"/>
         <xsl:apply-templates mode="#current" select="key('relationships', @id)">
            <xsl:with-param name="here" select="."/>
            <xsl:sort select="child::dest"/>
         </xsl:apply-templates>
      </xsl:copy>
   </xsl:template>
   
   <xsl:template match="relationships/external_reference | relationships/incorporated_into | relationships/addressed_by" priority="10" mode="build">
      <xsl:copy>
         <xsl:call-template name="link-attributes"/>
      </xsl:copy>
   </xsl:template>
   
   <xsl:template name="link-attributes">
         <xsl:attribute name="source" select="source"/>
         <xsl:attribute name="dest" select="dest"/>
   </xsl:template>
   
   <xsl:template match="relationships/*" mode="build">
      <xsl:param name="here" required="true"/>
      <xsl:param name="so-far" tunnel="true" as="xs:string*" select="()"/>
      <xsl:copy>
         <xsl:call-template name="link-attributes"/>
         <xsl:choose>
            <xsl:when test="not($here/@id = $so-far)">
               <xsl:apply-templates mode="#current" select="key('element-by-id', dest)">
                  <xsl:with-param name="so-far" tunnel="true" select="$so-far, $here/@id/string()"/>
               </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
               <xsl:message expand-text="true">Not traversing to { $here/@id} ... already did that</xsl:message> 
            </xsl:otherwise>
         </xsl:choose>
      </xsl:copy>
   </xsl:template>
   
   <xsl:key name="relationships" match="relationships/*" use="source/string()"/>
   
   <xsl:key name="element-by-id" match="elements/*" use="@id"/>
   
</xsl:stylesheet>