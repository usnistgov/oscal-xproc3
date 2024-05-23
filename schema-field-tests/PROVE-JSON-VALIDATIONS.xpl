<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:PROVE-JSON-VALIDATIONS"
   name="PROVE-JSON-VALIDATIONS">

<!-- An XProc 3 pipeline providing batch validation of JSON inputs
            
     emulates the parallel XSD pipeline XSD-VALIDATE-CHOICES.xpl-->
   
   <p:input port="json-samples" sequence="true">
      <p:document href="reference-sets/catalog-model/json/fully-valid/minimal.json"/>
      <p:document href="reference-sets/catalog-model/json/fully-valid/okay-catalog.json"/>
      <p:document href="reference-sets/catalog-model/json/fully-valid/some-backmatter.json"/>
      <p:document href="reference-sets/catalog-model/json/fully-valid/some-parameters.json"/>
      
      <p:document href="reference-sets/catalog-model/json/schema-invalid/control-group-mixing.json"/>
      <p:document href="reference-sets/catalog-model/json/schema-invalid/broken-date.json"/>
   </p:input>
   
   <p:output port="result"  serialization="map{'indent' : true()}"/>
   
   <p:variable name="schema-path" select="'lib/oscal-schemas/oscal_catalog_schema.json'"/>
   
   <p:for-each>
      <p:try>
         <p:group name="validation">
            <p:validate-with-json-schema assert-valid="true">
               <p:with-input port="schema" href="{$schema-path}"/>
            </p:validate-with-json-schema>
   
            <p:cast-content-type content-type="application/xml"/>
   
            <p:add-xml-base/>
            <p:add-attribute attribute-name="SCHEMA-VALIDATION-STATUS" match="/*" attribute-value="VALID"/>
            
         </p:group>
         <p:catch>
            <p:add-attribute attribute-name="SCHEMA-VALIDATION-STATUS" match="/*" attribute-value="INVALID"/>
         </p:catch>
      </p:try>
      
      <p:add-attribute attribute-name="VALIDATION-MODE" match="/*" attribute-value="JSON_SCHEMA"/>
      <p:add-attribute attribute-name="SCHEMA" attribute-value="{ $schema-path => resolve-uri() }"/>
   </p:for-each>
   
   <p:wrap-sequence name="wrapup" wrapper="ALL-REPORTS"/>
   
   <p:xslt name="assessment" message="[PROVE-JSON-VALIDATIONS] Assessing ...">
      <p:with-input port="stylesheet" href="src/validation-screener.xsl"/>
   </p:xslt>
   
   <p:xslt name="summary" message="[PROVE-JSON-VALIDATIONS] Summarizing ...">
      <p:with-input port="stylesheet" href="src/validation-summarizer.xsl"/>
   </p:xslt>
   
   <p:xslt name="plaintext">
      <!-- emits a text brick, no elements -->
      <p:with-input port="stylesheet" href="src/summary-plaintext.xsl"/>
   </p:xslt>
   
   <p:cast-content-type content-type="text/plain"/>
   
   <p:identity name="final"/>
   
</p:declare-step>

