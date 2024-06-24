<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:BATCH-SCH-XSPEC"
   name="BATCH-SCH-XSPEC"
   >

   <p:import href="../xspec/xspec-execute.xpl"/>
   
   <!-- Executes available XSpecs -->
   <p:input port="source" sequence="true">
      <!-- We need content type because xspec suffix throws off the parser -->
      <p:document href="../smoketest/doing-well-schematron.xspec" content-type="application/xml"/>
      
   </p:input>
   
   <p:variable name="repo-root" select="resolve-uri('.. ',static-base-uri())  => replace('^file:///','file:/')"/>
   
   <p:variable name="outdir" select="'xspec-reports' => resolve-uri(static-base-uri())"/>
   
   <p:for-each>
      <!-- Remember that each input node is a root for its own tree - hence XPath context -->
      <p:variable name="xspec-filename" select="base-uri(/*)"/>
      <p:variable name="relative-path" select="substring-after($xspec-filename,$repo-root)"/>
      <p:variable name="html-report-path"  select="replace($relative-path,'\.xspec$','') || '_report.html' "/>
      <p:variable name="junit-report-path" select="replace($relative-path,'\.xspec$','') || '_junit.xml' "/>

      <ox:schematron-xspec-execute name="execute-xspec"/>
      
      <p:store message="[BATCH-SCH-XSPEC] storing HTML report in {$outdir}/{$html-report-path}"   href="{$outdir}/{$html-report-path}">
         <p:with-input port="source" pipe="xspec-html-report@execute-xspec"/>
      </p:store>
      <p:store message="[BATCH-SCH-XSPEC] storing JUnit report in {$outdir}/{$junit-report-path}" href="{$outdir}/{$junit-report-path}">
         <p:with-input port="source" pipe="xspec-junit-report@execute-xspec"/>
      </p:store>
      <p:sink/>
   </p:for-each>
      
</p:declare-step>

