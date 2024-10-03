<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:c="http://www.w3.org/ns/xproc-step"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   type="ox:CONVERT-OSCAL-XML-FOLDER" name="CONVERT-OSCAL-XML-FOLDER">
   
   <p:documentation>HOUSE RULES HALL PASS - add this file to ../../testing/FILESET_XPROC3_HOUSE-RULES.xpl and remove this element</p:documentation>
   
   <!-- Note: requires XSLT at $converter-xslt (provided by ../../GRAB-OSCAL.xpl) -->
   
<!-- This pipeline reads a file system, produces a list of files, and then opens
     each for a subpipeline. The subpipeline (in the p:for-each terminal step)
     proceeds to convert each one into JSON.
   
   To convert a file from XML to JSON, copy it into the folder named in p:directory-list/@path,
   and let the pipeline find and process it.
     
   -->
   
   <p:variable name="directory-path" select="'data/catalog-model/xml'"/>

   <p:variable name="converter-xslt" select="'lib/oscal_catalog_xml-to-json-converter.xsl'"/>
   
   <!-- possible to-do - an XProc step to produce and annotate a directory-->   
   
   <p:directory-list path="{ $directory-path }" max-depth="unbounded" include-filter="\.xml$"/>

   <p:xslt>
      <p:with-input port="stylesheet">
         <p:inline expand-text="false">
            <xsl:stylesheet version="3.0">
               <xsl:mode on-no-match="shallow-copy"/>
               
               <xsl:template match="c:file">
                  <xsl:copy>
                     <xsl:copy-of select="@*"/>
                     <!-- showing the full path to each file listed in the directory -->
                     <xsl:attribute name="path" select="string-join(ancestor-or-self::*/@xml:base,'')"/>
                  </xsl:copy>
               </xsl:template>
            </xsl:stylesheet>
         </p:inline>
      </p:with-input>
   </p:xslt>
   
   
   <!--<p:store href="directory-list.xml"/>-->
   
   <p:for-each>
      <p:with-input select="/descendant::c:file"/>
      
      <p:variable name="json-file" select="replace(/*/@path,'data/','out/') => replace('xml','json')"/>
      
      <p:load message="[CONVERT-OSCAL-XML-FOLDER] Loading { /*/@path } ..." href="{ /*/@path }"/>
      
      <!-- The XSLT produces JSON ... -->
      <p:xslt>
         <p:with-input port="stylesheet" href="{$converter-xslt}"/>
         <p:with-option name="parameters" select="map{'json-indent': 'yes'}"/>
      </p:xslt>
      
      <!--<p:identity message="[CONVERT-XML-FOLDER] Writing JSON file {$json-file} -\-"/>-->
      <p:store href="{$json-file}" message="[CONVERT-OSCAL-XML-FOLDER] Writing JSON file {$json-file} --"/>      
   </p:for-each>
   
   
</p:declare-step>