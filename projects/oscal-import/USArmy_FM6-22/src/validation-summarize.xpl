<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
   xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xvrl="http://www.xproc.org/ns/xvrl"
   xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
   name="validation-summarize" type="ox:validation-summarize"
   >
   
   <!-- 
      Ad hoc validation summary pipeline for data import demo -

      Expecting any of
         ox:NO_REPORT
         
         xvrl:report or xvrl:NO_REPORT on the primary input port 
        SEE ../extract-FM6_22-chapter4.xpl
   
        Or empty (nothing) -->
   
   <p:option name="doc-name"    select="'[a document]'"/>
   <p:option name="schema-name" select="'[a schema]'"/>
   
   <p:input port="validation-report" sequence="true"/>
   
   <p:output port="summary" sequence="true"/>

   <!-- The actual logic is in counting messages in the report, either for xvrl or svrl, extensible -->
   <p:variable name="ox:report-xvrl" as="function(*)"
      xmlns:xs="http://www.w3.org/2001/XMLSchema"
      select="function($xvrl as element()) as xs:boolean { $xvrl/@severity=('fatal-error','error') }"/>
   
   <p:variable name="ox:report-svrl" as="function(*)"
      xmlns:xs="http://www.w3.org/2001/XMLSchema"
      select="function($svrl as element()) as xs:boolean { ($svrl/@role = ('info','warning')) => not() }"/>
   
   <p:variable name="validation-errors" select="//xvrl:detection[$ox:report-xvrl(.)]
      | //svrl:failed-assert[$ox:report-svrl(.)] | //svrl:successful-report[$ox:report-svrl(.)]
      "/>
   <p:variable name="error-count" select="count($validation-errors)"/>

   <!-- Outputs are simply reporting the aggregate -
        see project ../../schema-field-tests/ and others for more XProc batching validation reports -->
   
   <p:choose>
      <p:when test="exists(/ox:message)">
         <p:identity/>
      </p:when>
      <p:when test="empty($validation-errors)">
         <p:identity>
            <p:with-input>
               <ox:message>CONGRATULATIONS! No errors are reported for { $doc-name } validating against { $schema-name }</ox:message>
            </p:with-input>
         </p:identity>
      </p:when>
      <p:otherwise>
         <p:identity>
            <p:with-input>
               <ox:message>Uhoh . . . Validating { $doc-name } with { $schema-name } - { $error-count } {
            if ($error-count eq 1) then 'error' else 'errors' } reported</ox:message>
            </p:with-input>
         </p:identity>
      </p:otherwise>
   </p:choose>
      
</p:declare-step>