<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:c="http://www.w3.org/ns/xproc-step"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   type="ox:directory-worksheet" name="directory-worksheet">

<p:documentation>HOUSE RULES HALL PASS - add this file to ../../testing/FILESET_XPROC3_HOUSE-RULES.xpl and remove this element</p:documentation>
<p:documentation>
   <p:document href="../tutorial/worksheets/directory-worksheet.xpr"/>
</p:documentation>

<p:output port="result" serialization="map{ 'omit-xml-declaration': true(), 'indent': true() }"/>
   
   <!-- INCIPIT!--> 
   
   <p:directory-list path="." max-depth="unbounded"/>

   <!-- directory list path writing step annotates c:file with full path to resource -->
   <!--<p:label-elements match="c:file" attribute="path" label="ancestor-or-self::*/@xml:base => string-join('')"/>-->
   
   <p:make-absolute-uris match="@xml:base"/>
   
</p:declare-step>