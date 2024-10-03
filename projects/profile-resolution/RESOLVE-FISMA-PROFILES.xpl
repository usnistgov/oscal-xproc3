<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:RESOLVE-FISMA-PROFILES" name="RESOLVE-FISMA-PROFILES">

   <!-- Like RESOLVE-KITTEN-CONTROLS.xpl demonstration, except on actual FISMA data. -->
   
   <!-- Acquire files for lib folder by running setup/ACQUIRE-OSCAL-DATA.xpl -->
   
   <p:import href="resolve-profile-and-save.xpl"/>
   
   <!-- Note expect things to bomb if profiles don't call their catalogs correctly or things are missing -->
   <p:input port="source" primary="true" sequence="true">
      <!-- Profiles in lib have broken links to catalogs! these are corrected -->
      <p:document href="data/NIST_SP-800-53_rev5_LOW-baseline_profile.xml"/>
      <p:document href="data/AC-6_profile.xml"/>
   </p:input>

   <!-- And we're off -->
   
   <p:for-each>
     <ox:resolve-profile-and-save/>
   </p:for-each>
   
</p:declare-step>