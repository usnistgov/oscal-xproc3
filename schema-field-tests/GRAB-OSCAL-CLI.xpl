<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:GRAB-OSCAL-CLI"
   name="GRAB-OSCAL-CLI">

   <!-- Maven home for OSCAL CLI distribution
      https://repo1.maven.org/maven2/gov/nist/secauto/oscal/tools/oscal-cli/cli-core/1.0.1/cli-core-1.0.1-oscal-cli.zip
      
      See https://github.com/usnistgov/oscal-cli for instructions and use
      
   -->
   
   <p:variable name="download-path" select="'https://repo1.maven.org/maven2/gov/nist/secauto/oscal/tools/oscal-cli/cli-core/1.0.1'"/>
   <!--<p:variable name="download-path" select="'.'"/>-->
   <p:variable name="archive-basename"  select="'cli-core-1.0.1-oscal-cli'"/>
   
   <p:variable name="zip-name"  select="$archive-basename || '.zip'"/>
   <p:variable name="where-to" select="('lib/' || $archive-basename) => resolve-uri(static-base-uri())"/>

   <p:variable name="prefix" select="'[' || 'GRAB-OSCAL-CLI' || ']'"/>
   
   <!-- It beginneth -->

   <p:load href="{ $download-path }/{ $zip-name }" message="[GRAB-OSCAL-CLI] p:load: { $download-path }/{ $zip-name } ..."/>
   
   <p:store href="lib/{ $zip-name }" message="{$prefix} Saving lib/{ $zip-name } (thanks Dave!)"/>
   
   <p:identity message="{$prefix} See https://github.com/usnistgov/oscal-cli to set up and use oscal-cli"/>
   
   <p:unarchive message="{$prefix} Unzipping { $zip-name }"/>
      
   <p:for-each message="{$prefix} Unzipping into directory { $where-to }">
      <p:variable name="local-path" select="p:document-property(.,'base-uri') => substring-after($zip-name)"/>
      <p:variable name="path-here" select="($where-to || $local-path)"/>

      <!--<p:identity message="{$prefix} Seeing a file for { $path-here }"/>-->
      <p:store href="{ $path-here }" message="{$prefix} Saving { $path-here }"/>
   </p:for-each>
   
</p:declare-step>