<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   type="ox:GRAB-RESOURCES"
   name="GRAB-RESOURCES">
   
   <p:documentation>Purpose: update local copies of some OSCAL resources from its release repository</p:documentation>
   
   <p:variable name="download-path" select="'https://github.com/usnistgov/OSCAL/releases/download/v1.1.2'"/>
   
   <p:for-each message="[GRAB-RESOURCES] Saving resources in ./lib ...">
      <!-- iterating over each 'resource' as a discrete document node -->
      <p:with-input>
         <p:document href="{$download-path}/oscal_catalog_xml-to-json-converter.xsl"/>
         <p:document href="{$download-path}/oscal_catalog_json-to-xml-converter.xsl"/>
      </p:with-input>
      <p:variable name="filename" select="p:document-property(.,'base-uri') ! replace(.,'.*/','')"/>
      
      <!-- No exception handling since a failed load often produces a result
           making it difficult to anticipate what a failure looks like - -->
      <!-- NB - A Schematron error comes back as soon as this is out of line with /*/@type i.e. the file name
           - starting the @message with { $prefix } silences the error, but please reset $prefix -->
      <p:store message="[GRAB-RESOURCES] ... saving { $filename }"
         href="lib/{ $filename }"  serialization="map{'indent' : true() }"/>
   </p:for-each>
   
</p:declare-step>