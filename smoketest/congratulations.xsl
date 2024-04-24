<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   version="3.0" expand-text="true" exclude-result-prefixes="#all">
   
   <!-- Purpose: validate the operation of the Saxon transformation engine inside an XProc configuration. -->
   <!-- Input: an XML document in no namespace with a single element CONGRATULATIONS, in no namespace, with plain text content, as in the pipeline file ../../hello-morgana.xpl -->
   
   <xsl:template match="/CONGRATULATIONS">
      <xsl:copy>
         <LINE><xsl:apply-templates/></LINE>
         <LINE>You have successfully executed an XSL transformation, using { system-property('xsl:product-name') } version { system-property('xsl:product-version') }.</LINE>
      </xsl:copy>
   </xsl:template>
   
</xsl:stylesheet>