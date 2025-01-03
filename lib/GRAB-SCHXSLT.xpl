<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:GRAB-SCHXSLT"
   name="GRAB-SCHXSLT">


   <!-- SchXSLT is at https://github.com/schxslt/schxslt
        It is an XSLT-based Schematron processor -->
   
   <!-- /end prologue -->
   <!-- start subpipeline -->
   
   <p:variable name="download-path" select="'https://github.com/schxslt/schxslt/releases/download/v1.9.5'"/>
   <!--<p:variable name="download-path" select="'.'"/>-->
   <p:variable name="archive-basename"  select="'schxslt-1.9.5'"/>
   
   <p:variable name="zip-name"  select="$archive-basename || '-xproc.zip'"/>
   <p:variable name="whither" select="resolve-uri($archive-basename, static-base-uri())"/>

   <p:variable name="prefix" select="'[GRAB-SCHXSLT]'"/>
   
   <!-- It beginneth -->

   <p:load href="{ $download-path }/{ $zip-name }" message="{ $prefix } p:load: { $download-path }/{ $zip-name } ..."/>
   
   <p:store href="{ $zip-name }" message="{$prefix} Saving { $zip-name } (thanks David Maus!)"/>
   
   <!-- see p:unarchive here: https://spec.xproc.org/3.0/steps/#c.unarchive -->
   <p:unarchive message="{$prefix} Unzipping { $zip-name }"/>
      
   <p:for-each message="{$prefix} Unzipping into directory { $whither }">
      <p:variable name="local-path" select="p:document-property(.,'base-uri') => substring-after($zip-name || '/' || $archive-basename)"/>
      <p:variable name="path-here" select="($whither || $local-path)"/>

      <!--<p:identity message="Seeing a file for { $path-here }"/>-->
      <p:store href="{ $path-here }" message="{$prefix} Saving { $path-here }"/>
   </p:for-each>
   
   <p:identity message="{ $prefix } Test your Schematron capability using ../smoketest/TEST-SCHEMATRON.xpl"/>
   
</p:declare-step>