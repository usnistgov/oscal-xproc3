<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
   xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
   
<!-- Effectively a no-op Schematron, as written this Schematron will pass everything
      
      But it can easily be adjusted to show validation behaviors with @assert-valid='true|false' in the XProc
 -->
   
   <!-- Turning the report/@test to 'true()' issues an innocuous message but renders a document invalid -->
   <!-- Turning the assert/@test to 'false()' will test the Schematron assertion capability - everything is invalid now too. -->
   
   <sch:pattern>
      <sch:rule context="/*">
         <sch:report test="false()">CONGRATULATIONS - you have performed Schematron validation on a <sch:name/> document.</sch:report>
         <sch:assert test="false()">An assertion should fail when it is false.</sch:assert>
      </sch:rule>
   </sch:pattern>
   
</sch:schema>