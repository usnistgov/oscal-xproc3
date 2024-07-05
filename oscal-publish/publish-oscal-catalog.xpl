<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:publish-oscal-catalog"
   name="publish-oscal-catalog">
   
   
  <p:option name="make-pdf" select="'yes'"/>
  
  <p:input port="source" primary="true">
     <p:document href="../profile-resolution/data/cat_catalog.xml"/>
  </p:input>

   <p:variable name="result-html-path" select="(base-uri(/) => replace('\.xml$','')) || '.html'"/>
   <p:variable name="result-pdf-path" select="(base-uri(/) => replace('\.xml$','')) || '.pdf'"/>
   

  <!--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" 
   "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">-->
  <!--<p:serialization port="markdown"     indent="false" method="text"/>-->
  
  <!-- Validate here and warn if not valid! -->
  <p:identity name="input"/>
  
  <p:xslt name="make-html">
    <p:with-input port="stylesheet" href="lib/xslt/publish/nist-emulation/sp800-53A-catalog_html.xsl"/>
  </p:xslt>
  
  <p:store href="{$result-html-path}" message="[publish-oscal-catalog] storing { $result-html-path }"/>
   
  <p:xslt name="make-xsl-fo">
    <p:with-input port="stylesheet" href="lib/xslt/publish/nist-emulation/oscal_sp800-53-emulator_fo.xsl"/>
  </p:xslt>
  
  <!--<p:choose>
    <p:when test="not($make-pdf = 'yes')">
       <p:xsl-formatter name="make-pdf" content-type="application/pdf" href="{$result-pdf-path}"/>
    </p:when>
    <p:otherwise>
      <p:sink/>
    </p:otherwise>
  </p:choose>-->
    
    <p:sink/>
</p:declare-step>