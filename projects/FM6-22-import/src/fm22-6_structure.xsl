<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:math="http://www.w3.org/2005/xpath-functions/math"
   exclude-result-prefixes="xs math"
   
   xmlns="http://www.w3.org/1999/xhtml"
   xpath-default-namespace="http://www.w3.org/1999/xhtml"
   version="3.0">
   
   <xsl:mode on-no-match="shallow-copy"/>
   
   <xsl:template match="body" expand-text="true">
      <xsl:copy>
         <xsl:for-each-group select="*" group-starting-with="*[@class = 's17']">
            <section class="activity">
               <h1 class="head">{ normalize-space(.) }</h1>
               <xsl:for-each-group select="current-group()" group-starting-with="*[@class = 's23']">
                  <section class="capability">
                     <h2 class="head">{ normalize-space(.) }</h2>
                     <xsl:apply-templates select="current-group()"/>
                  </section>
               </xsl:for-each-group>
            </section>
         </xsl:for-each-group>
      </xsl:copy>
   </xsl:template>
</xsl:stylesheet>