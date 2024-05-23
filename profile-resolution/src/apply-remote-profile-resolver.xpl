<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:cx="http://xmlcalabash.com/ns/extensions"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:apply-remote-profile-resolver"
   name="apply-remote-profile-resolver">

   <!-- Purpose: using an XSLT stored remotely, produce an OSCAL catalog
        from an OSCAL profile provided at runtime.
   
   NB: all its imported resources must be available -->
   
   <p:input port="oscal-profile" primary="true" sequence="false"/>
   
   <p:output port="resolved-catalog" primary="true"/>
   
   <!-- In contrast to its neighbor, this pipeline simply bombs if the XSLT is not available, instead of providing a warning -->
   <p:variable name="xslt" select="'https://raw.githubusercontent.com/usnistgov/OSCAL/main/src/utils/resolver-pipeline/oscal-profile-RESOLVE.xsl'"/>
   
   <p:xslt name="resolve">
      <p:with-input port="stylesheet" href="{ $xslt }"/>
   </p:xslt>
   
</p:declare-step>