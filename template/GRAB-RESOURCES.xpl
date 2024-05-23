<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:GRAB-RESOURCES"
   name="GRAB-RESOURCES">
   
   
   <!-- Purpose: update local copies of some OSCAL resources from its release repository -->
   
   <!--
      try pxf:copy extension step to avoid parsing?
      (would that work with non-XML as well? apparently not)
   -->
      
   <p:input port="resource-names">
      <p:inline>
         <download path="https://github.com/usnistgov/OSCAL/releases/download/v1.1.2">
            <!-- OSCAL catalog schemas and converters are as good as anything for demonstration -->
            <resource dir="oscal-converters">oscal_catalog_xml-to-json-converter.xsl</resource>
            <resource dir="oscal-converters">oscal_catalog_json-to-xml-converter.xsl</resource>
            <resource dir="oscal-schemas">oscal_catalog_schema.xsd</resource>
            <resource dir="oscal-schemas">oscal_catalog_schema.json</resource>
         </download>
      </p:inline>
   </p:input>
   
   <p:variable name="download-path" select="download/@path/string(.)"/>
   <p:variable name="prefix" select="'[' || 'GRAB-RESOURCES' || ']'"/>
   
   <p:for-each message="{$prefix} Saving resources in ./lib ...">
      <!-- iterating over each 'resource' as a discrete document node -->
      <p:with-input select="download/resource"/>
      <p:variable name="my-name" select="string(.)"/>
      <p:variable name="dir" select="/*/@dir"/>
      
      <!-- No exception handling since a failed load often produces a result
           making it difficult to anticipate what a failure looks like - -->
      <!-- NB - A Schematron error comes back as soon as this is out of line with /*/@type i.e. the file name
           - starting the @message with { $prefix } silences the error, but please reset $prefix -->
      <p:load message="[GRAB-RESOURCES] Loading { $my-name} from { $download-path } ..."
              href="{ ($download-path,$my-name) => string-join('/') }" />
      <p:store message="{$prefix} ... saving { $dir ! (. || '/')}{ $my-name }"
               href="{ ('lib',$dir,$my-name) => string-join('/')}"/>
   </p:for-each>
   
</p:declare-step>