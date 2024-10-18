<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:c="http://www.w3.org/ns/xproc-step"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   type="ox:CONVERT-OSCAL-XML-FOLDER" name="CONVERT-OSCAL-XML-FOLDER">

   
   <!-- Note: requires XSLT at $converter-xslt (provided by ../../GRAB-OSCAL.xpl) -->
   
<!-- This pipeline reads a file system, produces a list of files, and then opens
     each for a subpipeline. The subpipeline (in the p:for-each terminal step)
     proceeds to convert each one into JSON.
   
   To convert a file from XML to JSON, copy it into the folder named in p:directory-list/@path,
   and let the pipeline find and process it.
     
   -->
   
   <p:import href="CONVERT-OSCAL-XML-DATA.xpl"/>
   
   <p:option name="directory-path" select="'data/catalog-model/xml'"/>

   <!-- We strip XML and deliver plain text to the output port, since the main results are side effects
        (files written by the imported pipeline) -->
   <p:output port="result" sequence="true"
      serialization="map{ 'omit-xml-declaration': true(), 'method': 'text' }"/>
   
   <!-- /prologue -->
   
   <!-- INCIPIT!--> 
   
   <p:directory-list path="{ $directory-path }" max-depth="unbounded" include-filter="\.xml$"/>

   <!-- directory list path writing step annotates c:file with full path to resource -->
   <p:label-elements match="c:file" attribute="path" label="ancestor-or-self::*/@xml:base => string-join('')"/>
   
   <!-- that p:label-elements replaces this entire thing! <p:xslt>
      <p:with-input port="stylesheet">
         <p:inline expand-text="false">
            <xsl:stylesheet version="3.0">
               <xsl:mode on-no-match="shallow-copy"/>
               
               <xsl:template match="c:file">
                  <xsl:copy>
                     <xsl:copy-of select="@*"/>
                     <!-\- showing the full path to each file listed in the directory -\->
                     <xsl:attribute name="path" select="string-join(ancestor-or-self::*/@xml:base,'')"/>
                  </xsl:copy>
               </xsl:template>
            </xsl:stylesheet>
         </p:inline>
      </p:with-input>
   </p:xslt>-->
   
   <p:for-each name="found-xml">
      <p:with-input select="/descendant::c:file"/>
      <!-- By trying one at a time we can convert the ones that pass, catching the ones that do not -->
      <p:try>
         <p:group>
            <p:variable name="path" select="/*/@path"/>
            <p:load message="[CONVERT-OSCAL-XML-FOLDER] Loading { /*/@path } ..." href="{ /*/@path }"/>
            <ox:CONVERT-OSCAL-XML-DATA/>
            <p:identity name="success" message="[CONVERT-OSCAL-XML-FOLDER] Successfully converted { $path }">
               <p:with-input><p:empty/></p:with-input>
            </p:identity>
         </p:group>
         <p:catch name="conversion-error">
            <p:identity>
               <p:with-input pipe="error@conversion-error" select="//c:error/*"/>
            </p:identity>
         </p:catch>
      </p:try>
            
   </p:for-each>
   
   
   
</p:declare-step>