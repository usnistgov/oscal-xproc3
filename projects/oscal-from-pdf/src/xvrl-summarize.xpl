<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
   xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xvrl="http://www.xproc.org/ns/xvrl"
   name="xvrl-summarize" type="ox:xvrl-summarize"
   >
   
   <!-- Expecting an xvrl:report or xvrl:NO_REPORT on the primary input port 
        SEE ../extract-FM6_22-chapter4.xpl-->
   <p:input port="xvrl-report"/>
   
   
   <p:output port="summary" sequence="true"/>

   <p:variable name="here" select="resolve-uri('..') => p:urify()"/>
   <p:variable name="schema" select="/xvrl:report/xvrl:metadata/xvrl:schema/p:urify(@href)"/>
   <p:variable name="validation-errors" select="//xvrl:detection[@severity=('fatal-error','error')]"/>
   <p:variable name="error-count" select="count($validation-errors)"/>
   
   
   <p:choose>
      <p:when test="exists(/xvrl:NO_REPORT)">
         <p:identity>
            <p:with-input port="source">
               <p:empty/>
            </p:with-input>
         </p:identity>
      </p:when>
      <p:when test="empty($validation-errors)">
         <p:identity>
            <p:with-input port="source">
               <p:inline xml:space="preserve">CONGRATULATIONS! No validation errors are reported against { substring-after($schema, $here) }</p:inline>
            </p:with-input>
         </p:identity>
      </p:when>
      <p:otherwise>
         <p:identity>
            <p:with-input port="source">
               <p:inline xml:space="preserve">Uhoh . . .        
Validating result with { $schema } - { $error-count } {
            if ($error-count eq 1) then 'error' else 'errors' } reported</p:inline>
            </p:with-input>
         </p:identity>
      </p:otherwise>
   </p:choose>
      
</p:declare-step>