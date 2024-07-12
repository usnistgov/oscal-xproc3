<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" 
   version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" type="ox:PRODUCE-TUTORIAL-MARKDOWN" name="PRODUCE-TUTORIAL-MARKDOWN">


   <!--<p:output serialization="map{'indent': true() }" sequence="true"/>-->
   
   <p:directory-list path="." max-depth="unbounded" include-filter="\.html$"/>
   
   <p:xslt>
      <p:with-input port="stylesheet">
         <p:inline expand-text="false">
            <xsl:stylesheet version="3.0">
               <xsl:mode on-no-match="shallow-copy"/>            
               <xsl:template match="c:file">
                  <xsl:copy>
                     <xsl:copy-of select="@*"/>
                     <xsl:attribute name="path" select="('../' || string-join(ancestor-or-self::c:*/@name,'/')) => resolve-uri()"/>
                  </xsl:copy>
               </xsl:template>
            </xsl:stylesheet>
         </p:inline>
      </p:with-input>
   </p:xslt>
   
   
   <!-- filter directory step flattens everything and excludes files in top-level /lib  -->
   
   <p:for-each name="files">
      <p:with-input select="descendant::c:file"/>
      <!-- Remember that each input node is a root for its own tree - hence XPath context -->
      <p:variable name="path" select="/*/@path"/>
      
      <!--<p:identity message="[PRODUCE-TUTORIAL-MARKDOWN] Loading {$path} "/>-->
      <p:load href="{$path}" message="[PRODUCE-TUTORIAL-MARKDOWN] Loading {$path} "/>
      
      <p:variable name="result-md-path" select="(base-uri(/*) => replace('_src\.html$','')) || '.md'"/>
      <!--<p:variable name="result-md-path"  select="(base-uri(/) => replace('\.xml$','')) || '.md'"/>-->
      
   <p:xslt name="make-markdown">
      <p:with-input port="stylesheet" href="src/xhtml-to-markdown.xsl"/>
   </p:xslt>

      <p:store href="{$result-md-path}" serialization="map{'method': 'text', 'encoding': 'us-ascii'}"
         message="[PRODUCE-TUTORIAL-MARKDOWN] Storing { $result-md-path }"/>
      <!--<p:identity message="[PRODUCE-TUTORIAL-MARKDOWN] Storing { $result-md-path }"/>-->
      
   </p:for-each>
</p:declare-step>