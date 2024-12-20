<?xml version="1.0" encoding="UTF-8"?>
<p:library xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xvrl="http://www.xproc.org/ns/xvrl"
   xmlns:svrl="http://purl.oclc.org/dsdl/svrl">

   <!-- For samples and boilerplate see file ../../projects/xproc-doc/xproc-snippets.xml -->
   <!-- Simple steps for summarizing and reporting results of validations
        producing SVRL or XVRL
        - These REQUIRE REFINEMENT AND TESTING
        e.g. throw p:error on bad inputs?
             locate schema away from source documents? -->
   
   
   <!-- An XSLT is the other obvious way to do this, but XProc! --> 
   <p:declare-step name="xvrl-summarize" type="ox:xvrl-summarize">
      <!-- Expecting an xvrl:report or xvrl:NO_REPORT on the primary input port -->
      <p:input port="xvrl-report" primary="true"/>
      
      <p:output port="summary" sequence="true"/>
      
      <p:variable name="here" select="resolve-uri('.') => p:urify()"/>
      <p:variable name="schema" select="/xvrl:report/xvrl:metadata/xvrl:schema/p:urify(@href)"/>
      <p:variable name="validation-errors" select="//xvrl:detection[@severity=('fatal-error','error')]"/>
      <p:variable name="error-count" select="count($validation-errors)"/>
   
      <p:choose>
         <p:when test="empty(/xvrl:report)">
            <p:identity>
               <p:with-input>
                  <p:empty/>
               </p:with-input>
            </p:identity>
         </p:when>
         <p:when test="empty($validation-errors)">
            <p:identity>
               <p:with-input>
                     <message>CONGRATULATIONS! No validation errors are reported against { substring-after($schema, $here) }</message>
               </p:with-input>
            </p:identity>
         </p:when>
         <p:otherwise>
            <p:identity>
               <p:with-input>
                  <message>Uhoh . . . Validating result with { $schema } - { $error-count } {
            if ($error-count eq 1) then 'error' else 'errors' } reported</message>
               </p:with-input>
            </p:identity>
            
         </p:otherwise>
      </p:choose>
      <p:namespace-delete prefixes="c ox xsl xvrl svrl"/>
   </p:declare-step>
   
   <p:declare-step name="svrl-summarize" type="ox:svrl-summarize">
      <!-- Expecting an svrl:report on the primary input port -->
      <p:input port="svrl-report" primary="true"/>
      
      <p:output port="summary" sequence="true"/>
      
      <p:variable name="validation-errors" select="//svrl:failed-assert | //svrl:successful-report"/>
      <p:variable name="error-count" select="count($validation-errors)"/>
      
      <p:choose>
         <!--<p:when test="empty(/svrl:report)">
            <p:identity>
               <p:with-input port="source">
                  <p:empty/>
               </p:with-input>
            </p:identity>
         </p:when>-->
         <p:when test="empty($validation-errors)">
            <p:identity>
               <p:with-input>
                     <message>CONGRATULATIONS! No validation errors are reported from Schematron checking OSCAL</message>
               </p:with-input>
            </p:identity>
         </p:when>
         <p:otherwise>
            <p:identity>
               <p:with-input>
                  <message>Uhoh . . .  Validating result with Schematron - { $error-count } {
            if ($error-count eq 1) then 'error' else 'errors' } reported</message>
               </p:with-input>
            </p:identity>
         </p:otherwise>
      </p:choose>
      <p:namespace-delete prefixes="c ox xsl xvrl svrl"/>
   </p:declare-step>
   
</p:library>