<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet  version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:oscal="http://csrc.nist.gov/ns/oscal/1.0">
   
   <xsl:import href="www_fm22-6_fulltext.xsl"/>
   
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
   
   <!-- overriding import  -->
   <xsl:template match="oscal:control[@class='requirement']/oscal:title" priority="1">
      <summary class="h3">
         <xsl:apply-templates/>
      </summary>
   </xsl:template>
   
   <xsl:template name="extra-style">
      <style type="text/css">
         <xsl:text disable-output-escaping="yes"  xml:space="preserve">

main details.control { background-color: lightsteelblue  }

.requirements.group .group { display: inline-block; width: 24em; vertical-align: top;
   margin-top: 1em; margin-bottom: 0em; padding: 0.4em;
   border: thin solid black }

.requirements-group-title { margin-top: 0em }

details.control { background-color: whitesmoke; color: black; padding: 0.42em; border: thin outset black }

details[open] { width: max-content; padding-right: 2em; position: sticky; z-index: 2;
  border: medium inset black}
</xsl:text>
     </style>
   </xsl:template>
</xsl:stylesheet>