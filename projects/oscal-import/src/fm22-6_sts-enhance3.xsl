<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xlink="http://www.w3.org/1999/xlink"
   exclude-result-prefixes="#all">

   <!--<xsl:output indent="true"/>-->

   <xsl:mode on-no-match="shallow-copy"/>

   <xsl:template match="p[target/@id='p4-8']/text()" priority="2">
      <xsl:analyze-string select="string(.)" regex="tables 4\-4 and 4\-5">
         <xsl:matching-substring>
            <xsl:text>tables </xsl:text>
            <xref rid="table4_4" ref-type="table">4-4</xref>
            <xsl:text> and </xsl:text>
            <xref rid="table4_5" ref-type="table">4-5</xref>
         </xsl:matching-substring>
         <xsl:non-matching-substring>
            <xsl:value-of select="."/>
         </xsl:non-matching-substring>
      </xsl:analyze-string>
   </xsl:template>
   
   <!-- Rewriting whitespace around solidus in a couple of places  -->
   <xsl:template match="td/p/text()[matches(.,'([^ ]/ )|( /[^ ])')]" priority="10">
      <xsl:text expand-text="true">{ replace(.,'/',' / ') => normalize-space() }</xsl:text>
   </xsl:template>
   
   <xsl:template match="p/text()">
      <xsl:analyze-string select="string(.)" regex="[tT]able 4\-(\d\d?)">
         <xsl:matching-substring>
            <xref rid="table4_{ regex-group(1) }" ref-type="table">
               <xsl:value-of select="normalize-space(.)"/>
            </xref>
         </xsl:matching-substring>
         <xsl:non-matching-substring>
            <xsl:value-of select="."/>
         </xsl:non-matching-substring>
      </xsl:analyze-string>
   </xsl:template>
   
   <xsl:template match="tr[1][td[last()]/normalize-space(.)='Go to…']" priority="5">
      <xsl:copy-of select="."/>
   </xsl:template>
   
   <xsl:template match="tr[td[last()]/normalize-space(.)='Go to…']"/>
   
   <!-- Removes an unwanted table cell from a left edge -->
   <xsl:template match="tr[count(td)=4]/td[1][p=parent::tr/preceding-sibling::tr/td[1]/p]"/>
   
   
</xsl:stylesheet>