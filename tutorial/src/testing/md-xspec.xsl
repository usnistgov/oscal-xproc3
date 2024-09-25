<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:x="http://www.jenitennison.com/xslt/xspec"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   exclude-result-prefixes="#all"
   version="3.0">
   
   
   <xsl:function name="ox:as-text-node" as="text()">
      <xsl:param name="str" as="xs:string"/>
      <xsl:value-of select="$str"/>
   </xsl:function>
   
   
   
</xsl:stylesheet>