<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:xsd-validate-catalog"
   name="xsd-validate-catalog">

   <!-- STOP VALIDATION HALLPASS FILESET_XPROC3_HOUSE-RULES.xpl -->

   <p:input port="source" sequence="false"/>
   
   <p:output port="report" pipe="report@validation"/>
   
   <!-- OSCAL assets: https://github.com/usnistgov/OSCAL/releases -->
   <!-- Using the 'catalog' schema means we can validate only OSCAL catalogs -->
   <!--<p:variable name="schema-path" select="'https://github.com/usnistgov/OSCAL/releases/download/v1.1.2/oscal_catalog_schema.xsd'"/>-->
   <!--<p:variable name="schema-path" select="'https://github.com/usnistgov/OSCAL/releases/download/v1.1.2/oscal_complete_schema.xsd'"/>-->
   
   <!-- Local files can remove some perturbance  -->
   <p:variable name="schema-path" select="'../schema-field-tests/lib/oscal-schemas/oscal_catalog_schema.xsd'"/>
   
   <!-- Split acquisition and validation against the cached copy for better and more robust performance. -->
   
   <!-- With assert-valid=false, the process will not end with invalid results, while the validation report is captured
        on the `report` output port of the pipeline -->
   
   
   
   
   <p:validate-with-xml-schema name="validation" 
      assert-valid="false" message="[xsd-validate-catalog] Attempting to validate { base-uri(/*) } ..">
      <p:with-input port="schema">
         <!-- w/o content-type the acquisition gags on the type provided over https -->
         <p:document href="{$schema-path}" content-type="application/xml"/>
      </p:with-input>
   </p:validate-with-xml-schema>
   
</p:declare-step>