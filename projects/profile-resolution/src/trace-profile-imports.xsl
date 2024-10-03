<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="#all"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns="http://csrc.nist.gov/ns/oscal-xproc3"
   xpath-default-namespace="http://csrc.nist.gov/ns/oscal/1.0"
   version="3.0"
   expand-text="true"
   default-mode="ox:import-trace">
   
   <!-- Includes: functions that return
          - whether import state is in order (a boolean value)
          - what the import tree looks like, for diagnostics -->
      
   <!-- A set of templates that returns an import tree with or without retrieval errors reported -->
   
   <!-- Tested interactively.
      XSpec will require the creation of a small set of pathological examples
      showing different kinds of breakage.  -->

   <!--
      Retrieval errors can be of two kinds:
     1. missing or unavailable resource
     2. circular import
     Cautions must be made regarding use of XML catalogs or other interferences with URI retrieval
   -->

   <xsl:function name="ox:import-tree" as="document-node()">
      <xsl:param name="for-profile" as="element()"/>
      <xsl:apply-templates select="$for-profile" mode="ox:import-trace"/>
   </xsl:function>
   
   <xsl:function name="ox:imports-okay" as="xs:boolean">
      <xsl:param name="for-profile" as="element()"/>
      <xsl:variable name="tree">
         <xsl:apply-templates select="$for-profile" mode="ox:import-trace"/>
      </xsl:variable>
      <!-- Anything in the tree other than a profile or catalog brings back false() -->
      <xsl:sequence select="empty($tree/descendant-or-self::* except ($tree/descendant-or-self::ox:profile | $tree/descendant-or-self::ox:catalog))"/>
   </xsl:function>
   
   <xsl:output indent="true"/>
   
   <xsl:template match="profile" mode="ox:import-trace">
      <xsl:param name="import-stack" as="xs:anyURI*" tunnel="true" select="()"/>
      <profile uri="{ base-uri(.) }">
         <xsl:apply-templates select="descendant::import" mode="#current">
            <xsl:with-param name="import-stack"  as="xs:anyURI*" tunnel="true" select="$import-stack, base-uri(.)"/>
         </xsl:apply-templates>
      </profile>
   </xsl:template>
   
   <xsl:template match="catalog" mode="ox:import-trace">
      <catalog uri="{ base-uri(.) }"/>
   </xsl:template>
   
   <xsl:template match="*" priority="-0.1" mode="ox:import-trace">
      <xsl:copy copy-namespaces="no">
         <xsl:attribute name="ox:uri">{ base-uri(.) }</xsl:attribute>
      </xsl:copy>
   </xsl:template>
   
   <xsl:key name="internal-resources" match="resource[exists(@uuid)]" use="'#' || @uuid"/>

   <xsl:function name="ox:given-href" as="xs:anyURI?" cache="true">
      <xsl:param name="import" as="element(import)"/>
      <!-- $target is any oscal:resource indicated with an internal link -->
      <xsl:variable name="target" select="key('internal-resources',$import/@href,$import/root())/descendant::rlink[not(@media-type!='application/oscal.catalog+xml')][exists(@href)]"/>
      
      <!-- $pointer is the first target, or the import itself if there is none -->
      <xsl:variable name="pointer" select="($target,$import)[1]"/>
      
      <!-- We want the expanded URI of the pointer's href, if it is an href, or nada -->
      <xsl:sequence select="$pointer/@href[. castable as xs:anyURI] => resolve-uri(base-uri($import))"/>
   </xsl:function>

   <!--Top-priority matching template intercepts circular references before any traversal -->
   <xsl:template priority="25" match="profile//import" mode="ox:import-trace">
      <xsl:param name="import-stack" as="xs:anyURI*" tunnel="true" select="()"/>
      <xsl:choose>
         <xsl:when test="ox:given-href(.) = $import-stack">
            <circular href="{ @href }" addressing="{ ox:given-href(.) }"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:next-match/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <xsl:template priority="22" match="profile//import[empty(ox:given-href(.))]" mode="ox:import-trace">
      <broken href="{ @href }"/>
   </xsl:template>
   
   <xsl:template priority="20" match="profile//import[ox:given-href(.) => doc-available()]" mode="ox:import-trace">
      <xsl:param name="import-stack" as="xs:anyURI*" tunnel="true" select="()"/>
      <xsl:apply-templates select="ox:given-href(.) => document()" mode="#current">
         <xsl:with-param name="import-stack"  as="xs:anyURI*" tunnel="true" select="$import-stack, base-uri(/*)"/>
      </xsl:apply-templates>
   </xsl:template>

   <xsl:template priority="10" match="profile//import" mode="ox:import-trace">
      <missing href="{ @href }" addressing="{ ox:given-href(.) }"/>
   </xsl:template>

</xsl:stylesheet>