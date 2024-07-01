<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:POWER-UP"
   name="POWER-UP">
            
   <p:output port="result" serialization="map{'indent' : true(), 'omit-xml-declaration': true() }" />
	
   <p:identity name="smoketest" message="[POWER-UP] XPROC 3 SMOKE TEST - - - saying 'Hello World'">
      <p:with-input port="source">
         <p:inline>
            <CONGRATULATIONS>Congratulations on running an XProc 3 pipeline.</CONGRATULATIONS>
         </p:inline>
      </p:with-input>
   </p:identity>

   <p:namespace-delete prefixes="ox"/>
   
</p:declare-step>
