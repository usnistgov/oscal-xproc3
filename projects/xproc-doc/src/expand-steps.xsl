<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
   xmlns:p="http://www.w3.org/ns/xproc" >

  <xsl:mode on-no-match="shallow-copy"/>

  <xsl:mode name="splice-steps" on-no-match="shallow-skip"/>
   
  <xsl:template match="file">
     <xsl:variable name="href" select="resolve-uri(@path,/directory/@xml:base)"/>
     <xsl:variable name="steps" select="$href[doc-available(.)] ! document(.)//(p:declare-step)"/>
     <xsl:copy>
        <xsl:copy-of select="@*"/>
<xsl:apply-templates mode="splice-steps" select="$steps"/>
     </xsl:copy>
     

     
  </xsl:template>
   
   <xsl:template match="p:declare-step | p:option | p:declare-step/p:input | p:declare-step/p:output | p:document | p:load | p:store | p:*[exists(@href)] | p:*[exists(@message)]" mode="splice-steps">
      <xsl:copy>
         <xsl:copy-of select="@*"/>
         <xsl:apply-templates mode="#current"/>
      </xsl:copy>
   </xsl:template>
   
   
</xsl:stylesheet>

