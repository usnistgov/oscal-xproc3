<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:BATCH-XPROC3-HOUSE-RULES"
   name="BATCH-XPROC3-HOUSE-RULES"
   >

   <!-- Note: this doesn't run without an available copy of SchXSLT -
        to be set up in ../lib -->
   
   <p:input port="xproc-files" sequence="true">
      <p:document href="REPO-XPROC3-HOUSE-RULES.xpl"/>
      <p:document href="BATCH-XPROC3-HOUSE-RULES.xpl"/>
   </p:input>
   
   <p:output port="result"  serialization="map{'indent' : true()}"/>

   <p:variable name="schematron-path" select="'xproc3-house-rules.sch'"/>
   
   <p:for-each>
      <!-- Remember that each input node is a root for its own tree - hence XPath context -->
      <p:try>
         <p:group name="validation">
            <p:variable name="base" select="base-uri(/*)"/>
            <!-- assert-valid='true' presents c:errors results when validation fails as 'no failed assertions or successful reports' -->
            <p:validate-with-schematron assert-valid="true"  message="[BATCH-XPROC3-HOUSE-RULES] Validating { $base } against { $schematron-path }">
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
      
   <p:xslt name="assessment" message="[BATCH-XPROC3-HOUSE-RULES] Assessing ...">
      <p:with-input port="stylesheet" href="src/validation-screener.xsl"/>
   </p:xslt>
   
   <p:xslt name="summary" message="[BATCH-XPROC3-HOUSE-RULES] Summarizing ...">
      <p:with-input port="stylesheet" href="src/validation-summarizer.xsl"/>
   </p:xslt>
   
   <p:xslt name="plaintext">
      <!-- emits a text brick, no elements  -->
      <p:with-input port="stylesheet" href="src/summary-plaintext.xsl"/>
   </p:xslt>
   
   <p:identity name="final"/>

</p:declare-step>

