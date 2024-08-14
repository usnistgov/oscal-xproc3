<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step  version="3.0"
   xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:apply-profile-resolver" name="apply-profile-resolver">

   <!-- Purpose: using an XSLT stored locally, produce an OSCAL catalog
        from an OSCAL profile provided at runtime.
   
   NB: all its imported resources must be available -->


   <p:input port="source" primary="true" sequence="false"/>

   <p:output port="resolved-baseline" primary="true"/>
   
   <!-- Switch out for any top-level or 'driver' resolving transformation -->
   <p:variable name="xslt" select="'../lib/resolver-xslt/oscal-profile-RESOLVE.xsl' => resolve-uri(static-base-uri())"/>

   <p:xslt name="resolve">
      <p:with-input port="stylesheet" href="{$xslt}"/>
      <p:with-option name="parameters" select="map { 'uuid-method': 'random-xslt' }"/>
   </p:xslt>
   
</p:declare-step>