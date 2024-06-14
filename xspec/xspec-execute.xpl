<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:x="http://www.jenitennison.com/xslt/xspec"
   name="xspec-execute"
   type="ox:xspec-execute" xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3">

<!-- XProc 3.0 rendition of saxon-xslt-harness
     -->
<!-- Credit: Florent Georges is the author of the original XProc 1.0 XSpec testing harnesses, which this code (in its first iteration) sets out to emulate -->

   <p:input port="xspec-source" primary="true" content-types="application/xml">
      <p:document href="../smoketest/congratulations-xslt.xspec" content-type="application/xml"/>
   </p:input>
   
   <p:output port="xspec-html-report" primary="true" pipe="result@html-report"/>
   
   <p:output port="xspec-junit-report" primary="false" pipe="result@junit-report"/>
  
   <!--<p:output port="compiled-xspec" pipe="result@compile-xspec"/>-->
   
    <!--<p:output port="xspec-report" primary="true" sequence="true" pipe="secondary@execute-xspec"/>-->
   
   <!--<p:output port="result" pipe="result@end"/>-->
   
<!-- compile the XSpec -->

   <p:variable name="xspec-home"     select="'../lib/xspec-3.0.3/'"/>
   <p:variable name="compiler-xslt"  select="$xspec-home || 'src/compiler/compile-xslt-tests.xsl'"/>
   <p:variable name="formatter-xslt" select="$xspec-home || 'src/reporter/format-xspec-report.xsl'"/>
   <p:variable name="junit-xslt"     select="$xspec-home || 'src/reporter/junit-report.xsl'"/>
   
   <p:xslt name="compile-xspec">
      <!--<p:with-input port="source" pipe="xspec-source@xspec-execute"/>-->
   <!--   <p:with-input port="source">
         <p:document href="../smoketest/congratulations-xslt.xspec" content-types="text/xml"/>
      </p:with-input>
-->      <p:with-input port="stylesheet" href="{ $compiler-xslt }"/>
   </p:xslt>
   
<!-- Some surgery must be performed on the compiled XSLT ...  -->
   <p:add-attribute name="adjusted-runtime"
      match="/*/xsl:template[@name='Q{{http://www.jenitennison.com/xslt/xspec}}main']/xsl:result-document"
      attribute-name="href" attribute-value="report"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform" />
   
   <!-- run the XSLT -->

   <p:xslt name="execute-xspec">
      <p:with-input port="source"><p:empty/></p:with-input>
      <p:with-input port="stylesheet" pipe="result@adjusted-runtime"/>
      <p:with-option name="template-name" select="'Q{http://www.jenitennison.com/xslt/xspec}main'"/>
   </p:xslt>
   
   <p:identity name="xspec-report">
      <p:with-input port="source" pipe="secondary@execute-xspec"/>
   </p:identity>
   
   <!-- format the report -->

   
   <!--<x:report stylesheet="bogus.xsl" xspec="dummy.xspec" date="2024-04-01T16:26:29.142753100-04:00"/>-->
   
   <p:xslt name="html-report">
      <p:with-input port="stylesheet" href="{ $formatter-xslt }"/>
      <p:with-option name="parameters" select="map { 'inline-css': 'true' }"/>
   </p:xslt>
   
   <p:string-replace match="text()" replace="translate(., '', '&lt;&gt;')"/>
   
   <p:sink/>
   
   <p:xslt name="junit-report">
      <p:with-input port="source" pipe="result@xspec-report"/>
      <!--<p:with-input port="source">
         <x:report stylesheet="bogus.xsl" xspec="dummy.xspec" date="2024-04-01T16:26:29.142753100-04:00"/>
      </p:with-input>-->
      <p:with-input port="stylesheet" href="{ $junit-xslt }"/>
      
   </p:xslt>
   <!--
   
   <p:identity name="end"/>-->
   
</p:declare-step>