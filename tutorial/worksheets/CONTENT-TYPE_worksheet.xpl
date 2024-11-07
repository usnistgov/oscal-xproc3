<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" type="ox:CONTENT-TYPE_worksheet" name="CONTENT-TYPE_worksheet">

<!-- Worksheet for trying content-type settings. -->

<!-- XProc Specification on content types: https://spec.xproc.org/master/head/xproc/#specified-content-types-->
   
   <!-- Try things out by hiding code in comments until wanted ... -->
   <p:input port="source">
       <!--<p:document href="data/misc/json/mixed.json"/>-->
       <!--<p:document href="data/misc/xml/mixed.xml"/>-->
       <!--<p:document href="readme.md" content-type="text/plain"/>-->
       
       <!-- This option lets you put JSON in line - the @content-type forces a parse into an XDM map
            in this case the document's base URI is given as the base URI of the pipeline -->
       <!--<p:inline  content-type="application/json" expand-text="false">{
          "message": "Hello!",
          "TO": "World"
          }</p:inline>-->
      <!--<p:inline content-type="application/json">"a string"</p:inline>-->
      <!-- we have to see to it the string is JSON, or breakage -->
      <p:inline content-type="application/json">{ current-date() ! replace(string(.),'\D','') }</p:inline>
   </p:input>
   
   <p:output port="result" serialization="map{ 'indent': true() }" sequence="true"/>

   <!-- /end prologue -->

   <!--Use identity step to report out properties ... -->
   <p:identity message="[CONTENT-TYPE_worksheet] Seeing document at base uri { p:document-property(.,'base-uri') }"/>
   <p:identity message="[CONTENT-TYPE_worksheet] Looking like content type { p:document-property(.,'content-type') }"/>
   
   
   <!-- An XDM map object is cast into an XPath map (vocabulary) -->
   <!--<p:cast-content-type content-type="application/xml"/>-->
   
   <!--<p:cast-content-type content-type="application/json"/>-->
   
   <!--Interesting when we convert JSON to plain text, we get JSON syntax, but output serialization setting has no effect  -->
   <!--<p:cast-content-type content-type="text/plain"/>-->
   
</p:declare-step>