<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" type="ox:CONTENT-TYPE_worksheet" name="CONTENT-TYPE_worksheet"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   >

<!-- Worksheet for trying content-type settings.
   
     Use p:cast-content-type to try casting, to see what happens
     Demo also shows:
       How to provide JSON inline and populate its values dynamically
       How to query XDM maps
       How to bind a function to a variable
       
   -->

<!-- XProc Specification on content types: https://spec.xproc.org/master/head/xproc/#specified-content-types-->
   
   <!-- Try things out by hiding code in comments until wanted ... -->
   <p:input port="source">
       <!--<p:document href="data/misc/json/mixed.json"/>-->
       <!--<p:document href="data/misc/xml/mixed.xml"/>-->
       <!--<p:document href="readme.md" content-type="text/plain"/>-->
       
       <!-- This option lets you put JSON in line - the @content-type forces a parse into an XDM map
            in this case the document's base URI is given as the base URI of the pipeline -->
        <!-- with expand-text='true' TVT (text value template) syntax is ON
        so regular { must be doubled -->
       <p:inline  content-type="application/json" expand-text="true">{{
          "message": "Hello!",
          "TO": "World",
          "stardate": "{ (current-dateTime() - xs:dateTime('2024-11-12T07:44:05.207527900-05:00'))
                         div xs:dayTimeDuration('PT1S') }"
          }}</p:inline>
      <!--<p:inline content-type="application/json">"a string"</p:inline>-->
      <!-- we have to see to it the string is JSON, or breakage -->
      <!--<p:inline content-type="application/json">{  }</p:inline>-->
   </p:input>
   
   <p:output port="result" serialization="map{ 'indent': true() }" sequence="true"/>

   <!-- /end prologue -->
   
   <p:variable name="ox:document-info" as="function(*)"  
      select="function($d as item()) as xs:string { p:document-property($d,'content-type') || ' at ' || p:document-property($d,'base-uri') }"/>
   
   <!--Use identity step to report out properties ... -->
   <!--<p:identity message="[CONTENT-TYPE_worksheet] Seeing document at base uri { p:document-property(.,'base-uri') }"/>
   <p:identity message="[CONTENT-TYPE_worksheet] Looking like content type { p:document-property(.,'content-type') }"/>-->
   
   <!--<p:identity message="[CONTENT-TYPE_worksheet] Seeing '{ p:document-property(.,'content-type') }' at base uri { p:document-property(.,'base-uri') }"/>-->
   <p:identity message="[CONTENT-TYPE_worksheet] Seeing { $ox:document-info(.) }"/>
   
   <!-- An XDM map object is cast into an XPath map (vocabulary) -->
   <p:cast-content-type content-type="application/xml"/>
   
   <p:identity message="[CONTENT-TYPE_worksheet] Seeing { $ox:document-info(.) }"/>
      
   <!--Interesting when we convert JSON to plain text, we get JSON syntax, i.e. serialized,
       while now the output serialization setting has no effect (since it's text) -->
   <!--<p:cast-content-type content-type="text/plain"/>-->
   
</p:declare-step>