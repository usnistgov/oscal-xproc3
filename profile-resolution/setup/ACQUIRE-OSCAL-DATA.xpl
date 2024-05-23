<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:cx="http://xmlcalabash.com/ns/extensions"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:ACQUIRE-OSCAL-DATA"
   name="ACQUIRE-OSCAL-DATA">
   
   <!-- Purpose: update local copies of some OSCAL resources from its release repository -->
   
   <!--
      try pxf:copy extension step to avoid parsing?
      (would that work with non-XML as well? apparently not)
   -->
      
   <p:input port="resource-names">
      <p:inline>
         <download path="https://raw.githubusercontent.com/usnistgov/oscal-content/main/nist.gov">
            <!-- Catalog and two baselines -->
            <resource dir="SP800-53/rev5/xml">NIST_SP-800-53_rev5_catalog.xml</resource>
            <resource dir="SP800-53/rev5/xml">NIST_SP-800-53_rev5_LOW-baseline_profile.xml</resource>
            <resource dir="SP800-53/rev5/xml">NIST_SP-800-53_rev5_PRIVACY-baseline_profile.xml</resource>
            
            <!-- Resolved profile for download - for comparison with one we produce from LOW-baseline_profile -->
            <resource dir="SP800-53/rev5/xml">NIST_SP-800-53_rev5_LOW-baseline-resolved-profile_catalog.xml</resource>            
         </download>
      </p:inline>
   </p:input>
   
   <p:variable name="download-path" select="download/@path/string(.)"/>
   <p:variable name="prefix" select="'[' || 'GATHER-OSCAL-DATA' || ']'"/>
   <p:variable name="destination" select="'lib/oscal-content'"/>
   
   <p:for-each message="{$prefix} Saving resources in ./lib ...">
      <!-- iterating over each 'resource' as a discrete document node -->
      <p:with-input select="download/resource"/>
      <p:variable name="my-name" select="string(.)"/>
      <p:variable name="dir" select="/*/@dir"/>
      
      <!-- No exception handling, keep an eye on outputs -->
      <p:load href="{ ($download-path,$dir,$my-name) => string-join('/') }" message="{$prefix} Loading { $my-name} from { $download-path }/{ $dir } ..."/>
      <p:store message="{$prefix} ... saving { $destination }{ $my-name }" href="{ $destination }/{ $my-name }"/>
   </p:for-each>
   
</p:declare-step>