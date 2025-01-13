<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" type="ox:MINIMAL" name="MINIMAL">

   <!-- This pipeline delivers an error if the file designated in $source-html-file is not found -
        Run the pipeline GRAB-PLAYBOOK.xpl to restore it. -->
   
   <!--<p:output port="result" sequence="true"  serialization="map{ 'indent': true() }"/>-->
   
   <!-- start here -->
   
   <p:variable name="source-html-file" select="resolve-uri('archive/playbook-source.html')"/>
  
   <!--starting -   - - -->
   
   <p:choose name="attempt-to-load">
      <!-- We can't use doc-available since the HTML is not XML (grr) -->
      <p:when test="unparsed-text-available($source-html-file)">
         <p:load href="{ $source-html-file }" message="Loading { $source-html-file }"/>
      </p:when>
      <p:otherwise>
         <p:error code="ox:missing-source">
            <p:with-input>
               <message>Not finding expected source data at { $source-html-file } - try running GRAB-PLAYBOOK.xpl</message>
            </p:with-input>
         </p:error>         
      </p:otherwise>
   </p:choose>
   
   <p:group name="semantic-rendering">
      <p:filter select="/descendant::*[@id='plays']"/>

      <p:cast-content-type content-type="application/xml"/>

      <p:store href="archive/playbook_01_extract.xhtml"/>

      <p:namespace-delete prefixes="html" xmlns:html="http://www.w3.org/1999/xhtml"/>

      <p:xslt>
         <p:with-input port="stylesheet" href="src/usds-html-to-oscal.xsl"/>
      </p:xslt>

      <p:store href="archive/playbook_02_rendered.xml"/>
   </p:group>
   
   <p:group name="map-to-oscal">
      <p:label-elements attribute="name" label="tokenize(title,'\s+')[last()] ! lower-case(.)" match="part"
         replace="false"/>

      <p:insert match="/*" position="first-child">
         <p:with-input port="insertion">
            <p:inline>
               <metadata>
                  <title>US Digital Service Playbook (OSCAL rendition)</title>
                  <last-modified>{ current-dateTime() }</last-modified>
                  <version>0.1</version>
                  <oscal-version>1.1.2</oscal-version>
                  <link rel="source" href="https://playbook.usds.gov/"/>
               </metadata>
            </p:inline>
         </p:with-input>
      </p:insert>

      <p:add-attribute match="/catalog" attribute-name="uuid" attribute-value="00000000-0000-0000-0000-000000000000"/>
      <p:uuid match="/catalog/@uuid"/>
      
      <p:namespace-delete prefixes="c ox"/>
      
      <p:namespace-rename to="http://csrc.nist.gov/ns/oscal/1.0"/>

      <!-- Validate OSCAL -->
      
      <p:store href="archive/playbook_99_oscal.xml" serialization="map{ 'indent': true() }"/>
   </p:group>
   
</p:declare-step>