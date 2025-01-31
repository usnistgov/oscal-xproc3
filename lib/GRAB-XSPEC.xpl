<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:GRAB-XSPEC"
   name="GRAB-XSPEC">


   <!-- XSpec is an XSLT-based unit testing framework
        for XSLT, XQuery and Schematron -->
   
   <!--https://github.com/xspec/xspec/archive/refs/tags/v3.0.3.zip-->

   <!-- /end prologue -->
   <!-- start subpipeline -->
   
   <p:variable name="archive-basename"  select="'xspec-3.1.2'"/>
   
   <p:variable name="download" select="'https://github.com/xspec/xspec/archive/refs/tags/v3.1.2.zip'"/>
   <!--<p:variable name="download" select="'xspec-3.0.3.zip'"/>-->
   
   <p:variable name="zip-name"  select="$archive-basename || '.zip'"/>
   
   <p:variable name="libdir" select="resolve-uri('../lib', static-base-uri())"/>

   <p:variable name="prefix" select="'[GRAB-XSPEC]'"/>
   
   <!-- It beginneth -->

   <p:load href="{ $download }" message="{ $prefix } p:load: { $download } ..."/>
   
   <p:store href="{ $zip-name }" message="{$prefix} Saving { $zip-name } (thanks XSpec contributors!)"/>
   <!--<p:identity message="{$prefix} to save { $zip-name }"/>-->
   
   <!-- see p:unarchive here: https://spec.xproc.org/3.0/steps/#c.unarchive -->
   <p:unarchive message="{$prefix} Unzipping { $zip-name }" exclude-filter="example.xml"/>
      
   <p:for-each message="{$prefix} Unzipping into directory { $libdir }">
      <p:variable name="local-path" select="p:document-property(.,'base-uri')
         => substring-after($download || '/' )"/>
      <p:variable name="path-here" select="($libdir, $local-path) => string-join('/')"/>

      <!--<p:identity message="{$prefix} Seeing { $local-path} for { $path-here }"/>-->
      <p:store href="{ $path-here }" message="{$prefix} Saving { $path-here }"/>
   </p:for-each>
   
   <p:identity message="{ $prefix } Test your XSpec capability using ../smoketest/TEST-XSPEC.xpl"/>
   
</p:declare-step>