<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:GRAB-OSCAL-XSLT"
   name="GRAB-OSCAL-XSLT">


   <p:variable name="download-path" select="'https://github.com/usnistgov/oscal-xslt/archive/refs/heads'"/>
   <!--<p:variable name="download-path" select="'lib'"/>-->
   
   <p:variable name="zip-name"  select="'main.zip'"/>
   
   <p:variable name="destination" select="resolve-uri('../lib/xslt', static-base-uri())"/>

   <p:variable name="prefix" select="'[' || 'GRAB-OSCAL-XSLT' || ']'"/>
   
   <!-- It beginneth -->

   <p:load href="{ $download-path }/{ $zip-name }" message="{ $prefix } p:load { $download-path }/{ $zip-name } ..."/>
   
   <p:store href="../lib/oscal/{ $zip-name }" message="{$prefix} Saving lib/oscal/{ $zip-name } (thank you OSCAL Team)"/>
   
   <!-- see p:unarchive here: https://spec.xproc.org/3.0/steps/#c.unarchive -->
   <!-- We pull the XSLT out, leaving the testing and XSpec in the zip -->
   <p:unarchive message="{$prefix} Unzipping { $zip-name }"
      include-filter="^oscal-xslt-main/publish/.*(xsl|css)$" />
      
   <p:for-each>
      <p:variable name="basename" select="p:document-property(/,'base-uri') => substring-after('oscal-xslt-main/')"/>
      
      <p:store href="{ $destination }/{ $basename }" message="{$prefix} Saving { $destination }/{ $basename }"/>
      <!--<p:identity message="{$prefix} Saving in { $destination }/{ $basename }"/>-->
   </p:for-each>

</p:declare-step>