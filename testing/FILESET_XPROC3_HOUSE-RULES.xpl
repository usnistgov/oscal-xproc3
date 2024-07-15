<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:FILESET_XPROC3_HOUSE-RULES"
   name="FILESET_XPROC3_HOUSE-RULES"
   >

   <!-- Pipeline to be called as subpipeline, delivering a list of XProcs -->
   
   <p:documentation>Defining a set of files for Schematron (House Rules) evaluation, or other use. Listing any and all files in the repository subject to these Schematron tests under CI/CD.</p:documentation>
      
   <p:input port="source" sequence="true">
      <p:document href="../lib/GRAB-SAXON.xpl"/>
      <p:document href="../lib/GRAB-SCHXSLT.xpl"/>
      <p:document href="../lib/GRAB-XSPEC.xpl"/>
      
      <p:document href="RUN_XSPEC_BATCH.xpl"/>
      <p:document href="RUN_XSPEC-JUNIT_BATCH.xpl"/>
      <p:document href="RUN_XPROC3-HOUSE-RULES_BATCH.xpl"/>
      <p:document href="HARDFAIL-XPROC3-HOUSE-RULES.xpl"/>
      <p:document href="REPO-XPROC3-HOUSE-RULES.xpl"/>
      <p:document href="FILESET_XPROC3_HOUSE-RULES.xpl"/>
      <p:document href="FILESET_XSPEC.xpl"/>

      <p:document href="../template/GRAB-RESOURCES.xpl"/>

      <p:document href="../schema-field-tests/reference-sets/catalog-model/CONVERT-XML-REFERENCE-SET.xpl"/>
      <p:document href="../schema-field-tests/GRAB-OSCAL-CLI.xpl"/>
      <p:document href="../schema-field-tests/GRAB-OSCAL.xpl"/>
      <p:document href="../schema-field-tests/PROVE-JSON-VALIDATIONS.xpl"/>
      <p:document href="../schema-field-tests/PROVE-XSD-VALIDATIONS.xpl"/>

      <p:document href="../xproc-doc/COLLECT-XPROC-STEPS.xpl"/>
      <p:document href="../xproc-doc/XPROC-STEP-INDEX-HTML.xpl"/>
      <p:document href="../xproc-doc/REPOSITORY-STEP-INDEX-HTML.xpl"/>
      
      <p:document href="../tutorial/GRAB-RESOURCES.xpl"/>
      <p:document href="../tutorial/PRODUCE-TUTORIAL-MARKDOWN.xpl"/>
      <p:document href="../tutorial/PRODUCE-TUTORIAL-PREVIEW.xpl"/>
      
      <p:document href="../smoketest/POWER-UP.xpl"/>
      <p:document href="../smoketest/SMOKETEST-SCHEMATRON.xpl"/>
      <p:document href="../smoketest/SMOKETEST-XSLT.xpl"/>
      <p:document href="../smoketest/SMOKETEST-XSPEC.xpl"/>

      <p:document href="../xspec/xspec-execute.xpl"/>
      
      <p:document href="../oscal-publish/setup/GRAB-OSCAL-CATALOG-SCHEMA.xpl"/>
      <p:document href="../oscal-publish/setup/GRAB-OSCAL-XSLT.xpl"/>
      <p:document href="../oscal-publish/publish-oscal-catalog.xpl"/>
      
      <p:document href="../profile-resolution/setup/ACQUIRE-OSCAL-DATA.xpl"/>
      <p:document href="../profile-resolution/setup/GRAB-PROFILE-RESOLVER-XSLT.xpl"/>
      <p:document href="../profile-resolution/src/apply-profile-resolver.xpl"/>
      <p:document href="../profile-resolution/src/apply-profile-resolver-stepwise.xpl"/>
      <p:document href="../profile-resolution/src/apply-profile-resolver-remotely.xpl"/>
      <p:document href="../profile-resolution/RESOLVE-FISMA-PROFILES.xpl"/>
      <p:document href="../profile-resolution/RESOLVE-KITTEN-CONTROLS.xpl"/>
      <p:document href="../profile-resolution/resolve-profile-and-save.xpl"/>
   </p:input>
 
   <p:output port="xproc-files" sequence="true"/>
   
   <p:identity/>
   
</p:declare-step>
