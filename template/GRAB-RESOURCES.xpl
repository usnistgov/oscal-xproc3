<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:GRAB-RESOURCES"
   name="GRAB-RESOURCES">
   

   <!-- Purpose: update local copies of some OSCAL resources from its release repository -->
   

   <!-- Schematron validating this XProc or any project XProc can be found
     in the ../testing directory -
     
     ../testing/xproc3-house-rules.sch
     
     with harnesses for running
     
     don't neglect -->
   
   <p:input port="resource-names">
      <p:inline>
         <download path="https://github.com/usnistgov/OSCAL/releases/download/v1.1.2">
            <!-- OSCAL catalog schemas and converters are as good as anything for demonstration -->
            <resource>oscal_catalog_schema.xsd</resource>
            <resource>oscal_profile_schema.xsd</resource>
         </download>
      </p:inline>
   </p:input>
   
   <p:variable name="download-path" select="download/@path/string(.)"/>
   
   <!-- A $prefix is used to tag messages, expected to match the process type -->
   <p:variable name="prefix" select="'[' || 'GRAB-RESOURCES' || ']'"/>
   
   <p:for-each message="{$prefix} Saving resources in ./lib ...">
      <!-- iterating over each 'resource' as a discrete document node -->
      <p:with-input select="download/resource"/>
      <p:variable name="filename" select="string(.)"/>
      
      <!-- No exception handling since a failed load often produces a result
           making it difficult to anticipate what a failure looks like - -->
      <!-- NB - A Schematron error comes back as soon as this is out of line with /*/@type i.e. the file name
           - starting the @message with { $prefix } silences the error, but please reset $prefix -->
      <p:load message="[GRAB-RESOURCES] Loading { $filename} from { $download-path } ..."
              href="{ $download-path }/{ $filename }" />
      <p:store message="{$prefix} ... saving { $filename }"
               href="lib/{ $filename }"/>
   </p:for-each>
   
</p:declare-step>