<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" type="ox:READ-JSON-TESTING" name="READ-JSON-TESTING">


   
   <p:input port="source">
         <p:inline  content-type="application/json" expand-text="false">{
            "message": "Hello!",
            "TO": "World"
            }</p:inline>
   </p:input>
   
   <p:output port="result" serialization="map{ 'indent': true(), 'omit-xml-declaration': true() }" sequence="true"/>

   <!-- /end prologue -->

   <!-- or loading data here -->
   <!--<p:load name="json-in" message="[READ-JSON-TESTING] p:load: data/misc/json/mixed.json ..."
           href="../../projects/oscal-convert/data/misc/json/mixed.json"/>-->
   
   <!-- A JSON document is loaded; the variable gives us a way to reference it -->
   
   <p:variable name="json-map" select="."/>
   
   <!--
   json-map being an XDM map object, we can use XPath on it
     alternatives to retrieve its 'message' property:
     $json-map?message
     $json-map('message')
     map:get($json-map,'message') where map is ns http://www.w3.org/2005/xpath-functions/map
     
     More on XDM maps:
     
     https://www.w3.org/TR/xpath-31/#id-maps
     https://www.w3.org/TR/xpath-functions-31/#map-functions
   -->
   
   <p:variable name="target" select="$json-map?message"/>
   <!--<p:variable name="target" select="map:get($json-map,'message')" xmlns:map="http://www.w3.org/2005/xpath-functions/map"/>-->
   
   
   <!--Alteratively, skip the p:load and go straight to (same effect)
   <p:variable name="json-map" select="json-doc('../data/misc/json/mixed.json')"/>
   This demonstrates how either way, we load into an XDM map object
   -->
   
   <p:identity message="[READ-JSON-TESTING] { $target } - { p:document-property(.,'content-type') }">
      <p:with-input select="$target">
         <p:inline/><!-- empty p:inline loads a tree root with nothing -->
      </p:with-input>
   </p:identity>
  
   <!-- Show we get something by casting to XPath vocabulary -->   
   <p:cast-content-type content-type="application/xml"/>
   
</p:declare-step>