<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:XSD-VALIDATE-EXAMPLE"
   name="XSD-VALIDATE-EXAMPLE">

   <!-- STOP VALIDATION HALLPASS FILESET_XPROC3_HOUSE-RULES.xpl -->
   
   <p:import href="xsd-validate-catalog.xpl"/>
   
   <p:input port="source" primary="true">
      <!-- a valid instance -->
      <p:document href="./samples/cat-catalog.xml"/>
      
      <!-- an invalid instance: -->
      <!--<p:document href="./samples/dog-catalog.xml"/>-->      
   </p:input>

   <!-- We report the validation report that comes back - XVRL for this -->
   <p:output port="report" pipe="report@catalog-validation" serialization="map{ 'indent': true() }"/>
   
   <ox:xsd-validate-catalog name="catalog-validation"/>
   
</p:declare-step>