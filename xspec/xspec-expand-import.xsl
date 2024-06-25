<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:XSLT="http://www.w3.org/1999/XSL/Transform"
   exclude-result-prefixes="#all">

   <xsl:param name="imported" as="document-node()?"/>

   <xsl:mode on-no-match="shallow-copy"/>

   <xsl:template match="XSLT:import">
      <xsl:comment> Here cometh inserted XSLT (XProc implemented import) ...</xsl:comment>
      <xsl:copy-of select="$imported/XSLT:*/child::*"/>
      <xsl:comment> Ending imported XSLT</xsl:comment>
   </xsl:template>

</xsl:stylesheet>
