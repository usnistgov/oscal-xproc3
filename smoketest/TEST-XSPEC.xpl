<p:declare-step version="3.0"
   xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:TEST-XSPEC" name="TEST-XSPEC">

   <p:import href="../xspec/xspec-execute.xpl"/>

   <p:input port="source" sequence="true">
      <p:document content-type="application/xml" href="src/congratulations-xslt.xspec"/>
      <p:document content-type="application/xml" href="src/doing-well-schematron.xspec"/>
      <p:document content-type="application/xml" href="src/shout-xquery.xspec"/>
   </p:input>

   <!-- /prologue -->

   <p:for-each>
      <p:identity message="[TEST-XSPEC] Testing XSpec by running { base-uri(/) }"/>
      <ox:execute-xspec name="execute-xspec"/>
   </p:for-each>

   <p:identity message="[TEST-XSPEC] All done, successful run"/>

</p:declare-step>
