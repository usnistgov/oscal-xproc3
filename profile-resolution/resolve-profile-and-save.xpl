<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0"
   xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:resolve-profile-and-save" name="resolve-profile-and-save">

<!-- Purpose: resolve a pipeline and write its results to a local file.
     The file created is named after the profile and placed next to the XProc invocation. -->

         

   <!-- Switch out the subpipeline to rely on local or remote copy, or to expose steps -->
   
   <!-- Calls a local copy of the driver XSLT -->
   <p:import href="src/apply-profile-resolver.xpl"/>

   <!-- Calls the driver stylesheet from the OSCAL repo-->
   <!--<p:import href="src/apply-remote-profile-resolver.xpl"/>-->

   <!-- Calls the pipeline in steps, for debugging -->
   <!--<p:import href="src/apply-profile-resolver-stepwise.xpl"/>-->
   
   <!-- And we're off -->
   
   <!-- The subpipeline should returns either an OSCAL catalog, or
        if the catalog could not be produced, a copy of the input profile-->
   
   <p:input port="source" primary="true" sequence="false"/>
   
   <p:variable name="profile-basename" select="/*/base-uri() => replace('.*/','') => replace('\.xml$','')"/>
   <p:variable name="resolution-path" select="$profile-basename || '-resolved.xml'"/>
   
   <p:variable name="prefix" select="'[' || 'resolve-profile' || ']'"/>
   
   <!-- Use the one imported above -->
   <ox:apply-profile-resolver/>
   <!--<ox:apply-remote-profile-resolver/>-->
   <!--<ox:apply-profile-resolver-stepwise/>-->
   
   <p:choose xmlns:oscal="http://csrc.nist.gov/ns/oscal/1.0">
      <p:when test="/oscal:catalog => exists()">
         <p:store href="{ $resolution-path }" message="{ $prefix } Saving resolved profile as file { $resolution-path }"/>
</p:when>
      <!--<p:when test="/oscal:profile => exists()">         
         <p:identity
            message="{$prefix} PROFILE RESOLUTION FAILURE - the pipeline was not applied successfully"/>
      </p:when>-->
      <p:otherwise>
         <p:identity
            message="{$prefix} PROFILE RESOLUTION FAILURE - the pipeline was not applied successfully"/>
      </p:otherwise>
   </p:choose>

   <p:sink/>
   
</p:declare-step>