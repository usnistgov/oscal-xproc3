<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   type="ox:BASIC-XML-TO-JSON"
   name="BASIC-XML-TO-JSON">
   
   <!-- This pipeline produces an error since XML can't cast 'blank' into JSON, with no mapping -->
   
   <p:documentation>HOUSE RULES HALL PASS - add this file to ../../testing/FILESET_XPROC3_HOUSE-RULES.xpl and remove this element</p:documentation>
   
   <!-- Note: requires XSLT at $converter-xslt (provided by ../../GRAB-OSCAL.xpl) -->
   
   <p:input port="source" sequence="true">
      <p:document href="data/catalog-model/xml/cat_catalog.xml"/>
   </p:input>

   <p:output port="result"/>
   
   <p:variable name="converter-xslt" select="'lib/oscal_catalog_xml-to-json-converter.xsl'"/>
   
   <p:for-each>
      <p:variable name="base" select="base-uri(.)"/>
      <p:variable name="json-file" select="replace($base,'data/','out/') => replace('xml','json')"/>
      
      <p:cast-content-type content-type="application/json"/>
      <!--<p:identity message="[CONVERT-XML-DATA] [CONVERT-XML-REFERENCE-SET] Writing JSON file {$json-file} -\-"/>-->
      <!--<p:store href="{$json-file}" message="[CONVERT-OSCAL-XML-DATA] writing JSON file {$json-file} -\-"/>-->      
   </p:for-each>
   
</p:declare-step>