<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   type="ox:CONVERT-OSCAL-XML-DATA"
   name="CONVERT-OSCAL-XML-DATA">
   
   <!-- Note: requires XSLT at $converter-xslt (provided by ../../GRAB-OSCAL.xpl) -->
   
   <p:input port="source" sequence="true">
      <p:document href="data/catalog-model/xml/cat_catalog.xml"/>
   </p:input>

   <p:variable name="converter-xslt" select="'lib/oscal_catalog_xml-to-json-converter.xsl'"/>
   
   <p:for-each>
      <p:variable name="base" select="base-uri(.)"/>
      <p:variable name="json-file" select="replace($base,'data/','out/') => replace('xml','json')"/>
      <p:xslt>
         <p:with-input port="stylesheet" href="{$converter-xslt}"/>
         <p:with-option name="parameters" select="map{'json-indent': 'yes'}"/>
      </p:xslt>
      
      <!--<p:identity message="[CONVERT-OSCAL-XML-DATA] Writing JSON file {$json-file} -\-"/>-->
      <p:store href="{$json-file}" message="[CONVERT-OSCAL-XML-DATA] writing JSON file {$json-file} --"/>      
   </p:for-each>
   
</p:declare-step>