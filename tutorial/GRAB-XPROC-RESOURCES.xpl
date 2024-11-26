<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:GRAB-XPROC-RESOURCES"
   name="GRAB-XPROC-RESOURCES">
   

   <!-- Purpose: update local copies of some OSCAL resources from its release repository -->
   
   <!-- This standalone XProc assumes an (empty) 'source' input but does not use it, and
   needs no output port as it writes to the file system. -->
   
   <!--  /end prologue -->
   <!--  :%: :%: :%: :%: :%: :%: :%: :%: :%: :%: :%: :%: :%: :%: :%: :%: :%: :%: :%: :%: :%: :%: :%: :%: -->
   
   <p:variable name="download-path" select="'https://spec.xproc.org/3.0/xproc'"/>
  
   <!--https://spec.xproc.org/3.0/xproc/xproc30.rnc
       https://spec.xproc.org/3.0/xproc/xproc30.rng-->

   <!-- A $prefix is used to tag messages, expected to match the process type -->
   <p:variable name="prefix" select="'[' || 'GRAB-RESOURCES' || ']'"/>
   
   <p:for-each message="{$prefix} Saving resources in ./lib ...">
      <p:with-input>
         <p:document href="{$download-path}/xproc30.rnc"/>
         <p:document href="{$download-path}/xproc30.rng"/>
      </p:with-input>
      <!-- /prologue -->
      <p:variable name="filename" select="p:document-property(.,'base-uri') ! replace(.,'.*/','')"/>
      
      <p:store message="{$prefix} ... saving { $filename }"
               href="lib/{ $filename }"/>
   </p:for-each>
   
</p:declare-step>