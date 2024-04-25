<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xvrl="http://www.xproc.org/ns/xvrl"
   xmlns:nm="http://csrc.nist.gov/ns/metaschema"
   exclude-result-prefixes="#all" version="3.0">

   <xsl:mode on-no-match="shallow-copy"/>

   <xsl:function name="nm:doc-loc" as="xs:string">
      <xsl:param name="doc" as="node()"/>
      <xsl:value-of select="($doc/descendant::xvrl:metadata/xvrl:document/@href, $doc/@baseURI)[1]"/>
   </xsl:function>

   <!--
      
      A file is assumed to be schema-valid if its directory structure includes a 'fully-valid' or 'constraints-invalid' folder
      
      Note since neither XSD nor JSON Schema can detect constraint violations, 'constraints-invalid' files will evade detection
      and hence must be considered valid.
      
   -->
   <xsl:function name="nm:is-supposed-valid" as="xs:boolean">
      <xsl:param name="doc" as="node()"/>

      <xsl:sequence select="tokenize(nm:doc-loc($doc), '/') = ('fully-valid','constraints-invalid')"/>
      <!--<xsl:sequence select="true()"/>-->
   </xsl:function>

   <xsl:template match="/*">
      <xsl:copy>
         <NOMINALLY-VALID>
            <xsl:apply-templates select="*[nm:is-supposed-valid(.)]"/>
         </NOMINALLY-VALID>
         <NOMINALLY-INVALID>
            <xsl:apply-templates select="*[nm:is-supposed-valid(.) => not()]"/>
         </NOMINALLY-INVALID>
      </xsl:copy>
   </xsl:template>

   <xsl:template match="/*/*">
      <document href="{ nm:doc-loc(.) }">
         <xsl:copy-of select="@VALIDATION-MODE, @SCHEMA, @SCHEMA-VALIDATION-STATUS"/>
      </document>
   </xsl:template>

</xsl:stylesheet>