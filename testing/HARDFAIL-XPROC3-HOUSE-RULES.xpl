<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:HARDFAIL-XPROC3-HOUSE-RULES"
   name="HARDFAIL-XPROC3-HOUSE-RULES"
   >

   <!-- Note: this version of BATCH-XPROC3-HOUSE-RULES.xpl will CRASH HARD if it tries
        to validate a file that delivers errors -
   
   caution - this includes Schematron WARNING and INFO level messages. -->
   
   
   <p:input port="source" sequence="true">
      <p:document href="REPO-XPROC3-HOUSE-RULES.xpl"/>
      <p:document href="BATCH-XPROC3-HOUSE-RULES.xpl"/>
      <p:document href="HARDFAIL-XPROC3-HOUSE-RULES.xpl"/>
   </p:input>
   
   <p:variable name="schematron-path" select="'xproc3-house-rules.sch'"/>
   
   <p:for-each>
      <p:validate-with-schematron assert-valid="true"
         message="[HARDFAIL-XPROC3-HOUSE-RULES] Validating { base-uri(/) } against { $schematron-path }">
         <p:with-input port="schema" href="{$schematron-path}"/>
      </p:validate-with-schematron>
      <p:sink/>
   </p:for-each>
   
</p:declare-step>

