<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet  version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:oscal="http://csrc.nist.gov/ns/oscal/1.0">
   
   <xsl:import href="www_fm22-6_simple.xsl"/>
   
   <xsl:template match="oscal:catalog">
      <body class="catalog">
         <header>
            <xsl:apply-templates select="oscal:metadata/oscal:title"/>
         </header>
         <main>
            <xsl:apply-templates select="oscal:group[@class='requirement-category']"/>
         </main>
      </body>
   </xsl:template>
</xsl:stylesheet>