<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
   xmlns:c="http://www.w3.org/ns/xproc-step">

  <xsl:mode on-no-match="shallow-copy"/>

   <xsl:template match="/*">
      <directory>
         <xsl:copy-of select="@*"/>
         <xsl:apply-templates/>
      </directory>
   </xsl:template>
   
   <xsl:template match="c:directory">
      <!-- Keeping only folders containing XProc, or directories with XProc -->
      <xsl:where-populated>
         <dir name="{@name}">
            <xsl:apply-templates/>
         </dir>
      </xsl:where-populated>
   </xsl:template>
   
   <!-- excluding XProcs deep inside /lib -->
   <xsl:template match="c:file[exists(parent::*/ancestor::*[@name='lib']/parent::c:directory[empty(parent::*)])]"/>
      
   <xsl:template match="c:file">
      <file path="{ ancestor-or-self::*/@xml:base => string-join('') }"/>
   </xsl:template>
   
</xsl:stylesheet>

