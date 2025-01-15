<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" type="ox:OSCAL-PLAYBOOK" name="OSCAL-PLAYBOOK">

   <!--
   
   Pipeline producing OSCAL from HTML source
   
   It is also engineered (maybe over-engineered) for fault tolerance:
   
   - certain error conditions are defended against explicitly
     - if either $source-html-file or $schema-file is not found
     - run pipelines GRAB-RESOURCES.xpl and GRAB-PLAYBOOK.xpl to restore them
   - validations help ensure correctness of the mapping
   - OSCAL validation is performed optionally based on processor support for XSD validation
   
   -->
   
   <!-- subpipeline starts here -->
   
   <!-- Cached copies -->
   <p:variable name="schema-file"      select="resolve-uri('lib/oscal_catalog_schema.xsd')"/>
   <p:variable name="source-html-file" select="resolve-uri('archive/playbook-source.html')"/>
   
   <!--starting -   - - -->

   <!-- Inline XSLT requires fancy footwork with expand-text to correctly scope evaluation context for function calls -->
   <p:xslt name="introspect-xslt" template-name="report">
      <p:with-input port="source"><p:empty/></p:with-input>
      <p:with-input port="stylesheet" expand-text="false">
         <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
            version="3.0" expand-text="true">
            <xsl:template name="report">{ system-property('xsl:product-name') } { system-property('xsl:product-version') }</xsl:template>
         </xsl:stylesheet>
      </p:with-input>
   </p:xslt>
   
   <p:variable name="xslt-processor-version" select="string(.)"/>
   
   <!-- <p:sink/> is implicit here since the next step yields either p:load or p:error -->
   
   <p:choose name="acquire-catalog-schema">
      <p:when test="doc-available($schema-file)">
         <p:load href="{ $schema-file }" message="[OSCAL-PLAYBOOK] Loading schema { $schema-file }"/>
      </p:when>
      <!-- We could put an online fallback here (to Github release link) -->
      <p:otherwise>
         <p:error code="ox:missing-schema">
            <p:with-input>
               <message>Not finding OSCAL catalog schema at { $source-html-file } - try running GRAB-RESOURCES.xpl</message>
            </p:with-input>
         </p:error>         
      </p:otherwise>
   </p:choose>
   
   <!-- another implicit <p:sink/> -->

   <!-- Starting for real this time -->
   
   <p:choose name="attempt-to-load">
      <!-- We can't use doc-available since the HTML is not XML (grr) -->
      <p:when test="unparsed-text-available($source-html-file)">
         <p:load href="{ $source-html-file }" message="[OSCAL-PLAYBOOK] Loading { $source-html-file }"/>
      </p:when>
      <p:otherwise>
         <p:error code="ox:missing-source">
            <p:with-input>
               <message>Not finding expected source data at { $source-html-file } - try running GRAB-PLAYBOOK.xpl</message>
            </p:with-input>
         </p:error>         
      </p:otherwise>
   </p:choose>
   
   <!-- Groups organize us logically - first, extract and map; then, cast to OSCAL -->
   
   <p:group name="semantic-rendering">
      <p:filter select="/descendant::*[@id='plays']"/>

      <p:cast-content-type content-type="application/xml"/>
      
      <p:store href="archive/playbook_01_extract.xhtml"
         message="[OSCAL-PLAYBOOK] p:store: archive/playbook_01_extract.xhtml ..."/>

      <p:namespace-delete prefixes="html" xmlns:html="http://www.w3.org/1999/xhtml"/>

      <p:xslt name="cast-html" message="[OSCAL-PLAYBOOK] Extracting and mapping --">
         <p:with-input port="stylesheet" href="src/usds-html-to-oscal.xsl"/>
      </p:xslt>
      
      <!-- Validate to presumed model -->
      <p:validate-with-relax-ng assert-valid="true"
         message="[OSCAL-PLAYBOOK] Validating mapped data against expected data model ---">
         <p:with-input port="schema" href="src/playbook.rnc"/>
      </p:validate-with-relax-ng>
   
      <p:identity message="[OSCAL-PLAYBOOK] ... things looking good ..."/>
      
      <p:store href="archive/playbook_02_rendered.xml" serialization="map{ 'indent': true() }"
         message="[OSCAL-PLAYBOOK] p:store: archive/playbook_02_rendered.xml ..."/>
   </p:group>
   
   <p:group name="map-to-oscal">
      <!-- Naming unnamed parts 'checklist' or 'questions' --> 
      <p:label-elements match="part" attribute="name" replace="false"
         label="tokenize(title,'\s+')[last()] ! lower-case(.)"/>

      <p:insert match="/*" position="first-child">
         <p:with-input port="insertion">
            <metadata>
               <title>US Digital Service Playbook (OSCAL rendition)</title>
               <last-modified>{ current-dateTime() }</last-modified>
               <version>0.1</version>
               <oscal-version>1.1.2</oscal-version>
               <link rel="source" href="https://playbook.usds.gov/"/>
            </metadata>
         </p:with-input>
      </p:insert>

      <p:add-attribute match="/catalog" attribute-name="uuid" attribute-value="00000000-0000-0000-0000-000000000000"/>
      <p:uuid match="/catalog/@uuid"/>

      <p:namespace-delete prefixes="c ox"/>

      <!-- apply-to="elements" is essential to avoid hiding attributes in XSD validation -->
      <p:namespace-rename apply-to="elements" to="http://csrc.nist.gov/ns/oscal/1.0"
         message="[OSCAL-PLAYBOOK] Casting to OSCAL ----"/>

      <!-- <p:identity message="[OSCAL-PLAYBOOK] p:product-name: '{ p:system-property('p:product-name') }' with XSLT support from { $xslt-processor-version }"/>-->
      
      <!-- Validate OSCAL - REQUIRES SAXON EE for XML Calabash -->
      <p:choose>
         <p:when test="p:system-property('p:product-name') = 'XML Calabash' and not(starts-with($xslt-processor-version,'Saxon EE'))">
            <p:identity message="[OSCAL-PLAYBOOK] Skipping OSCAL validation (it requires Saxon EE in XML Calabash; we have { $xslt-processor-version }) - please validate externally"/>
         </p:when>
         <p:when test="p:step-available('p:validate-with-xml-schema')">
            <p:validate-with-xml-schema name="oscal-catalog-validation" assert-valid="true" version="1.0"
               message="[OSCAL-PLAYBOOK] Validating against OSCAL Catalog XSD -----">
               <p:with-input port="schema" pipe="@acquire-catalog-schema"/>
            </p:validate-with-xml-schema>
         </p:when>
         <p:otherwise>
            <p:identity message="[OSCAL-PLAYBOOK] Skipping OSCAL validation (not supported in the installed { p:system-property('p:product-name') }) - please-validate externally"/>
         </p:otherwise>
      </p:choose>

      <p:store href="archive/playbook_99_oscal.xml" serialization="map{ 'indent': true() }"
         message="[OSCAL-PLAYBOOK] p:store: archive/playbook_99_oscal.xml ..."/>
   </p:group>
   
   <p:identity message="[OSCAL-PLAYBOOK] ... things looking FINE."/>

</p:declare-step>