<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step" version="1.0"
  xmlns:oscal="http://csrc.nist.gov/ns/oscal/1.0"
  type="oscal:render-oscal-fo-via-html" name="render-oscal-fo-via-html">
  
  <!-- Purpose: support HTML production, PDF production and debugging of an OSCAL Catalog production pipeline in XProc 1.0 -->
  <!-- Note: uses 'sp800-53-emulator' HTML and XSLFO stylesheets to provide formatting templates -->
  <!-- Input: a valid OSCAL catalog, but the processor does not halt for bad inputs when well-formed: GIGO -->
  <!-- Output: ports expose SOURCE (echoing input), HTML and FO intermediate forms; additionally, a PDF file is created as a side effect by processing the XSL-FO with FOP -->
  <!-- Note: a runtime option 'try-formatting' may be set to 'no' to suppress the final formatting step. This can be useful for debugging or when producing HTML only. -->  
  
  <p:option name="result-pdf-path" select="'test.pdf'"/>
  
  <p:option name="try-formatting" select="'yes'"/>
  
  <p:input port="OSCAL" primary="true"/>
  <p:input port="parameters" kind="parameter"/>
  
  <p:serialization port="SOURCE" indent="true"/>
  <p:output port="SOURCE" primary="false">
    <p:pipe port="result" step="input"/>
  </p:output>
  
  <p:serialization port="HTML" indent="true" method="xml"/>
  <p:output port="HTML" primary="false">
    <p:pipe port="result" step="make-html"/>
  </p:output>
  
  <p:serialization port="FO"    indent="true"/>
  <p:output port="FO" primary="false">
    <p:pipe port="result" step="make-xsl-fo"/>
  </p:output>
  
  
  <!--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" 
   "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">-->
  <!--<p:serialization port="markdown"     indent="false" method="text"/>-->
  
  
  <p:identity name="input"/>
  
  <p:xslt name="make-html">
    <p:input port="stylesheet">
      <p:document href="nist-emulation/sp800-53A-catalog_html.xsl"/>
    </p:input>
  </p:xslt>
  
  <p:xslt name="make-xsl-fo">
    <p:input port="stylesheet">
      <p:document href="nist-emulation/oscal_sp800-53-emulator_fo.xsl"/>
    </p:input>
  </p:xslt>
  
  <p:choose>
    <p:when test="not($try-formatting = 'no')">
      <p:xsl-formatter name="make-pdf" content-type="application/pdf">
        <p:with-option name="href" select="$result-pdf-path"/>
        <p:input port="parameters">
          <p:empty/>
        </p:input>
      </p:xsl-formatter>        
    </p:when>
    <p:otherwise>
      <p:sink/>
    </p:otherwise>
  </p:choose>
    
</p:declare-step>