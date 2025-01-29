<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" type="ox:OSCAL-WEBPUB_FM_6-22" name="OSCAL-WEBPUB_FM_6-22"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   >

   <!-- Pipeline produces two HTML file outputs from OSCAL source, for demonstration -->
   
   <!-- NB the XSLTs are specifically coded for this OSCAL - this is not generic handling -->

   
   <!-- Errors out if file is not present: run pipeline PRODUCE_FM6-22-chapter4.xpl -->
   <p:input port="source" href="FM_6-22-OSCAL-working.xml"/>
   
   <!--<p:output port="result"/>-->
   
   <p:identity name="oscal-source" message="[OSCAL-WEBPUB_FM_6-22] Seeing source file { base-uri(/) }"/>
   
   <!-- These XSLT 1.0 stylesheets are coded to be forward-compatible with the XSLT 3.0 engine  -->
   <p:xslt name="fulltext-webpage">
      <p:with-input port="stylesheet" href="src/www_fm22-6_fulltext.xsl"/>
   </p:xslt>
   
   <p:store href="www/FM_6-22-fulltext.html" serialization="map{ 'method': 'html' }" message="[OSCAL-WEBPUB_FM_6-22] p:store: www/FM_6-22-fulltext.html ..."/>
   
   <!-- implicit p:sink as we start with new source port -->
   
   <p:xslt name="tables-webpage">
      <p:with-input port="source" pipe="@oscal-source"/>
      <p:with-input port="stylesheet" href="src/www_fm22-6_tables.xsl"/>
   </p:xslt>
   
   <p:store href="www/FM_6-22-tables.html" serialization="map{ 'method': 'html' }" message="[OSCAL-WEBPUB_FM_6-22] p:store: www/FM_6-22-tables.html ..."/>

</p:declare-step>