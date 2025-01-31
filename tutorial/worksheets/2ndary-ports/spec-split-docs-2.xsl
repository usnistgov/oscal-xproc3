<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:math="http://www.w3.org/2005/xpath-functions/math"
   exclude-result-prefixes="xs math"
   version="3.0">
   
   
   <xsl:output method="xml" encoding="utf-8" indent="no"/>
   
   <xsl:mode on-no-match="shallow-copy"/>
   
   <xsl:template match="/">
      <xsl:result-document href="split2a.xml"><doc/></xsl:result-document>
      <xsl:result-document href="split2b.xml"><doc/></xsl:result-document>
      <xsl:apply-templates/>
   </xsl:template>
   
</xsl:stylesheet>