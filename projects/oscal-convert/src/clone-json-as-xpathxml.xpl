<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   type="ox:clone-json-as-xpathxml" name="clone-json-as-xpathxml">

   <!-- 
      This pipeline produces an XML file for any provided JSON 
      Writing the JSON next to the source file with a name $basename.json 
      Defending if the input is already named this way (to avoid stepping on it)
      Not defending against casting errors - we let XProc do that -->

   <p:documentation>HOUSE RULES HALL PASS - add this file to ../../testing/FILESET_XPROC3_HOUSE-RULES.xpl and remove
      this element</p:documentation>

   <p:import href="single_json-to-xml.xpl"/>
   
   <p:input port="source">
      <p:document href="../data/misc/json/hello.json"/>
   </p:input>

   <!--<p:output port="result" serialization="map { 'indent': true() }"/>-->

   <!-- /prologue -->

   <p:variable name="filepath" select="p:document-property(.,'base-uri')"/>
   
   <p:variable name="filename" select="replace($filepath,'.*/','')"/>
   <p:variable name="suffix"   select="tokenize($filename,'\.')[last()]"/>
   <p:variable name="newpath"  select="replace($filepath,'\.json$','.xml')"/>
   
   <p:choose>
      <!-- Not defending if content-type is not json - we'll do our best anyhow -->
      <p:when test="not($suffix = 'json')">
         <p:error code="ox:filename-collision">
            <p:with-input port="source">
               <message>Refusing to overwrite { $filename } with { replace($newpath,'.*/','') } - we expect a file name matching *.json</message>
            </p:with-input>
         </p:error>
      </p:when>
      <p:otherwise>
         <ox:single_json-to-xml/>
         <p:store href="{$newpath}" message="[clone-json-as-xpathxml] Saving { $newpath }"/>
      </p:otherwise>
   </p:choose>
 
</p:declare-step>