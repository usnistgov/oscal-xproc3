<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:TEST-SCHEMATRON"
   name="TEST-SCHEMATRON">
            
	<p:output port="result" serialization="map{'indent' : true(), 'omit-xml-declaration': true() }" />


   <!-- /end prologue -->
   
   <!-- assert-valid='false' returns the input document with SVRL on another port
        see https://spec.xproc.org/master/head/validation/#c.validate-with-schematron
   -->
   <p:validate-with-schematron assert-valid="true"
      message="[TEST-SCHEMATRON] Running a Schematron, expecting to see no errors ...">
      <p:with-input port="schema" href="src/doing-well.sch"/>
      <p:with-input port="source">
         <p:inline>
            <CONGRATULATIONS>Schematron runs under XProc 3.0.</CONGRATULATIONS>
         </p:inline>
      </p:with-input>
   </p:validate-with-schematron>

   <p:namespace-delete prefixes="ox"/>
   
</p:declare-step>
