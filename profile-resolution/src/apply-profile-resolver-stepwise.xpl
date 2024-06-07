<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:apply-profile-resolver"
   name="apply-profile-resolver-stepwise">

   <!-- Purpose: using an XSLT stored remotely, produce an OSCAL catalog
        from an OSCAL profile provided at runtime.
   
   This variant performs the resolution in steps, making debugging easier.
   
   NB: all imported resources must be available -->
   
   <p:input port="oscal-profile" primary="true" sequence="false"/>
   
   <p:output port="resolved-catalog" primary="true"/>
   
   <!--   <transform>oscal-profile-resolve-select.xsl</transform>
          <transform>oscal-profile-resolve-metadata.xsl</transform>
          <transform>oscal-profile-resolve-merge.xsl</transform>
          <transform>oscal-profile-resolve-modify.xsl</transform>
          <transform>oscal-profile-resolve-finish.xsl</transform> -->

   <p:variable name="prefix" select="'[' || 'apply-profile-resolver-stepwise' ||  ']'"/>
   
   <p:try>
      <p:group>
         <p:xslt name="select"   message="{$prefix} -- selecting controls">
            <p:with-input port="stylesheet" href="../lib/resolver-xslt/oscal-profile-resolve-select.xsl"/>
         </p:xslt>
         <p:xslt name="metadata" message="{$prefix} -- tagging metadata">
            <p:with-input port="stylesheet" href="../lib/resolver-xslt/oscal-profile-resolve-metadata.xsl"/>
            <p:with-option name="parameters" select="map { 'uuid-method': 'random-xslt' }"/>
         </p:xslt>
         <p:xslt name="merge"    message="{$prefix} -- structuring result catalog">
            <p:with-input port="stylesheet" href="../lib/resolver-xslt/oscal-profile-resolve-merge.xsl"/>
         </p:xslt>
         <p:xslt name="modify"   message="{$prefix} -- adding modifications">
            <p:with-input port="stylesheet" href="../lib/resolver-xslt/oscal-profile-resolve-modify.xsl"/>
         </p:xslt>
         <p:xslt name="finish"   message="{$prefix} -- finishing">
            <p:with-input port="stylesheet" href="../lib/resolver-xslt/oscal-profile-resolve-finish.xsl"/>
         </p:xslt>
      </p:group>
      <p:catch>
         <p:identity message="{$prefix} Cannot resolve OSCAL profile against its catalog - a problem was encountered { true()
            }- try running GRAB-PROFILE-RESOLVER-XSLT.xpl to acquire the stylesheets"/>
      </p:catch>
   </p:try>
   
   <!-- What comes back is an oscal catalog or an oscal profile
        or errors and results from a failed application tbd -->
   
</p:declare-step>