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
      <p:document href="REPO-FILESET-CHECK.xpl"/>
      <p:document href="VALIDATION-FILESET-READYCHECK.xpl"/>

      <p:document href="../project-template/GRAB-RESOURCES.xpl"/>
      <p:document href="../project-template/MINIMAL.xpl"/>
      
      <p:document href="../projects/schema-field-tests/reference-sets/catalog-model/CONVERT-XML-REFERENCE-SET.xpl"/>
      <p:document href="../projects/schema-field-tests/GRAB-OSCAL-CLI.xpl"/>
      <p:document href="../projects/schema-field-tests/GRAB-OSCAL.xpl"/>
      <p:document href="../projects/schema-field-tests/PROVE-JSON-VALIDATIONS.xpl"/>
      <p:document href="../projects/schema-field-tests/PROVE-XSD-VALIDATIONS.xpl"/>

      <p:document href="../projects/xproc-doc/COLLECT-XPROC-STEPS.xpl"/>
      <p:document href="../projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl"/>
      <p:document href="../projects/xproc-doc/REPOSITORY-STEP-INDEX-HTML.xpl"/>
      <!--<p:document href="../xproc-doc/xproc-paint-html.xpl"/>-->
      
      <p:document href="../tutorial/GRAB-OSCAL-RESOURCES.xpl"/>
      <p:document href="../tutorial/GRAB-XPROC-RESOURCES.xpl"/>
      <p:document href="../tutorial/PRODUCE-TUTORIAL-MARKDOWN.xpl"/>
      <p:document href="../tutorial/SOURCES-PREVIEW.xpl"/>
      <p:document href="../tutorial/PRODUCE-TUTORIAL-TOC.xpl"/>
      
      <p:document href="../smoketest/TEST-XPROC3.xpl"/>
      <p:document href="../smoketest/TEST-SCHEMATRON.xpl"/>
      <p:document href="../smoketest/TEST-XSLT.xpl"/>
      <p:document href="../smoketest/TEST-XSPEC.xpl"/>

      <p:document href="../xspec/xspec-execute.xpl"/>
      
      <p:document href="../projects/oscal-publish/setup/GRAB-OSCAL-CATALOG-SCHEMA.xpl"/>
      <p:document href="../projects/oscal-publish/setup/GRAB-OSCAL-XSLT.xpl"/>
      <p:document href="../projects/oscal-publish/publish-oscal-catalog.xpl"/>
      
      <p:document href="../projects/oscal-convert/GRAB-RESOURCES.xpl"/>
      <p:document href="../projects/oscal-convert/CONVERT-OSCAL-XML-DATA.xpl"/>
      <p:document href="../projects/oscal-convert/CONVERT-OSCAL-XML-FOLDER.xpl"/>
      <p:document href="../projects/oscal-convert/IDENTITY_.xpl"/>
      <p:document href="../projects/oscal-convert/BATCH_XML-TO-JSON.xpl"/>
      <p:document href="../projects/oscal-convert/BATCH_JSON-TO-XML.xpl"/>
      
      <p:document href="../projects/oscal-convert/src/clone-json-as-xpathxml.xpl"/>
      <p:document href="../projects/oscal-convert/src/clone-xpathxml-as-json.xpl"/>
      <p:document href="../projects/oscal-convert/src/single_json-to-xml.xpl"/>
      <p:document href="../projects/oscal-convert/src/single_xml-to-json.xpl"/>
      
      <p:document href="../projects/oscal-import/PRODUCE_FM6-22-chapter4.xpl"/>
      <p:document href="../projects/oscal-import/GRAB-RESOURCES.xpl"/>
      <p:document href="../projects/oscal-import/GRAB-FM6-22.xpl"/>
      <p:document href="../projects/oscal-import/GRAB-NISO_STS-RNG.xpl"/>
      
      
      <p:document href="../projects/oscal-validate/xsd-validate-catalog.xpl"/>
      <p:document href="../projects/oscal-validate/XSD-VALIDATE-EXAMPLE.xpl"/>
      <p:document href="../projects/oscal-validate/XSD-VALIDATE-OFFSITE.xpl"/>
      <p:document href="../projects/oscal-validate/REPORT-VALIDATION-EXAMPLE.xpl"/>
      
      <p:document href="../projects/profile-resolution/setup/ACQUIRE-OSCAL-DATA.xpl"/>
      <p:document href="../projects/profile-resolution/setup/GRAB-PROFILE-RESOLVER-XSLT.xpl"/>
      <p:document href="../projects/profile-resolution/src/apply-profile-resolver.xpl"/>
      <p:document href="../projects/profile-resolution/src/apply-profile-resolver-stepwise.xpl"/>
      <p:document href="../projects/profile-resolution/src/apply-profile-resolver-remotely.xpl"/>
      <p:document href="../projects/profile-resolution/RESOLVE-FISMA-PROFILES.xpl"/>
      <p:document href="../projects/profile-resolution/RESOLVE-KITTEN-CONTROLS.xpl"/>
      <p:document href="../projects/profile-resolution/resolve-profile-and-save.xpl"/>
   </p:input>
 
   <p:output port="xproc-files" sequence="true"/>
   
   <!-- /prologue -->
   
   <p:identity/>
   
</p:declare-step>
