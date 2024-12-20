<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:apply-profile-resolver"
   name="apply-profile-resolver-remotely">

<!-- This is a second variant of apply-profile-resolver.xpl - it calls the XSLT in from Github -->

   <!-- Purpose: using an XSLT stored remotely, produce an OSCAL catalog
        from an OSCAL profile provided at runtime.
   
   NB: all its imported resources must be available -->
   
   <p:input port="oscal-profile" primary="true" sequence="false"/>
   
   <p:output port="resolved-catalog" primary="true"/>
   
   <p:variable name="xslt-uri" select="'https://raw.githubusercontent.com/usnistgov/OSCAL/main/src/utils/resolver-pipeline/oscal-profile-RESOLVE.xsl'"/>
   
   <p:xslt name="resolve">
      <p:with-input port="stylesheet">
         <!-- @content-type provided since file comes down as plain text -->
         <p:document content-type="text/xml" href="{ $xslt-uri }"/>
      </p:with-input>
      <p:with-option name="parameters" select="map { 'uuid-method': 'random-xslt' }"/>
   </p:xslt>
   
</p:declare-step>