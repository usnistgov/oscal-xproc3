<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:GRAB-OSCAL"
   name="GRAB-OSCAL">
   
   <!-- Purpose: update local copies of some OSCAL resources from its release repository -->
   
   <!--
      try pxf:copy extension step to avoid parsing?
      (would that work with non-XML as well? apparently not)
   -->
      
   <p:input port="resource-names">
      <p:inline>
         <download path="https://github.com/usnistgov/OSCAL/releases/download/v1.1.2">
            <resource destination="oscal-converters">oscal_catalog_xml-to-json-converter.xsl</resource>
            <resource destination="oscal-converters">oscal_catalog_json-to-xml-converter.xsl</resource>
            <resource destination="oscal-schemas">oscal_catalog_schema.xsd</resource>
            <resource destination="oscal-schemas">oscal_catalog_schema.json</resource>
         </download>
      </p:inline>
   </p:input>
   
   <p:variable name="download-path" select="download/@path/string(.)"/>
   <p:variable name="prefix" select="'[' || 'GRAB-OSCAL' || ']'"/>
   
   <p:for-each message="{$prefix} Saving resources in ./lib ...">
      <!-- iterating over each 'resource' as a discrete document node -->
      <p:with-input select="download/resource"/>
      <p:variable name="my-name" select="string(.)"/>
      <p:variable name="destination" select="/*/@destination"/>
      
      <!-- No exception handling since a failed load often produces a result
           making it difficult to anticipate what a failure looks like - -->
      <p:load href="{ ($download-path,$my-name) => string-join('/') }" message="[GRAB-OSCAL] Loading { $my-name} from { $download-path } ..."/>
      <p:store message="{$prefix} ... saving { $destination ! (. || '/')}{ $my-name }" href="{ ('lib',$destination,$my-name) => string-join('/')}"/>
   </p:for-each>
   
</p:declare-step>