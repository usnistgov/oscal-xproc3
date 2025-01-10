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
        
      <!-- with expand-text='true' TVT (text value template) syntax is ON  for function evaluation
           so regular { must be doubled as {{ -->
       <p:inline content-type="application/json" expand-text="true">{{
          "message": "Hello!",
          "TO": "World",
          "stardate": "{ (current-dateTime() - xs:dateTime('1970-01-01T00:00:00-00:00'))
                         div xs:dayTimeDuration('PT1S') }"
          }}</p:inline>
      
   </p:input>
   
   <p:output port="result" serialization="map{ 'indent': true() }" sequence="true"/>

   <!-- /end prologue -->
   
   <p:declare-step name="report-status" type="ox:report-status">
      <p:input port="source"/>
      <p:output port="result"/>
      <p:identity message="[STATUS REPORT] SEEING '{ p:document-property(.,'content-type') }' AT { p:document-property(.,'base-uri') }"/>
   </p:declare-step>
   
   <!-- Check out how we can query the map -->
   <p:identity message="STARDATE { .?stardate }"/>
   
   <ox:report-status/>
   
   <!-- An XDM map object is cast into an XPath map (vocabulary) -->
   <p:cast-content-type content-type="application/xml"/>
      
   <ox:report-status/>
      <!--To provide for tagging to be stripped in content conversion, we set the serializatioin property-->
   
   <!-- Stripping tagging? https://xprocref.org/3.0/p.cast-content-type.html
     <p:set-properties properties="map{'serialization': map{ 'method': 'text', 'omit-xml-declaration': true() } }"/>
     <p:cast-content-type content-type="text/plain"/>
   -->
   
   <!-- As an alternative to the preceding, this will cast the content type implicitly, b/c the tree is no longer a rooted node -->
   <p:string-replace match="/*" replace="string(.)"/>
   
   <!--<p:set-properties properties="map{'base-uri': resolve-uri('test.txt') }"/>-->
   
   <ox:report-status/>
   
</p:declare-step>