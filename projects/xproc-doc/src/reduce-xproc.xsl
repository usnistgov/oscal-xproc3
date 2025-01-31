<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step"   
   exclude-result-prefixes="#all" expand-text="true"
   version="3.0">
   
   <xsl:output indent="true"/>
   
   <xsl:strip-space elements="*"/>
   
   <!--XProc reduction XSLT -->
   
   <xsl:template match="*">
      <atomic name="{ local-name() }">
         <xsl:apply-templates select="@*"/>
         <xsl:for-each select="p:with-input">
            <with-input>
               <xsl:apply-templates select="@*"/>
               <xsl:apply-templates/>
            </with-input>
         </xsl:for-each>
      </atomic>
   </xsl:template>
   
   <xsl:template match="p:variable | p:documentation"/>
   
   <xsl:template match="p:declare-step | p:for-each | p:group | p:if | p:when | p:otherwise |
      p:catch | p:finally | p:viewport">
      <compound name="{ local-name() }">
         <xsl:apply-templates select="@*"/>
         <xsl:variable name="prologue" select="p:option | p:input | p:with-input | p:output | p:with-option"/>
         <xsl:apply-templates select="$prologue"/>
         <subpipeline>
            <xsl:apply-templates select="* except $prologue"/>
         </subpipeline>   
      </compound>
   </xsl:template>
   
   <xsl:template match="p:choose">
      <compound name="{ local-name() }">
         <xsl:apply-templates select="@*"/>
         <xsl:variable name="prologue" select="p:option | p:input | p:with-input | p:output | p:with-option"/>
         <xsl:apply-templates select="$prologue"/>
         <xsl:apply-templates select="* except $prologue"/>
      </compound>
   </xsl:template>
   
   <xsl:template match="p:try">
      <compound name="{ local-name() }">
         <xsl:apply-templates select="@*"/>
         <xsl:variable name="prologue" select="p:option | p:input | p:with-input | p:output | p:with-option"/>
         <xsl:apply-templates select="$prologue"/>
         <subpipeline>
            <xsl:apply-templates select="* except ($prologue | p:catch | p:finally)"/>
         </subpipeline>
         <xsl:apply-templates select="p:catch | p:finally"/>
         
      </compound>
   </xsl:template>
   
   <xsl:template match="p:with-input | p:empty | p:document | p:pipe | p:inline | p:input | p:output" priority="3">
      <xsl:element name="{ local-name() }">
         <xsl:apply-templates select="@*"/>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>
   
   <xsl:template match="p:with-input//* | p:inline//*">
      <xsl:copy copy-namespaces="no">
         <xsl:apply-templates select="@*"/>
         <!--<xsl:apply-templates/>-->
      </xsl:copy>
   </xsl:template>
      
   <xsl:template match="@*">
      <xsl:attribute name="_{ local-name(.) }" select="."/>
   </xsl:template>
   
   <xsl:template match="@serialization"/>
      
</xsl:stylesheet>