<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   type="ox:BASIC_JSON-TO-XML"
   name="BASIC_JSON-TO-XML">
   
   <!-- This pipeline produces an error since XML can't cast 'blank' into JSON, with no mapping -->
   
   <p:documentation>HOUSE RULES HALL PASS - add this file to ../../testing/FILESET_XPROC3_HOUSE-RULES.xpl and remove this element</p:documentation>
   
   <!-- Note: requires XSLT at $converter-xslt (provided by ../../GRAB-OSCAL.xpl) -->
   
   <p:input port="source" sequence="true">
      <p:document href="data/misc/json/hello.json"/>
      <p:document href="data/misc/json/mixed.json"/>
   </p:input>

   <p:for-each>
      <!-- plain base-uri(.) doesn't work since the JSON is not a node -->
      <p:variable name="filename" select="p:document-property(.,'base-uri')"/>
      <p:variable name="xml-file" select="replace($filename,'json$','xml')"/>
      
      <!-- A generic conversion presents the JSON data in XML syntax using the XPath vocabulary -->
      <p:cast-content-type content-type="application/xml"/>
      
      <!--<p:identity message="[BASIC_JSON-TO-XML] Writing XML file {$json-file} -\-"/>-->
      <p:store href="{$xml-file}" message="[BASIC_JSON-TO-XML] writing XML file {$xml-file} --" serialization="map{ 'indent': true() }"/>      
   </p:for-each>
   
</p:declare-step>