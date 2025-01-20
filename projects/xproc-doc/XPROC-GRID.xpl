<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   type="ox:XPROC-GRID" name="XPROC-GRID">

<p:documentation>HOUSE RULES HALL PASS - add this file to ../../testing/FILESET_XPROC3_HOUSE-RULES.xpl and remove this element</p:documentation>
<p:documentation>
   <p:document href="../projects/xproc-doc/XPROC-GRID.xpl"/>
</p:documentation>


   
   <!--<p:output serialization="map{'indent' : true()}" sequence="true"/>-->
   <!--<p:variable name="step-defs" select="id('req-steps')/xi:include"/>-->

   <!--The pipeline loads specification Docbook XML for XProc dynamically
   and pulls all the step declarations
   
   for indexing and linkbacks
   
   -->

<!-- List test docs here -->
<p:input port="source" sequence="true">
   <p:document content-type="text/xml" href="REPOSITORY-STEP-INDEX-HTML.xpl"/>
   <p:document content-type="text/xml" href="XPROC-STEP-INDEX-HTML.xpl"/>
   <p:document content-type="text/xml" href="../schema-field-tests/PROVE-XSD-VALIDATIONS.xpl"/>
   <p:document content-type="text/xml" href="../FM6-22-import/PRODUCE_FM6-22-chapter4.xpl"/>
   
</p:input>
   
   <p:for-each>
   <p:xslt>
      <p:with-input port="stylesheet" href="src/reduce-xproc.xsl"/>
   </p:xslt>
   
   <p:xslt>
      <p:with-input port="stylesheet" href="src/grid-model-html.xsl"/>
   </p:xslt>
   
   <p:identity message="[XPROC-GRID] seeing { p:document-property(.,'base-uri') } with base-uri { base-uri(/*) }"/>
   <p:variable name="filename" select="p:document-property(.,'base-uri') => tokenize('/') => reverse() => head()"/>
   
   <p:variable name="html-name" select="replace($filename,'\.xpl$','-sketch.html')"/>
   
   <p:store href="sketches/{$html-name}" message="[XPROC-GRID] Saving to sketches/{$html-name}"
   serialization="map{ 'method': 'html' }"/>
   
   </p:for-each>
   
</p:declare-step>