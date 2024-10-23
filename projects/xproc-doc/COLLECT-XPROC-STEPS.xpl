<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   type="ox:COLLECT-XPROC-STEPS" name="COLLECT-XPROC-STEPS">

   
   <!--<p:output serialization="map{'indent' : true()}" sequence="true"/>-->
   <!--<p:variable name="step-defs" select="id('req-steps')/xi:include"/>-->

   <!--The pipeline loads specification Docbook XML for XProc dynamically
   and pulls all the step declarations
   
   for indexing and linkbacks
   
   -->

   <!-- Drilling into the retrieved Docbook file for the XIncludes in the Required Steps section,
        then pulling p:declare step from the linked files -->
   <p:for-each name="required-steps" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns="http://docbook.org/ns/docbook">
      <p:with-input select="//section[@xml:id='req-steps']/xi:include">
         <p:document href="https://raw.githubusercontent.com/xproc/3.0-steps/master/steps/src/main/xml/specification.xml"
            content-type="text/xml"/>
      </p:with-input>
      <p:variable name="step-location" select="resolve-uri(/*/@href,base-uri(.))"/>
      <p:load content-type="text/xml" href="{ $step-location }" message="[COLLECT-XPROC-STEPS] Loading { $step-location }"/>
      <p:filter select="//p:declare-step"/>
      <p:add-attribute match="p:declare-step" attribute-name="library" attribute-value="standard"/> 
   </p:for-each>

   <!-- we don't need to sink since the next step ignores the primary results anyway -->
   <p:sink/>

   <!-- Next pulling p:declare step from optional step definition files, as enumerated. -->
   <p:xslt>
      <p:with-option name="template-name" select="'xsl:initial-template'"/>
      <p:with-input port="source">
         <p:empty/>
      </p:with-input>
      <p:with-input port="stylesheet">
         <p:inline>
            <xsl:stylesheet version="3.0" exclude-result-prefixes="#all">
               <xsl:variable name="repository" as="xs:string">https://raw.githubusercontent.com/xproc/3.0-steps/master</xsl:variable>
               <xsl:variable name="step-keys" select="'ixml','mail','os','paged-media','rdf','run','text','validation'"/>
               <xsl:template match="/" name="xsl:initial-template" expand-text="false">
                  <specification-list>
                     <!-- note doubling {{ b/c XSLT embedded in XProc -->
                     <xsl:for-each select="$step-keys">
                        <specification library="{{.}}" href="{{$repository}}/step-{{.}}/src/main/xml/specification.xml" />
                     </xsl:for-each>
                  </specification-list>
               </xsl:template>
            </xsl:stylesheet>
         </p:inline>
      </p:with-input>
   </p:xslt>

   <p:for-each name="optional-steps">
      <p:with-input select="/*/specification"/>
      <p:variable name="library" select="/*/@library"/>
      <p:variable name="href" select="/*/@href"/>
      <p:load content-type="text/xml" href="{ $href }" message="[COLLECT-XPROC-STEPS] Loading { $href }"/>
      <p:add-attribute match="p:declare-step" attribute-name="library" attribute-value="{$library}"/> 
      <p:filter  select="//p:declare-step"/>
   </p:for-each>
   
   <p:wrap-sequence wrapper="library">
      <p:with-input pipe="@required-steps @optional-steps"/>
      <!--<p:with-input port="source" pipe="@optional-steps"/>-->
   </p:wrap-sequence>
   
   <!-- Putting it all in no namespace to make the XSLT easier -->
   <p:namespace-delete prefixes="p"/>
   
   <p:store href="xproc-steps.xml"  serialization="map{'indent' : true()}"
      message="[COLLECT-XPROC-STEPS] Storing out/xproc-steps.xml"/>
   
   <p:sink message="[COLLECT-XPROC-STEPS] To produce HTML from this XML, run pipeline XPROC-STEP-INDEX-HTML.xpl"/>
   
</p:declare-step>