<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:HARDFAIL-XPROC3-HOUSE-RULES"
   name="HARDFAIL-XPROC3-HOUSE-RULES"
   >

   <!-- Note: this version of BATCH-XPROC3-HOUSE-RULES.xpl will CRASH HARD
        whenever any file it calls delivers errors on the given Schematron check -
   
        caution - this includes Schematron WARNING and INFO level messages -->
   
   <p:import href="cicd-fileset_XProc3_HouseRules.xpl"/>
   
   <p:variable name="schematron-path" select="'xproc3-house-rules.sch'"/>
   
   <ox:cicd-fileset_XProc3_HouseRules name="test-set"/>
   
   <p:for-each>
      <p:with-input pipe="xproc-files@test-set"/>
      <p:validate-with-schematron assert-valid="true"
         message="[HARDFAIL-XPROC3-HOUSE-RULES] Validating { base-uri(/) } against { $schematron-path }">
         <p:with-input port="schema" href="{$schematron-path}"/>
      </p:validate-with-schematron>
      <p:sink/>
   </p:for-each>
   
   <!-- If we manage to get this far we have succeeded - no result is called for -->
   
</p:declare-step>

