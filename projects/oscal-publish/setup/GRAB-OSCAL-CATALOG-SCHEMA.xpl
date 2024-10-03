<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   type="ox:GRAB-OSCAL-CATALOG-SCHEMA"
   name="GRAB-OSCAL-CATALOG-SCHEMA">

<!--

Since the OSCAL Schema files are directly addressable as resources over the Internet
(thank you AJS, NW, CC) we simple pull them straight in, no load ...-->
  
   <p:variable name="download-path" select="'https://github.com/usnistgov/OSCAL/releases/download/v1.1.2'"/>
   
   <p:variable name="destination" select="resolve-uri('../lib')"/><!-- by default, evaluating relative to static-base-uri() -->

   <p:variable name="prefix" select="'[' || 'GRAB-OSCAL-CATALOG-SCHEMA' || ']'"/>
   
   <!-- Commence steps -->
      
   <p:for-each>
      <p:with-input>
         <p:document content-type="text/xml" href="{$download-path}/oscal_catalog_schema.xsd"/>
      </p:with-input>         
      <p:variable name="basename" select="/*/base-uri() => replace('.+/','')"/>

      <p:store href="{ $destination }/{ $basename }" message="{$prefix} Saving { $destination }/{ $basename }"/>
   </p:for-each>

</p:declare-step>