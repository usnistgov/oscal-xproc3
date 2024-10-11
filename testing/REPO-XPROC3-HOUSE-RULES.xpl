<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:REPO-XPROC3-HOUSE-RULES"
   name="REPO-XPROC3-HOUSE-RULES"
   >

   <!-- Note: this doesn't run without an available copy of SchXSLT -
        to be set up in ../lib -->
   
   
   <!-- Purpose: An XProc 3 pipeline providing batch validation of XML inputs against an XSD -->
   
   <!-- Input: a set of files is collected dynamically via p:directory - all *.xpr files outside a directory named 'no_test' or 'no-test' -->
   <p:output port="result"  serialization="map{'indent' : true()}"/>

   <p:variable name="schematron-path" select="'xproc3-house-rules.sch'"/>
   
   <p:directory-list path=".." max-depth="unbounded" include-filter="\.xpl$" exclude-filter=".*no[-_]test.*"/>
   
   <!-- filter directory step flattens everything and excludes files in top-level /lib  -->
   <p:xslt name="file-list">
      <p:with-input port="stylesheet" href="src/filter-directory.xsl"/>
   </p:xslt>
   
   <p:for-each name="files">
      <p:with-input select="descendant::file"/>
      <!-- Remember that each input node is a root for its own tree - hence XPath context -->
      <p:variable name="path" select="/*/@path"/>
      <p:load href="../{$path}" message="[REPO-XPROC3-HOUSE-RULES] Loading { $path }"/>
      <p:try>
         <p:group name="validation">
            <p:variable name="base" select="base-uri(/*)"/>
            <!-- assert-valid='true' presents c:errors results when validation fails as 'no failed assertions or successful reports' -->
            <p:validate-with-schematron assert-valid="true" message="[REPO-XPROC3-HOUSE-RULES] Validating { $path } against { $schematron-path }">
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
      
   <p:xslt name="assessment" message="[REPO-XPROC3-HOUSE-RULES] Assessing ...">
      <p:with-input port="stylesheet" href="src/validation-screener.xsl"/>
   </p:xslt>
   
   <p:xslt name="summary" message="[REPO-XPROC3-HOUSE-RULES] Summarizing ...">
      <p:with-input port="stylesheet" href="src/validation-summarizer.xsl"/>
   </p:xslt>
   
   <p:xslt name="plaintext">
      <!-- emits a text brick, no elements  -->
      <p:with-input port="stylesheet" href="src/summary-plaintext.xsl"/>
   </p:xslt>
   
   <p:identity name="final"/>

</p:declare-step>

