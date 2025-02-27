<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" type="ox:VALIDATION-FILESET-READYCHECK"
   xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
name="VALIDATION-FILESET-READYCHECK">

   <!-- For PRE-VALIDATING the validation (House Rules) file set -->

   <!--This XProc echoes Schematron validation findings (failed assertions and successful reports)
       to the console - *without erroring*
       
       Accordingly it does not defend against errors in next steps, for example if resources are not found.
       
       Hence under CI/CD we are now using REPO-FILESET-CHECK.xpl -
         
       Use this pipeline for a hand pre-check
   -->

   <!-- Schematron will alert if either of these point to resources unavailable - this gives early
        diagnosis of one of the most common reasons for failure in the next step -->
   
   <p:input port="source" sequence="true">
      <p:document href="./cicd-fileset_XProc3_HouseRules.xpl"/>   
      <p:document href="./cicd-fileset_XSpec.xpl"/>   
   </p:input>
   
   <p:output serialization="map{ 'method': 'text', 'indent': true() }"/>

   <p:variable name="schematron-path" select="'xproc3-house-rules.sch'"/>

   <p:for-each>
      <p:validate-with-schematron assert-valid="false" name="fileset-validate"
         message="[VALIDATION-FILESET-READYCHECK] Attempting to validate { base-uri(/*) } against { $schematron-path }">
         <p:with-input port="schema" href="{$schematron-path}"/>
      </p:validate-with-schematron>
      <p:filter select="//svrl:failed-assert/svrl:text | //svrl:successful-report/svrl:text" >
         <p:with-input pipe="report@fileset-validate"/>
      </p:filter>
   </p:for-each>

   <p:wrap-sequence wrapper="report"/>
   
   <p:string-replace match="svrl:text" replace="'[[--- HOUSE RULES FAIL ---]] ' || string(.)"/>      
   
   <p:identity name="final" message="[VALIDATION-FILESET-READYCHECK] Validation run complete: file sets all checked"/>

</p:declare-step>

