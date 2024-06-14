<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:SMOKETEST-XSPEC"
   name="SMOKETEST-XSPEC">

   <p:import href="../xspec/xspec-execute.xpl"/>
   
   <p:input port="source">
     <p:document content-type="application/xml" href="congratulations-xslt.xspec"/>
   </p:input>
   
   <p:identity message="[SMOKETEST-XSPEC] Testing XSpec by running ./congratulations-xslt.xspec"/>
   
   <ox:xspec-execute name="execute-xspec"/>
   
</p:declare-step>
