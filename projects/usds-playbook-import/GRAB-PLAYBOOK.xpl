<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:GRAB-RESOURCES"
   name="GRAB-RESOURCES">

   <!-- A $prefix is used to tag messages, expected to match the process type -->
   <p:input port="source">
      <p:document href="https://playbook.usds.gov/"/>
   </p:input>
   
   <p:variable name="prefix" select="'[' || 'GRAB-RESOURCES' || ']'"/>
   
   <p:variable name="filename" select="'playbook-source.html'"/>   
   
   <p:store message="{$prefix} ... saving { $filename }" href="archive/{ $filename }"/>
   
</p:declare-step>