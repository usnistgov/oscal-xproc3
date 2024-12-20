<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   type="ox:CONVERT-OSCAL-XML-DATA"
   name="CONVERT-OSCAL-XML-DATA">
   
   <!-- Note: requires XSLT at $converter-xslt (provided by ../../GRAB-OSCAL.xpl) -->
   
   <!-- We'll try any content-type -->
   <p:input port="source" sequence="true">
      <p:document href="data/catalog-model/xml/cat_catalog.xml"/>
   </p:input>

   <p:variable name="converter-xslt" select="'lib/oscal_catalog_xml-to-json-converter.xsl'"/>
   
   <p:for-each>
      <p:variable name="content-type" select="p:document-property(.,'content-type')"/>
      <p:variable name="filepath" select="p:document-property(.,'base-uri')"/>
      
      <p:choose>
         <p:when test="not($content-type='application/xml')">
            <p:error code="ox:source-validation-fail">
               <p:with-input>
                  <message>Input file { $filepath } has content type '{ $content-type }' so it fails XML to JSON conversion</message>
               </p:with-input>
            </p:error>
         </p:when>
         <!-- a real test might validate against a schema ... we only look at the document element
              for name and namespace -->
         <p:when test="empty(/oscal:catalog)" xmlns:oscal="http://csrc.nist.gov/ns/oscal/1.0">
            <p:error code="ox:source-validation-fail">
               <p:with-input>
                  <message>XML at file { $filepath } is not an OSCAL catalog ... not attempting conversion</message>
               </p:with-input>
            </p:error>
         </p:when>
         <p:otherwise>
            <!-- Writing the new name a little defensively, so it appends '.json' no matter what --> 
            <p:variable name="json-file"  select="replace($filepath,'\.xml$','') || '.json'"/>
            
            <p:xslt>
               <p:with-input port="stylesheet" href="{$converter-xslt}"/>
               <p:with-option name="parameters" select="map{'json-indent': 'yes'}"/>
            </p:xslt>
            
            <!--<p:identity message="[CONVERT-OSCAL-XML-DATA] Writing JSON file {$json-file} -\-"/>-->
            <p:store href="{$json-file}" message="[CONVERT-OSCAL-XML-DATA] writing JSON file {$json-file} --"/>  
         </p:otherwise>
      </p:choose>          
   </p:for-each>
   
</p:declare-step>