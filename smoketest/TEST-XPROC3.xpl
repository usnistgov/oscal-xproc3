<p:declare-step version="3.0"
   xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:TEST-XPROC3"
   name="TEST-XPROC3">
            
   <p:output port="result" serialization="map{'indent' : true(), 'omit-xml-declaration': true() }" />
	
   <!-- /prologue	-->
   
   <p:identity name="smoketest" message="[TEST-XPROC3] XPROC 3 SMOKE TEST - - - saying 'Hello World'">
      <!-- p:inline is implicit w/in p:with-input containing an element not in the p: namespace -->
      <p:with-input>
         <CONGRATULATIONS>Congratulations on running an XProc 3 pipeline.</CONGRATULATIONS>
      </p:with-input>
   </p:identity>

   <p:namespace-delete prefixes="ox"/>
   
</p:declare-step>
