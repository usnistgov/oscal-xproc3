<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   type="ox:XPROC-STEP-INDEX-HTML" name="XPROC-STEP-INDEX-HTML">


   <!-- The published spec itself is secondary input, providing us a ToC we can splice in -->
   <p:input port="spec-doc" primary="false">
      <p:document href="https://xproc.org/specifications.html"/>
   </p:input>
   
<!-- As produced by COLLECT-XPROC-STEPS.xpl - you will get an error if that pipeline is not run first -->
<!-- For later: an integrated pipeline that runs both together -->
   <p:input port="step-list" primary="true">
      <p:document href="xproc-steps.xml"/>
   </p:input>
   
<!-- Before we splice in foreign contents, we rewrite a little - adding a/@target enabling links
     open in a target window ... we could do this with XSLT but the XProc step is easier. -->
   <p:add-attribute name="links-rewritten"
      attribute-name="target"
      attribute-value="specs"
      match="a"
      xmlns="http://www.w3.org/1999/xhtml">
      <p:with-input port="source" pipe="spec-doc@XPROC-STEP-INDEX-HTML"/>
   </p:add-attribute> 
   
   <!-- nb  the sink is optional but clarifies the pipeline - the next step picks up its own inputs -->
   <p:sink/>
   
   <!-- Next: XSLT to produce HTML for the step digest, with links back to the Recs
        and XSpec for this XSLT -->
   <p:xslt message="[XPROC-STEP-INDEX-HTML] Producing HTML from XML step list xproc-steps.xml">
      <p:with-input port="source" pipe="step-list@XPROC-STEP-INDEX-HTML"/>
      <p:with-input port="stylesheet" href="src/declarations-html.xsl"/>
   </p:xslt>
   
   <!-- Grabbing the list of links to optional step definitions straight from the page on line -  -->
   <p:insert match="div[@id='specification-links']" 
      xmlns="http://www.w3.org/1999/xhtml"
      position="last-child" message="[XPROC-STEP-INDEX-HTML] Inserting reference links">
      <p:with-input port="insertion" select="/descendant::ul[5]" pipe="@links-rewritten">
         <!--<p:document href="https://xproc.org/specifications.html"/>-->
      </p:with-input>
   </p:insert>
      
   <p:store href="out/xproc-step-list.html" message="[XPROC-STEP-INDEX-HTML] Storing xproc-step-list.html"/>
   
   <p:sink/>
   
</p:declare-step>