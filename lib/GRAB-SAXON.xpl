<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:GRAB-SAXON"
   name="GRAB-SAXON">

   <!-- start prologue -->
   
      <!-- Pipeline runs standalone without external bindings or options. -->
   
   <!-- /end prologue -->
   
   <!-- start subpipeline -->
   
   <p:variable name="download-path" select="'https://www.saxonica.com/download'"/>
   
   <p:variable name="jarfile" select="'saxon-he-12.5.jar'"/>
   
   <p:variable name="zip-name"  select="'SaxonHE12-5J.zip'"/>
   
   <!-- => is the XPath 'arrow operator' https://www.w3.org/TR/xpath-31/#id-arrow-operator -->
   <p:variable name="target-dir" select="'MorganaXProc-IIIse-1.4/MorganaXProc-IIIse_lib' => resolve-uri()"/>
   
   <p:variable name="prefix" select="'[GRAB-SAXON]'"/>
   
   <!-- It beginneth -->

   <p:load href="{ $download-path }/{ $zip-name }" message="{ $prefix } p:load: { $download-path }/{ $zip-name } ..."/>
   
   <p:store href="{ $zip-name }" message="{$prefix} Saving { $zip-name } (thank you to Mike Kay and Saxonica)"/>
   
   <!-- see p:unarchive here: https://spec.xproc.org/3.0/steps/#c.unarchive -->
   <p:unarchive message="{$prefix} Unzipping { $zip-name }"
      include-filter="{ $jarfile }"/>
      
   <p:store href="{ $target-dir }/{ $jarfile }" message="{$prefix} Saving { $target-dir }/{ $jarfile }"/>
   
   <p:identity message="{ $prefix } Test your XSLT transformation capability using ../smoketest/TEST-XSLT.xpl"/>
   
</p:declare-step>