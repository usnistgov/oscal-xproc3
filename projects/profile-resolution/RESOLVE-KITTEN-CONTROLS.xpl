<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:RESOLVE-KITTEN-CONTROLS" name="RESOLVE-KITTEN-CONTROLS">

   <!-- Subpipeline encapsulates logic for runtime -
        modify it to alter behavior including:
          which XSLT or sequence of XSLT transformations
          what to do with the result catalog -->
   
   <p:import href="resolve-profile-and-save.xpl"/>
   
   <p:input port="source" primary="true" sequence="false">
      <p:document href="data/kitten_profile.xml"/>
   </p:input>

   <!-- And we're off -->
   
   <ox:resolve-profile-and-save/>
   
</p:declare-step>