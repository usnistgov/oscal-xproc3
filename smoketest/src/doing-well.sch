<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
   xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
   
<!-- Effectively a no-op Schematron, as written this Schematron will pass everything
      
     But it can easily be adjusted to show validation behaviors with @assert-valid='true|false' in the XProc
 -->

   
   <sch:pattern>
      <sch:rule context="/*">
         <!-- Turning the report/@test to 'true()' issues an innocuous message but renders a document invalid -->
         <!-- Turning the assert/@test to 'false()' will test the Schematron assertion capability - everything is invalid now too. -->
         <sch:report test="false()">CONGRATULATIONS - you have performed Schematron validation on a <sch:name/> document.</sch:report>
         <sch:assert test="true()">An assertion should fail when it is false.</sch:assert>
      </sch:rule>
      <sch:rule context="doing-well">
         <sch:let name="thanks" value="normalize-space(.) = 'THANK YOU'"/>
         <sch:assert id="doing-well_positive-assertion" test="$thanks">When doing well, say THANK YOU</sch:assert>
         <sch:assert id="doing-well_negative-assertion" test="not(.)">Never! (A Cretan never tells the truth.)</sch:assert>
         <sch:report id="doing-well_positive-report"    test="$thanks">You are welcome</sch:report>
         <sch:report id="doing-well_negative-report"    test="not(.)">This will never report.</sch:report>
      </sch:rule>
   </sch:pattern>
   
</sch:schema>