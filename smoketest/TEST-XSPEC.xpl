<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:TEST-XSPEC"
   name="TEST-XSPEC">

   <p:import href="../xspec/xspec-execute.xpl"/>
   
   <p:input port="source" sequence="false">
     <!-- For now, running an XSLT XSpec -->
      <p:document content-type="application/xml" href="src/congratulations-xslt.xspec"/>
      <!--<p:document content-type="application/xml" href="src/doing-well-schematron.xspec"/>-->
      <!--<p:document content-type="application/xml" href="src/shout-xquery.xspec"/>-->
   </p:input>
   
   <!-- /end prologue -->
   
   <p:identity message="[TEST-XSPEC] Testing XSpec by running { base-uri(/) }"/>
   
   <ox:execute-xspec name="execute-xspec"/>
   
   <p:identity message="[TEST-XSPEC] All done, successful run"/>

</p:declare-step>
