<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xlink="http://www.w3.org/1999/xlink" exclude-result-prefixes="#all"
    version="3.0"
    xpath-default-namespace="http://www.w3.org/1999/xhtml">

    <xsl:output indent="true"/><!-- for now; make a post-process later -->

<xsl:mode on-no-match="shallow-copy"/>
    
   <xsl:template match="/html">
      <xsl:apply-templates select="child::body"/>
   </xsl:template>
   
   <xsl:template match="/html">
      <standard>
         <front>
            <xsl:call-template name="metadata-block"/>
         </front>
            <xsl:apply-templates select="child::body"/>
         <!--<xsl:apply-templates select="back-matter" mode="back-matter"/>-->
      </standard>
   </xsl:template>

   <xsl:template match="body">
      <body>
         <xsl:apply-templates/>
      </body>
   </xsl:template>
   <xsl:template name="metadata-block">
      <std-doc-meta>
         <title-wrap>
            <main-title-wrap>
                  <main>FM 6-22: Developing Leaders - Chapter 4: Learning and Developmental Activities</main>
            </main-title-wrap>
         </title-wrap>
         <std-ident>
            <doc-type>Field Manual</doc-type>
            <doc-number>FM 6-22</doc-number>
            <version>November 2022</version>
         </std-ident>
         <std-org std-org-role="developer">
            <std-org-name>US Army Publishing Directorate</std-org-name>
            <std-org-abbrev>APD</std-org-abbrev>
         </std-org>
         <content-language>en</content-language>
         <std-ref>FM 6-22</std-ref>
      </std-doc-meta>
   </xsl:template>
   
   <xsl:template match="*[@class='head']">
      <title>
         <xsl:apply-templates/>
      </title>
   </xsl:template>
   
   <!-- Marking subsequent p as bulleted for later grouping into lists -->
   <xsl:template match="bullet"/>
   
   <xsl:template match="h1[.='Chapter 4'] | p[.='Chapter 4']"/>
   
   <xsl:template match="p[.='Learning and Developmental Activities']" priority="20"/>
   
   <xsl:template match="p[.=preceding-sibling::*[1]]"/>
   
   <xsl:template match="section">
      <sec>
         <xsl:apply-templates/>
      </sec>
   </xsl:template>
   
   <xsl:template match="br">
      <break/>
   </xsl:template>
   
   <xsl:template match="section/h1 | section/h2 | section/h3">
      <title>
         <xsl:apply-templates/>
      </title>
   </xsl:template>
       
   <xsl:template match="p">
      <p>
         <xsl:for-each select="preceding-sibling::*[1]/self::bullet">
            <xsl:attribute name="style-type">bullet</xsl:attribute>
         </xsl:for-each>
         <xsl:apply-templates/>
      </p>
   </xsl:template>
   
   <xsl:template match="bullet"/>
         
   <xsl:template match="table" priority="32" expand-text="true">
      <xsl:variable name="title-p" select="preceding-sibling::*[1]"/>
      <xsl:variable name="tableNo" select="replace($title-p,'(^Table 4\-|\..*$)','')"/>
      <table-wrap id="table4_{ $tableNo}">
         <label>Table 4-{ $tableNo }</label>
         <caption>
            <title>{ substring-after($title-p,'. ') }</title>
         </caption>
         <xsl:next-match/>
      </table-wrap>
   </xsl:template>
   
   <xsl:template match="div">
      <boxed-text>
         <xsl:apply-templates/>
      </boxed-text>
   </xsl:template>
   
   <xsl:template match="b">
      <bold>
         <xsl:apply-templates/>
      </bold>
   </xsl:template>
   
   <xsl:template match="i">
      <italic>
         <xsl:apply-templates/>
      </italic>
   </xsl:template>
   
   <xsl:template match="table | tbody | tr | th | td">
      <xsl:element name="{ name()}">
         <xsl:apply-templates select="@*"/>
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>
   
   <xsl:template match="@colspan | @rowspan">
      <xsl:copy-of select="."/>
   </xsl:template>
   
   <xsl:template match="@bgcolor">
      <xsl:attribute name="content-type">label</xsl:attribute>
   </xsl:template>
   
   <xsl:template match="span">
      <named-content content-type="special">
         <xsl:apply-templates/>
      </named-content>
   </xsl:template>
   
   <xsl:template match="*">
      <xsl:message expand-text="true">NOT MATCHING { name() }</xsl:message>
      <xsl:next-match/>
   </xsl:template>
</xsl:stylesheet>