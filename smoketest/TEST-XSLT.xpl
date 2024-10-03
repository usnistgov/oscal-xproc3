<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:TEST-XSLT"
   name="TEST-XSLT">

   <p:output port="result" serialization="map{'indent' : true(), 'omit-xml-declaration': true() }" />

   <!-- /end prologue -->
   
   <p:xslt name="smoketest" message="[TEST-XSLT] XPROC 3 SMOKE TEST - - - Applying transformation ...">
      <p:with-input port="source">
         <p:inline>
            <CONGRATULATIONS>Congratulations on running an XProc 3 pipeline.</CONGRATULATIONS>
         </p:inline>
      </p:with-input>
      <p:with-input port="stylesheet" href="src/congratulations.xsl"/>
   </p:xslt>

   <p:namespace-delete prefixes="ox"/>
   
</p:declare-step>
