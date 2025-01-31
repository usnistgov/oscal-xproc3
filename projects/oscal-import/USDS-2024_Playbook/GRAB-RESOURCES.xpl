<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:GRAB-RESOURCES"
   name="GRAB-RESOURCES">
   

   <!-- Purpose: update local copies of some OSCAL resources from its release repository -->
   
   <p:for-each message="[GRAB-RESOURCES] Saving resources in ./lib ...">
      <!-- iterating over each 'resource' as a discrete document node -->
      <p:with-input>
         <p:document href="{$download-path}/oscal_catalog_schema.xsd"/>
      </p:with-input>
      <p:variable name="filename" select="p:document-property(.,'base-uri') ! replace(.,'.*/','')"/>
      
      <p:store message="[GRAB-RESOURCES] ... saving { $filename }" href="lib/{ $filename }"/>
   </p:for-each>
   
</p:declare-step>