<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:cx="http://xmlcalabash.com/ns/extensions"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xslt"
   type="ox:XSD-VALIDATION-PROOFS"
   name="XSD-VALIDATION-PROOFS"
   >

  <!-- Purpose: An XProc 3 pipeline providing batch validation of XML inputs against an XSD -->
   
   <!-- Inputs are hard-wired for now -->
   <p:input port="xml-samples" sequence="true">
      <!-- The processor expects files to be valid or invalid according to logic given in the filter stylesheet src/common/validation-screener.xsl -->
      
      <p:document href="reference-sets/catalog-model/xml/fully-valid/minimal.xml"/>
      <p:document href="reference-sets/catalog-model/xml/fully-valid/okay-catalog.xml"/>
      <p:document href="reference-sets/catalog-model/xml/fully-valid/some-backmatter.xml"/>
      <p:document href="reference-sets/catalog-model/xml/fully-valid/some-parameters.xml"/>
      
      <p:document href="reference-sets/catalog-model/xml/schema-invalid/broken-date.xml"/>
      <p:document href="reference-sets/catalog-model/xml/schema-invalid/not-okay-catalog.xml"/>
   </p:input>
   
   <p:output port="result"  serialization="map{'indent' : true()}"/>
      
<!--    
   
   GOGOGOGOGOGOGOGOGOGOGOGOGOGOGOGOGOGOGOGOGOGOGOGOGOGOGOGOGOGOGOGOGOGOGOGO
   -->
      
   <!--<p:variable name="base" select="base-uri(/*)"/>-->

   <p:variable name="schema-path" select="'lib/oscal-schemas/oscal_catalog_schema.xsd'"/>
   
   <p:for-each>
      <p:try>
         <p:group name="validation">
            <p:variable name="base" select="base-uri(/*)"/>
            <p:validate-with-xml-schema assert-valid="true">
               <p:with-input port="schema" href="{$schema-path}"/>
            </p:validate-with-xml-schema>
            
            <p:add-attribute attribute-name="baseURI" attribute-value="{$base}"/>
            <p:add-attribute attribute-name="SCHEMA-VALIDATION-STATUS" match="/*" attribute-value="VALID"/>
            
         </p:group>
         <p:catch>
            <p:add-attribute attribute-name="SCHEMA-VALIDATION-STATUS" match="/*" attribute-value="INVALID"/>
         </p:catch>
      </p:try>
      <p:add-attribute attribute-name="VALIDATION-MODE" match="/*" attribute-value="XSD"/>
      <p:add-attribute attribute-name="SCHEMA" attribute-value="{ $schema-path => resolve-uri() }"/>
   </p:for-each>

   <p:wrap-sequence name="wrapup" wrapper="ALL-REPORTS"/>
   
   <p:xslt name="assessment" message="[PROVE-XSD-VALIDATIONS] Assessing ...">
      <p:with-input port="stylesheet" href="src/common/validation-screener.xsl"/>
   </p:xslt>
   
   <p:xslt name="summary" message="[PROVE-XSD-VALIDATIONS] Summarizing ...">
      <p:with-input port="stylesheet" href="src/common/validation-summarizer.xsl"/>
   </p:xslt>
   
   <p:xslt name="plaintext">
      <!-- emits a text brick, no elements -->
      <p:with-input port="stylesheet" href="src/common/summary-plaintext.xsl"/>
   </p:xslt>
   
   <p:cast-content-type content-type="text/plain"/>
   
   <p:identity name="final"/>
   
</p:declare-step>

