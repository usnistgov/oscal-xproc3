<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:RUN_XPROC3-HOUSE-RULES_BATCH"
   name="RUN_XPROC3-HOUSE-RULES_BATCH"
   >

   <!-- Note: this doesn't run without an available copy of SchXSLT -
        to be set up in ../lib -->
   
   <p:import href="FILESET_XPROC3_HOUSE-RULES.xpl"/>
   
   <p:output port="result" serialization="map{'indent' : true()}"/>
   
   <p:variable name="schematron-path" select="'xproc3-house-rules.sch'"/>
   
   <ox:FILESET_XPROC3_HOUSE-RULES name="test-set"/>
   
   <p:for-each>
      <p:with-input pipe="xproc-files@test-set"/>
      <!-- Remember that each input node is a root for its own tree - hence XPath context -->
      <p:try>
         <p:group name="validation">
            <p:variable name="base" select="base-uri(/*)"/>
            <!-- assert-valid='true' presents c:errors results when validation fails as 'no failed assertions or successful reports' -->
            <p:validate-with-schematron assert-valid="true" message="[RUN_XPROC3-HOUSE-RULES_BATCH] Validating { $base } against { $schematron-path }">
               <p:with-input port="schema" href="{$schematron-path}"/>
            </p:validate-with-schematron>
            
            <p:add-attribute attribute-name="baseURI" attribute-value="{$base}"/>
            <p:add-attribute attribute-name="SCHEMA-VALIDATION-STATUS" match="/*" attribute-value="VALID"/>
         </p:group>
         <p:catch>
            <p:add-attribute attribute-name="SCHEMA-VALIDATION-STATUS" match="/*" attribute-value="INVALID"/>
         </p:catch>
      </p:try>
      <p:add-attribute attribute-name="VALIDATION-MODE" match="/*" attribute-value="Schematron"/>
      <p:add-attribute attribute-name="SCHEMA" attribute-value="{ $schematron-path => resolve-uri() }"/>
   </p:for-each>
      
   <p:wrap-sequence name="wrapup" wrapper="ALL-REPORTS"/>
      
   <p:xslt name="assessment" message="[RUN_XPROC3-HOUSE-RULES_BATCH] Assessing ...">
      <p:with-input port="stylesheet" href="src/validation-screener.xsl"/>
   </p:xslt>
   
   <p:xslt name="summary" message="[RUN_XPROC3-HOUSE-RULES_BATCH] Summarizing ...">
      <p:with-input port="stylesheet" href="src/validation-summarizer.xsl"/>
   </p:xslt>
   
   <p:xslt name="plaintext">
      <!-- emits a text brick, no elements  -->
      <p:with-input port="stylesheet" href="src/summary-plaintext.xsl"/>
   </p:xslt>
   
</p:declare-step>

