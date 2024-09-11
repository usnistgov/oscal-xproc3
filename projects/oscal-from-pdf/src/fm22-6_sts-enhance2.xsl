<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xlink="http://www.w3.org/1999/xlink"
   exclude-result-prefixes="#all">

   <!--<xsl:output indent="true"/>-->

   <xsl:mode on-no-match="shallow-copy"/>

<!-- Remediating broken paragraphs emitted by Adobe Acrobat in HTML production. -->
   
   <xsl:template match="sec | list-item | th | td">
      <xsl:copy>
         <xsl:copy-of select="@*"/>
         <xsl:for-each-group select="child::*" group-adjacent="exists(self::p)">
           <xsl:choose>
              <xsl:when test="current-grouping-key()">
                 <xsl:call-template name="break-paragraphs"/>
              </xsl:when>
              <xsl:otherwise>
                 <xsl:apply-templates select="current-group()"/>
              </xsl:otherwise>
           </xsl:choose>
         </xsl:for-each-group>
      </xsl:copy>
   </xsl:template>
   
   <xsl:template name="break-paragraphs">
     <xsl:for-each-group select="current-group()" group-ending-with="*[matches(.,'[\?\.]\)?\s*$')]">
        <p>
           <xsl:for-each select="current-group()">
              <xsl:if test="position() > 1">
                 <xsl:text> </xsl:text>
              </xsl:if>
              <xsl:apply-templates select="child::node()"/>
           </xsl:for-each>
        </p>
     </xsl:for-each-group>
      
   </xsl:template>
   
   
   <!-- No longer need this marker -->
   <xsl:template match="named-content">
      <xsl:apply-templates/>
   </xsl:template>
   
   <xsl:template match="p/text()[following-sibling::*[1]/self::named-content]">
      <italic>
         <xsl:copy-of select="normalize-space(.)"/>
      </italic>
      <xsl:text> </xsl:text>
   </xsl:template>
   
   <xsl:template match="italic[ends-with(.,' ')]">
      <xsl:copy>
      <xsl:value-of select="normalize-space(.)"/>
      </xsl:copy>
      <xsl:text> </xsl:text>
   </xsl:template>
   
   <xsl:template match="boxed-text[caption/title='Employing Leadership Requirements Model Developmental Activities']">
      <xsl:copy>
         <xsl:copy-of select="@*"/>
         <xsl:apply-templates mode="dropping-quote"/>
         <disp-quote>
            <xsl:apply-templates mode="keeping-quote"/>
         </disp-quote>
      </xsl:copy>
   </xsl:template>
   
   <xsl:mode name="dropping-quote" on-no-match="deep-copy"/>
   
   <xsl:template match="p[starts-with(.,'~from')]" mode="dropping-quote"/>
   <xsl:template match="p[starts-with(following-sibling::*[1]/self::p,'~from')]" mode="dropping-quote"/>
   
   <xsl:template match="*" mode="keeping-quote"/>
   
   <xsl:template match="p[starts-with(.,'~from')]" mode="keeping-quote">
      <attrib>
         <xsl:apply-templates/>
      </attrib>
   </xsl:template>
   
   <xsl:template match="p[starts-with(following-sibling::*[1]/self::p,'~from')]" mode="keeping-quote">
      <xsl:copy-of select="."/>
   </xsl:template>
   
   <xsl:template match="table-wrap[@id=preceding-sibling::table-wrap/@id]" priority="28"/>
   
   <!-- A list of keywords that *happen* to mark competencies by virtue of appearing in table 4-5 -->
   <xsl:variable name="competencies" select="'leads', 'builds','extends','communicates','prepares','creates','develops','stewards','gets'"/>
   
   <xsl:template match="table-wrap[table/descendant::td = 'Strength Indicators']">
      <xsl:copy>
         <xsl:copy-of select="@*"/>
         <!-- If one of the 'competency' keywords is found among titles of sections containing this table, it's a 'competency' control -->
         <xsl:attribute name="custom-type" expand-text="true">{ if (ancestor::sec/title/lower-case(.)!tokenize(.,'\s+') = $competencies) then 'competency' else 'attribute' }</xsl:attribute>
         <xsl:apply-templates/>
         <xsl:apply-templates select="descendant::tr[starts-with(normalize-space(.),'Legend:')]" mode="table-glossary"/>
      </xsl:copy>
   </xsl:template>
   
   <xsl:template match="tr" mode="table-glossary">
      <xsl:variable name="marked-row">
         <xsl:analyze-string select="normalize-space(.)" regex="[A-Z][A-Z]+">
            <xsl:matching-substring>
               <term>
                  <xsl:value-of select="."/>
               </term>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
               <xsl:value-of select="."/>
            </xsl:non-matching-substring>
         </xsl:analyze-string>
      </xsl:variable>
      <def-list>
         <title>Legend</title>
         <xsl:iterate select="$marked-row/term" expand-text="true">
            <def-item>
               <xsl:copy-of select="."/>
               <def>
                  <p>{ following-sibling::text()[1] ! normalize-space(.) }</p>
               </def>
            </def-item>
         </xsl:iterate>
      </def-list>
   </xsl:template>
   
   <!-- Dropping these since the values for the Legend are pulled into the def-list above -->
   <xsl:template match="tr[starts-with(normalize-space(.),'Legend:')]"/>
  
   <xsl:template match="tbody">
      <xsl:variable name="tableID" select="parent::table/parent::table-wrap/@id"/>
      <xsl:copy>
         <xsl:copy-of select="@*"/>
         <xsl:apply-templates select="parent::table/parent::table-wrap/../child::table-wrap[@id=$tableID]/table/tbody/*"/>
      </xsl:copy>
   </xsl:template>
   
</xsl:stylesheet>