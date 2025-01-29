<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:p="http://www.w3.org/ns/xproc" 
   version="3.0">
   
   <p:input port="source" sequence="true">
      <p:inline>
         <doc/>
      </p:inline>
   </p:input>

   <p:output port="result" sequence="true"/>
   
   <p:xslt name="create-secondary-documents-1">
      <p:with-input port="stylesheet" href="spec-split-docs-1.xsl"/>
   </p:xslt>
   
   <p:for-each name="step1-store">
      <p:with-input pipe="secondary@create-secondary-documents-1"/>
      <p:store href="{base-uri(/)}" message="store1: {base-uri(/)}"/>
      <p:identity>
         <p:with-input pipe="result-uri"/>
      </p:identity>
   </p:for-each>
   
   <!-- Iterate over each of the secondary documents from the first xslt step. For each one, run the second xslt. The output of this step is all of the documents on the xslt secondary port -->
   
   <p:for-each>
      <p:with-input pipe="secondary@create-secondary-documents-1"/>
      <p:output port="result" sequence="true"
         pipe="secondary@create-secondary-documents-2"/>
      <p:xslt name="create-secondary-documents-2">
         <p:with-input port="stylesheet" href="spec-split-docs-2.xsl"/>
      </p:xslt>
   </p:for-each>    
   
   <p:for-each name="step2-store">
      <p:store href="{base-uri(/)}" message="store2: {base-uri(/)}"/>
      <p:identity>
         <p:with-input pipe="result-uri"/>
      </p:identity>
   </p:for-each>
   
</p:declare-step>