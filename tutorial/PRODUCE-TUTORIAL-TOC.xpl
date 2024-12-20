<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" type="ox:PRODUCE-TUTORIAL-TOC" name="PRODUCE-TUTORIAL-TOC">


   <p:input port="source" primary="true" href="lesson-plan.xml"/>
   
   <p:output serialization="map{'indent': true(), 'method': 'text' }" sequence="true"/>
   
   <p:variable name="result-md-path" select="resolve-uri('sequence/lesson-sequence.md')"/>
   
   <p:variable name="tutorial-title" select="/*/*:title"/>
   
   <p:for-each name="lessons">
      <p:with-input select="descendant::*:Lesson"/>
      <p:variable name="lesson_key" select="/*/@key"/>
      <!-- Note use of p:iteration-position to produce a sequence number
           https://spec.xproc.org/master/head/xproc/#f.iteration-position -->
      <p:variable name="lesson-no" select="format-number(p:iteration-position(),'01')"/>
      
      <p:directory-list path="source/{ $lesson_key }" max-depth="unbounded" include-filter="_src\.html$"/>
      <p:add-attribute attribute-name="position" attribute-value="{p:iteration-position()}"/>      

      <p:label-elements match="c:file" attribute="path" label="ancestor-or-self::*/@xml:base => string-join('')"/>
      <p:viewport match="c:file">
         <p:variable name="path" select="/*/@path"/>
         <p:load href="{$path}" message="[PRODUCE-TUTORIAL-TOC] Loading {$path}"/>
         <p:variable name="track" select="/*/*/@data-track"/>
         
         <p:filter select="descendant::h1[1]"/>
         <p:rename new-name="file"/>
         <p:add-attribute attribute-name="href" attribute-value="{ replace($path,'.*/','') => replace('_src\.html$','.md') }"/>
         <p:add-attribute attribute-name="track" attribute-value="{ $track }"/>
      </p:viewport>
   </p:for-each>
   
   <p:wrap-sequence wrapper="LESSONPLAN"/>
   
   <p:namespace-delete prefixes="html xsl ox c"/>
   
   <p:xslt>
      <p:with-input port="stylesheet">
         <!-- Break out 101 sequence and 102 sequences separately -->
         <!-- Or: make this a matrix -->
         <p:inline>
            <xsl:stylesheet version="3.0">
               <xsl:template match="LESSONPLAN">
                  <body>
                     <h1 p:expand-text="true">{ $tutorial-title }</h1>
                     <xsl:apply-templates/>
                  </body>
               </xsl:template>
               <xsl:template match="directory" expand-text="true">
                  <div>
                     <h3>Lesson set {{ format-number(@position,'01') }} - {{ @name }}</h3>
                     <ul>
                        <xsl:apply-templates/>
                     </ul>
                  </div>
               </xsl:template>
               <xsl:template match="file">
                  <li>
                     <xsl:apply-templates select="." mode="link"/>
                  </li>
               </xsl:template>
               <xsl:template match="file" mode="link">
                  <a href="Lesson{{ format-number(parent::*/@position,'01') }}/{{@href}}">
                     <xsl:apply-templates/>
                  </a>                  
                  <xsl:text expand-text="true"> ({{ upper-case(@track) }})</xsl:text>
               </xsl:template>
            </xsl:stylesheet>
         </p:inline>
      </p:with-input>
   </p:xslt>
   
   <p:xslt name="make-markdown">
      <p:with-input port="stylesheet" href="src/xhtml-to-markdown.xsl"/>
   </p:xslt>
   
   <p:store href="{$result-md-path}" serialization="map{'method': 'text', 'encoding': 'us-ascii'}"
      message="[PRODUCE-TUTORIAL-TOC] Storing { $result-md-path }"/>
   <!--<p:identity message="[PRODUCE-TUTORIAL-MARKDOWN] Storing { $result-md-path }"/>-->
   
</p:declare-step>