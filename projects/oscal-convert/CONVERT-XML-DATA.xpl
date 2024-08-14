<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   type="ox:CONVERT-XML-DATA"
   name="CONVERT-XML-DATA">
   
<!-- Note: requires XSLT at $converter-xslt (provided by ../../GRAB-OSCAL.xpl) -->
   
   <p:directory-list path="data/catalog-model/xml" max-depth="unbounded" include-filter="_src\.html$"/>

   <p:variable name="converter-xslt" select="'lib/oscal_catalog_xml-to-json-converter.xsl'"/>
   
   <!-- is there a better way to annotate a directory list with full paths?
        or: make a step out of this and import it -->
   <!--<p:add-attribute match="//c:file" attribute-name="path" attribute-value="{ base-uri(.) }"/>-->
   
   <p:xslt>
      <p:with-input port="stylesheet">
         <p:inline expand-text="false">
            <xsl:stylesheet version="3.0">
               <xsl:mode on-no-match="shallow-copy"/>
               <xsl:template match="c:file">
                  <xsl:copy>
                     <xsl:copy-of select="@*"/>
                     <xsl:attribute name="path" select="(string-join(ancestor-or-self::c:*/@name,'/')) => resolve-uri()"/>
                  </xsl:copy>
               </xsl:template>
            </xsl:stylesheet>
         </p:inline>
      </p:with-input>
   </p:xslt>
   
   <p:add-attribute match="c:file" attribute-name="target" attribute-value="replace(/*/@path.,'data/','out/') => replace('xml','json')"/>
   
   <p:for-each>
      <p:variable name="base" select="base-uri(.)"/>
      <p:variable name="json-file" select="/*/@target"/>

      <p:xslt>
         <p:with-input port="stylesheet" href="{$converter-xslt}"/>
         <p:with-option name="parameters" select="map{'json-indent': 'yes'}"/>
      </p:xslt>
      
      <p:identity message="[CONVERT-XML-DATA] [CONVERT-XML-REFERENCE-SET] Writing JSON file {$json-file} --"/>
      <!--<p:store href="{$json-file}" message="[CONVERT-XML-REFERENCE-SET] Writing JSON file {$json-file} -\-"/>-->      
   </p:for-each>
   
</p:declare-step>