<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   type="ox:single_json-to-xml" name="single_json-to-xml">

   <!-- Errors if we don't see JSON -->
   <p:input port="source" content-types="application/json"/>
      <!--<p:document href="../data/misc/json/hello.json"/>
   </p:input>-->

   <p:output port="result" serialization="map { 'indent': true() }"/>

   <!-- /prologue  -->
   <!-- INCIPIT  -->
   
   <p:cast-content-type content-type="application/xml"/>
   
</p:declare-step>