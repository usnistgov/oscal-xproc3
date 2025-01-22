<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" type="ox:MINI_worksheet" name="MINI_worksheet"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   >

   <p:input port="source">
      <p:inline content-type="text/plain">Hello World!</p:inline>
   </p:input>
   
   <p:output port="result"/>
   
   
   <p:declare-step name="report-status" type="ox:report-status">
      <p:input port="source"/>
      <p:output port="result"/>
      <p:identity message="[CONTENT-TYPE_worksheet] [STATUS REPORT] SEEING '{ p:document-property(.,'content-type') }' AT { p:document-property(.,'base-uri') }"/>
   </p:declare-step>
   
   <ox:report-status/>
   
   <p:text-replace pattern="!" replacement="!!!"/>
   
   <p:identity message="Saying '{ . }'"/>

   <p:xquery>
      <p:with-input port="query">
         <!-- Without content-type p:inline assumes XML -->
         <p:inline expand-text="false"><root>{ substring(.,2) }</root></p:inline>
      </p:with-input>
   </p:xquery>
   
   <p:identity message="Say again '{ . }'"/>
</p:declare-step>