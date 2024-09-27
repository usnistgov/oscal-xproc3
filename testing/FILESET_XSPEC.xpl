<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:FILESET_XSPEC"
   name="FILESET_XSPEC">

   <!-- Pipeline to be called as subpipeline, delivering a sequence of XSpec files, parsed as XML -->

   <!-- Strictly diagnostic or demonstration XSpecs can be excluded from this list,
        while the rule for CI/CD is "Paranoia is my good friend". -->

   <p:documentation>Defining a set of files for XSpec evaluation. Listing any and all XSpec files in the repository intended to be run under CI/CD.</p:documentation>
   
   <p:input port="source" sequence="true">
      <!-- We need content type because xspec suffix throws off the parser -->
      <p:document href="../smoketest/src/congratulations-xslt.xspec" content-type="application/xml"/>
      <p:document href="../smoketest/src/doing-well-schematron.xspec" content-type="application/xml"/>
      <p:document href="../smoketest/src/shout-xquery.xspec" content-type="application/xml"/>
      
      <p:document href="../tutorial/src/testing/xhtml-to-md.xspec" content-type="application/xml"/>
   </p:input>
 
   <p:output port="xspec-files" sequence="true"/>
   
   <p:identity/>
  
</p:declare-step>
