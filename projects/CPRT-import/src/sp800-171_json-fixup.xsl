<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:math="http://www.w3.org/2005/xpath-functions/math"
   xmlns:json="http://www.w3.org/2005/xpath-functions"
   xpath-default-namespace="http://csrc.nist.gov/ns/cprt"
   xmlns="http://csrc.nist.gov/ns/cprt"
   exclude-result-prefixes="xs math"
   version="3.0">
   
   <xsl:mode on-no-match="shallow-copy"/>
   
   <xsl:template match="json:*">
      <xsl:message terminate="true" expand-text="true">Not supposed to see { name() } here...</xsl:message>
   </xsl:template>
   
   <xsl:template match="/*">
      <CPRT>
         <xsl:apply-templates/>
      </CPRT>
   </xsl:template>
   
   <xsl:template match="/*/response | response/elements">
      <xsl:apply-templates/>
   </xsl:template>
   
   <xsl:template match="response/requestType"/>
   
   <xsl:template match="document">
      <xsl:copy>
         <xsl:attribute name="id" select="doc_identifier"/>
         <xsl:apply-templates/>
      </xsl:copy>
   </xsl:template>
   
   <xsl:template match="document/doc_identifier"/>
         
   <xsl:template match="relationship_type">
      <xsl:copy>
         <xsl:attribute name="id" select="relationship_identifier"/>
         <xsl:for-each select="description">
            <xsl:apply-templates/>
         </xsl:for-each>
      </xsl:copy>
   </xsl:template>
   
   <xsl:template match="element">
      <xsl:element name="{ child::element_type }">
         <xsl:attribute name="id" select="child::element_identifier"/>
         <xsl:attribute name="doc-id" select="child::doc_identifier"/>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>
   
   <xsl:template match="element/element_type"/>
   
   <xsl:template match="element/element_identifier"/>

   <xsl:template match="element/doc_identifier"/>
      
   <xsl:template match="relationship">
      <xsl:element name="{ child::relationship_identifier }">
         <xsl:attribute name="provenance" select="child::provenance_doc_identifier"/>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>

   <xsl:template match="relationship/relationship_identifier"/>
   
   <xsl:template match="relationship/source_element_identifier">
      <source doc-id="{../source_doc_identifier}">
         <xsl:apply-templates/>
      </source>
   </xsl:template>
   
   <xsl:template match="relationship/source_doc_identifier"/>
   
   <xsl:template match="relationship/dest_element_identifier">
      <dest doc-id="{../dest_doc_identifier}">
         <xsl:apply-templates/>
      </dest>
   </xsl:template>
   
   <xsl:template match="relationship/dest_doc_identifier"/>
   
   <xsl:template match="relationship/provenance_doc_identifier"/>
   
   
</xsl:stylesheet>