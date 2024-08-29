<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xvrl="http://www.xproc.org/ns/xvrl"
   type="ox:REPORT-VALIDATION-EXAMPLE"
   name="REPORT-VALIDATION-EXAMPLE">

   <p:import href="xsd-validate-catalog.xpl"/>
   
   <p:input port="source" primary="true">
      <!-- a valid instance -->
      <!--<p:document href="./samples/cat-catalog.xml"/>-->
      
      <!-- an invalid instance: -->
      <p:document href="./samples/dog-catalog.xml"/>      
   </p:input>

   <p:output port="result" serialization="map{ 'method': 'text' }"/>
   
   <!-- We report the validation report that comes back - XVRL for this -->
   <!--<p:output port="report" pipe="report@catalog-validation" serialization="map{ 'indent': true() }"/>-->
   
   <p:variable name="baseURI" select="base-uri(/)"/>
   
   <ox:xsd-validate-catalog name="catalog-validation"/>
   
   <p:variable name="validation-errors" select="//xvrl:detection[@severity=('fatal-error','error')]">
      <p:pipe port="report" step="catalog-validation"/>
   </p:variable>
   
   <p:variable name="error-count" select="count($validation-errors)"/>
   
   <p:identity>
      <p:with-input port="source">
         <p:inline xml:space="preserve">
{ if (empty($validation-errors)) then 'CONGRATULATIONS!!! ' else 'Uhoh . . .' }            
Validating { $baseURI } - { if ($error-count eq 0) then 'no' else $error-count } {
            if ($error-count eq 1) then 'error' else 'errors' } reported</p:inline>
      </p:with-input>
   </p:identity>
   
</p:declare-step>