<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:BATCH-XSPEC"
   name="BATCH-XSPEC"
   >

   <!-- Executes available XSpecs -->
   
   <p:import href="TEST-XSPEC-SET.xpl"/>
   
   <p:import href="../xspec/xspec-execute.xpl"/>
   
   <p:variable name="repo-root" select="resolve-uri('.. ',static-base-uri())  => replace('^file:///','file:/')"/>
   
   <p:variable name="schematron-path" select="'xproc3-house-rules.sch'"/>
   <p:variable name="outdir"          select="'xspec-reports'"/>
   
   <ox:TEST-XSPEC-SET name="test-set"/>
   
   <p:for-each>
      <p:with-input pipe="xspec-files@test-set"/>
      <!-- Remember that each input node is a root for its own tree - hence XPath context -->
      <p:variable name="base" select="base-uri(/*)"/>
      <p:variable name="repo-path" select="substring-after($base,$repo-root)"/>
      <p:variable name="html-report-path"  select="replace($repo-path,'\.xspec$','') || '-report.html' "/>
      <p:variable name="junit-report-path" select="replace($repo-path,'\.xspec$','') || '-junit.xml' "/>
      <!--<p:identity message="[BATCH-XSPEC] $base: { $base }"/>
      <p:identity message="[BATCH-XSPEC] $repo-path: { $repo-path }"/>
      <p:identity message="[BATCH-XSPEC] $repo-root: { $repo-root }"/>-->

      <ox:xspec-execute name="execute-xspec"/>
      
      <p:store message="[BATCH-XSPEC] storing HTML report in {$outdir}/{$html-report-path}"   href="{$outdir}/{$html-report-path}">
         <p:with-input port="source" pipe="xspec-html-report@execute-xspec"/>
      </p:store>
      <p:store message="[BATCH-XSPEC] storing JUnit report in {$outdir}/{$junit-report-path}" href="{$outdir}/{$junit-report-path}">
         <p:with-input port="source" pipe="xspec-junit-report@execute-xspec"/>
      </p:store>
      <p:sink/>
   </p:for-each>
      
</p:declare-step>

