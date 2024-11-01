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
   
   <!--<p:output serialization="map { 'indent': true() }" pipe="@compound-step-links" sequence="true"/>-->
   
   
<!-- Before we splice in foreign contents, we rewrite a little - adding a/@target enabling links
     open in a target window ... we could do this with XSLT but the XProc step is easier. -->
   <p:add-attribute name="links-rewritten"  match="a" xmlns="http://www.w3.org/1999/xhtml"
      attribute-name="target" attribute-value="specs">
      <p:with-input pipe="spec-doc@XPROC-STEP-INDEX-HTML"/>
   </p:add-attribute> 
   
   <!-- nb  the sink is optional but clarifies the pipeline - the next step picks up its own inputs -->
   <p:sink/>
   
   <p:group name="compound-step-links" xmlns:db="http://docbook.org/ns/docbook">
      <p:output port="result"/>
      <p:for-each>
         <p:with-input select="/descendant::db:para[@xml:id='p.subpipeline']/db:tag[not(.='p:variable')]"
            href="https://spec.xproc.org/lastcall-2024-08/head/xproc/specification.xml"/>
         <p:rename match="db:tag" new-name="a"/>
         <p:add-attribute attribute-name="href"
            attribute-value="https://spec.xproc.org/lastcall-2024-08/head/xproc/#{string(.) => translate(':','.')}"/>
         <p:add-attribute match="a" attribute-name="target" attribute-value="specs"/>
         <p:wrap match="/*" wrapper="li"/>
      </p:for-each>
      <p:wrap-sequence wrapper="ul"/>
      <p:wrap-sequence wrapper="div"/>
      <p:insert match="/*" position="first-child">
         <p:with-input port="insertion">
            <h2>Core <b>compound steps</b></h2>
         </p:with-input>
      </p:insert>
      <p:namespace-delete prefixes="db xsl c ox xs"/>
      <p:namespace-rename to="http://www.w3.org/1999/xhtml"/>
      <p:cast-content-type content-type="application/xhtml+xml"/>
   </p:group>
   
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
      <p:with-input port="insertion" select="/descendant::ul[5]" pipe="@links-rewritten"/>
   </p:insert>
   
   <p:insert match="section[@class='introduction']" xmlns="http://www.w3.org/1999/xhtml"
      position="after" message="[XPROC-STEP-INDEX-HTML] Inserting compound step links">
      <p:with-input port="insertion" select="/*" pipe="result@compound-step-links"/>
   </p:insert>
   
   <p:store href="out/xproc-step-list.html" message="[XPROC-STEP-INDEX-HTML] Storing xproc-step-list.html"/>
   
   <p:sink/>
   
</p:declare-step>