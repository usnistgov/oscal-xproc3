<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:GRAB-NISOSTS-RNG"
   name="GRAB-NISOSTS-RNG">
   
   <!-- =+=+=+=+= HOUSE RULES HALL PASS - remove this comment when the file is committed to the repo =+=+=+=+=  -->


   <!-- SchXSLT is at https://github.com/schxslt/schxslt
        It is an XSLT-based Schematron processor -->
   
   <!-- /end prologue -->
   <!-- start subpipeline -->
   
   <!-- https://niso-sts.org/DTDs-XSDs-RNGs-1-2.html
        https://niso-sts.org/downloadables/RNGs/v1-2/NISO-STS-interchange-1-2-MathML3-RNG.zip
   -->
   
   <p:variable name="download-path" select="'https://niso-sts.org/downloadables/RNGs/v1-2/'"/>
   
   <p:variable name="filename"  select="'NISO-STS-interchange-1-2-MathML3-RNG.zip'"/>
   
   <p:variable name="libdir" select="'./lib/'"/>
   
   <p:variable name="prefix" select="'[' || 'GRAB-NISOSTS-RNG' || ']'"/>
   
   <!-- It beginneth -->

   <p:load href="{ $download-path }/{ $filename }" message="{ $prefix } p:load: { $download-path }/{ $filename } ..."/>
   
   <p:store href="{ $libdir }{ $filename }" message="{$prefix} Saving { $filename } (Thank you NISO STS WG!)"/>
   
   <!-- see p:unarchive here: https://spec.xproc.org/3.0/steps/#c.unarchive -->
   <p:unarchive message="{$prefix} Unzipping { $filename }"/>
      
   <p:for-each message="{$prefix} Unzipping into directory { $libdir }">
      <p:variable name="local-path" select="p:document-property(.,'base-uri') => substring-after($download-path || $filename)"/>
      <p:variable name="path-here" select="($libdir || $local-path)"/>

      <!--<p:identity message="{$prefix} Seeing a file for { $path-here }"/>-->
      <p:store href="{ $path-here }" message="{$prefix} Saving { $path-here }"/>
   </p:for-each>
   
   <!--
   <p:identity message="{ $prefix } Test your Schematron capability using ../smoketest/SMOKETEST-SCHEMATRON.xpl"/>
   -->
</p:declare-step>