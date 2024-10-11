<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   type="ox:BASIC_XML-TO-JSON"
   name="BASIC_XML-TO-JSON">
   
   <!-- This pipeline produces an error since XML can't cast 'blank' into JSON, with no mapping -->
   
   <p:documentation>HOUSE RULES HALL PASS - add this file to ../../testing/FILESET_XPROC3_HOUSE-RULES.xpl and remove this element</p:documentation>
   
   <!-- Note: requires XSLT at $converter-xslt (provided by ../../GRAB-OSCAL.xpl) -->
   
   <p:input port="source" sequence="true">
      
      <p:document href="data/misc/xml/hello.xml"/>
      <p:document href="data/misc/xml/mixed.xml"/>
   </p:input>

   <!--<p:output port="result" sequence="true"/>-->
   
   <p:variable name="converter-xslt" select="'lib/oscal_catalog_xml-to-json-converter.xsl'"/>
   
   <p:for-each>
      <p:variable name="json-file" select="replace(base-uri(.),'xml$','json')"/>
   
      <p:choose>
         <!-- a real test would validate against a schema ... we only look at the namespace at the root -->
         <p:when test="empty(/xp:*)" xmlns:xp="http://www.w3.org/2005/xpath-functions">
            <p:identity>
               <p:with-input port="source">
                  <SORRY>Can't convert { base-uri(.) } to JSON - expecting input in namespace
                     'http://www.w3.org/2005/xpath-functions'</SORRY>
               </p:with-input>
            </p:identity>
         </p:when>
         <p:when test="ends-with(base-uri(.),'xml') => not()">
            <p:identity>
               <p:with-input port="source">
                  <SORRY>Can't convert { base-uri(.) } to JSON - we need the filename to end in 'xml' to make a safe
                     name for the result</SORRY>
               </p:with-input>
            </p:identity>
         </p:when>
         <p:otherwise>
            <p:cast-content-type content-type="application/json"/>
            
            <!--<p:identity message="[BASIC_XML-TO-JSON] Writing JSON file {$json-file} -\-"/>-->
            <p:store href="{$json-file}" message="[BASIC_XML-TO-JSON] Writing JSON file {$json-file} --"/>
         </p:otherwise>
      </p:choose>
      <p:sink/>
   </p:for-each>
   
</p:declare-step>