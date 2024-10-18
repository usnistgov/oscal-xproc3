<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   type="ox:BATCH_XML-TO-JSON"
   name="BATCH_XML-TO-JSON">

   
   <!-- This pipeline most likely produces an error since XML can't cast 'blank' into JSON, with no mapping
        It *happens* to work on inputs given in the XPath vocabulary ('map') for object notations
   in namespace http://www.w3.org/2005/xpath-functions -->
   
   <p:import href="src/single_xml-to-json.xpl"/>
   
   <p:input port="source" sequence="true">
      <p:document href="data/misc/xml/hello.xml"/>
      <p:document href="data/misc/xml/mixed.xml"/>
   </p:input>

   <!--<p:output port="result" sequence="true"/>-->
   
   <p:for-each>
      <p:variable name="json-file" select="replace(base-uri(.),'\.xml$','') || '.json'"/>
   
      <p:choose>
         <!-- a real test would validate against a schema ... we only look at the namespace at the root -->
         <p:when test="ends-with(base-uri(.),'xml') => not()">
            <p:error code="ox:renaming-failsafe">
               <p:with-input port="source">
                  <message>Can't convert { base-uri(.) } to JSON - we need the filename to end in 'xml' to make a safe name for the result</message>
               </p:with-input>
            </p:error>
         </p:when>
         <p:otherwise>
            <!-- included pipeline has a try/catch -->
            <ox:single_xml-to-json/>
            
            <!--<p:identity message="[BASIC_XML-TO-JSON] Writing JSON file {$json-file} -\-"/>-->
            <p:store href="{$json-file}" message="[BATCH_XML-TO-JSON] Writing JSON file {$json-file} --"/>
         </p:otherwise>
      </p:choose>
      <p:sink/>
   </p:for-each>
   
</p:declare-step>