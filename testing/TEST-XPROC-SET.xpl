<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:TEST-XPROC-SET"
   name="TEST-XPROC-SET"
   >

   <!-- Pipeline to be called as subpipeline, delivering a list of XProcs -->
   
   <p:input port="source" sequence="true">
      <p:document href="../lib/GRAB-SAXON.xpl"/>
      <p:document href="../lib/GRAB-SCHXSLT.xpl"/>
      
      <p:document href="BATCH-XPROC3-HOUSE-RULES.xpl"/>
      <p:document href="HARDFAIL-XPROC3-HOUSE-RULES.xpl"/>
      <p:document href="REPO-XPROC3-HOUSE-RULES.xpl"/>
      <p:document href="../schema-field-tests/reference-sets/catalog-model/CONVERT-XML-REFERENCE-SET.xpl"/> 
      <p:document href="../schema-field-tests/GRAB-OSCAL-CLI.xpl"/>
      <p:document href="../schema-field-tests/GRAB-OSCAL.xpl"/>
      <p:document href="../schema-field-tests/PROVE-JSON-VALIDATIONS.xpl"/>
      <p:document href="../schema-field-tests/PROVE-XSD-VALIDATIONS.xpl"/>
      <p:document href="../smoketest/POWER-UP.xpl"/>
      <p:document href="../smoketest/SMOKETEST-SCHEMATRON.xpl"/>
      <p:document href="../smoketest/SMOKETEST-XSLT.xpl"/>
   </p:input>
 
   <p:output port="xproc-files" sequence="true"/>
   
   <p:identity/>
   
</p:declare-step>
