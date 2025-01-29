<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" type="ox:OSCAL-PLAYBOOK" name="OSCAL-PLAYBOOK-SIMPLE">


   <!--
   
   Pipeline producing OSCAL from HTML source
   
   This is a reduced version of OSCAL-PLAYBOOK.xpl, with exception handling
   and failsafe (regression) testing removed, for contrast.
   In other words, as lightweight as possible.
   Test the pipeline by examining its outputs.
   
   -->
   
   <p:input port="source" href="archive/playbook-source.html"/>
   
   <!-- subpipeline starts here -->
   
   
   <p:group name="semantic-rendering">
      <p:filter select="/descendant::*[@id='plays']"/>

      <p:cast-content-type content-type="application/xml"/>
      
      <p:store href="archive/playbook_01_extract.xhtml"
         message="[OSCAL-PLAYBOOK-SIMPLE] p:store: archive/playbook_01_extract.xhtml ..."/>

      <p:namespace-delete prefixes="html" xmlns:html="http://www.w3.org/1999/xhtml"/>

      <p:xslt name="cast-html" message="[OSCAL-PLAYBOOK-SIMPLE] Extracting and mapping --">
         <p:with-input port="stylesheet" href="src/usds-html-to-oscal.xsl"/>
      </p:xslt>
   
      <p:identity message="[OSCAL-PLAYBOOK-SIMPLE] ... things looking good ..."/>
      
      <p:store href="archive/playbook_02_rendered.xml" serialization="map{ 'indent': true() }"
         message="[OSCAL-PLAYBOOK-SIMPLE] p:store: archive/playbook_02_rendered.xml ..."/>
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
         message="[OSCAL-PLAYBOOK-SIMPLE] Casting to OSCAL ----"/>

      <p:store href="archive/playbook_99_oscal.xml" serialization="map{ 'indent': true() }"
         message="[OSCAL-PLAYBOOK-SIMPLE] p:store: archive/playbook_99_oscal.xml ..."/>
   </p:group>
   
   <p:identity message="[OSCAL-PLAYBOOK-SIMPLE] ... things looking FINE."/>

</p:declare-step>