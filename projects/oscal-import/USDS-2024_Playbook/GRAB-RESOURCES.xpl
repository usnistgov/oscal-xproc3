<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:GRAB-RESOURCES"
   name="GRAB-RESOURCES">
   

   <!-- Purpose: update local copies of some OSCAL resources from its release repository -->
   
   <p:variable name="download-path" select="'https://github.com/usnistgov/OSCAL/releases/download/v1.1.2'"/>
   
   <!-- A $prefix is used to tag messages, expected to match the process type -->
   <p:variable name="prefix" select="'[' || 'GRAB-RESOURCES' || ']'"/>
   
   <p:for-each message="{$prefix} Saving resources in ./lib ...">
      <!-- iterating over each 'resource' as a discrete document node -->
      <p:with-input>
         <p:document href="{$download-path}/oscal_catalog_schema.xsd"/>
      </p:with-input>
      <p:variable name="filename" select="p:document-property(.,'base-uri') ! replace(.,'.*/','')"/>
      
      <!-- No exception handling since a failed load often produces a result
           making it difficult to anticipate what a failure looks like - -->
      <!-- NB - A Schematron error comes back as soon as this is out of line with /*/@type i.e. the file name
           - starting the @message with { $prefix } silences the error, but please reset $prefix -->
      
      <p:store message="{$prefix} ... saving { $filename }" href="lib/{ $filename }"/>
   </p:for-each>
   
</p:declare-step>