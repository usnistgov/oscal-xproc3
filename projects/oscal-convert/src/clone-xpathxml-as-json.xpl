<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:clone-xpathxml-as-json" name="clone-xpathxml-as-json">

   <!-- 
      This pipeline produces an XML file for any provided JSON 
      Writing the JSON next to the source file with a name $basename.json 
      Defending if the input is already named this way (to avoid stepping on it)
      Not defending against casting errors - we let XProc do that -->

   <p:import href="single_xml-to-json.xpl"/>
      
   <p:input port="source">
      <!--<p:document href="data/misc/json/hello.json"/>-->
      <p:document href="../data/misc/xml/hello.xml"/>
   </p:input>

   <!-- Result is XML with base-uri as modified, or an error  -->
   <!--<p:output port="result" serialization="map { 'indent': true() }"/>-->

   <!-- /prologue -->

   <p:variable name="filepath" select="p:document-property(.,'base-uri')"/>
   
   <p:variable name="filename" select="replace($filepath,'.*/','')"/>
   <p:variable name="suffix"   select="tokenize($filename,'\.')[last()]"/>
   <p:variable name="newpath"  select="replace($filepath,'\.xml$','.json')"/>
   
   <p:choose>
      <!-- Not defending if content-type is not xml - we'll do our best anyhow -->
      <p:when test="not($suffix = 'xml')">
         <p:error code="ox:filename-collision">
            <p:with-input>
               <message>Refusing to overwrite { $filename } with { replace($newpath,'.*/','') } - we expect a file name matching *.xml</message>
            </p:with-input>
         </p:error>
      </p:when>
      <p:otherwise>
         <ox:single_xml-to-json/>
         <p:store href="{$newpath}" message="[clone-xpathxml-as-json] Saving { $newpath }"/>
      </p:otherwise>
   </p:choose>
 
</p:declare-step>