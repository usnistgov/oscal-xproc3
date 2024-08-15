<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" 
   version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:PRODUCE-TUTORIAL-MARKDOWN"
   name="PRODUCE-TUTORIAL-MARKDOWN">


   <!--<p:output serialization="map{'indent': true() }" sequence="true"/>-->
   
   <p:input port="source" primary="true">
      <p:inline>
         <LESSON_PLAN>
            <Lesson key="setup"/>
            <Lesson key="unpack"/>            
            <Lesson key="oscal-convert"/>
            <Lesson key="oscal-validate"/>
         </LESSON_PLAN>
      </p:inline>
   </p:input>
   
   <p:variable name="ox:normalize-uri" as="function(*)"  
      xmlns:xs="http://www.w3.org/2001/XMLSchema"
      select="function($u as xs:anyURI) as xs:anyURI { xs:anyURI( replace($u,'^file:///','file:/') ) }"/>
   
   <p:for-each name="lessons">
      <p:with-input select="descendant::Lesson"/>
      <p:variable name="lesson_key" select="/*/@key"/>
      <!-- Note use of p:iteration-position to produce a sequence number
           https://spec.xproc.org/master/head/xproc/#f.iteration-position -->
      <p:variable name="lesson-no" select="format-number(p:iteration-position(),'01')"/>

      <p:directory-list path="source/{ $lesson_key }" max-depth="unbounded" include-filter="_src\.html$"/>

      <!-- is there a better way to annotate a directory list with full paths?
        or: make a step out of this and import it -->
      <p:xslt>
         <p:with-input port="stylesheet">
            <p:inline expand-text="false">
               <xsl:stylesheet version="3.0">
                  <xsl:mode on-no-match="shallow-copy"/>
                  <xsl:template match="c:file">
                     <xsl:copy>
                        <xsl:copy-of select="@*"/>
                        <xsl:attribute name="path"
                           select="('source/' || string-join(ancestor-or-self::c:*/@name,'/')) => resolve-uri()"/>
                     </xsl:copy>
                  </xsl:template>
               </xsl:stylesheet>
            </p:inline>
         </p:with-input>
      </p:xslt>

      <p:for-each name="files">
         <p:with-input select="descendant::c:file"/>
         <!-- Remember that each input node is a root for its own tree - hence XPath context -->
         <p:variable name="path" select="/*/@path => p:urify()"/>
         <p:variable name="project-uri" select="p:urify('.')"/>
         
         <!--<p:identity message="[PRODUCE-TUTORIAL-MARKDOWN] Loading {$path} "/>-->
         <p:load href="{$path}" message="[PRODUCE-TUTORIAL-MARKDOWN] Loading {$path} "/>

         <p:variable name="result-md-filename"
            select="base-uri() => replace('.*/','') => replace('_src\.html$','.md')"/>
         <!--<p:identity message="$path is { $path }"/>-->
         <!--<p:identity message="$project-uri is { $project-uri }"/>-->
         
         <p:variable name="result-md-path" select="('sequence',('Lesson' || $lesson-no), $result-md-filename) => string-join('/') => resolve-uri()"/>

         <!-- binding html namespace here so it can be unprefixed - less clutter -->
         <p:insert match="body" position="first-child" xmlns="http://www.w3.org/1999/xhtml">
            <p:with-input port="insertion">
               <p:inline>
               <blockquote>
                  <p><i>Warning:</i> this Markdown file will be rewritten under continuous deployment (CD): edit the source in <a href="../../..{substring-after($path,$project-uri)}">{substring-after($path,$project-uri)}</a>.</p>
                  <p>To create a persistent copy (for example, for purposes of annotation) save this file out elsewhere, and edit the copy.</p>
               </blockquote>
               </p:inline>
            </p:with-input>
         </p:insert>
         
         <!--Rewriting cross-referencing links from HTML to presumed Markdown file targets -->
         <!-- This is of course so that GH can rewrite the Markdown links back into HTML links! -->
         
         <p:string-replace name="link-rewrite"
            match="a[@class='LessonUnit']/@href"  xmlns="http://www.w3.org/1999/xhtml"
            replace="replace(.,'_src\.html','.md')"/>
         
         <p:xslt name="make-markdown" initial-mode="md">
            <p:with-input port="stylesheet" href="src/xhtml-to-markdown.xsl"/>
         </p:xslt>

         <!-- Since 'md' mode delivers <string> elements wanting whitespace, we provide it here -->
         <p:insert match="ox:string" position="after">
            <p:with-input port="insertion">
               <p:inline>&#xA;</p:inline>
            </p:with-input>
         </p:insert>

         <p:store href="{$result-md-path}" serialization="map{'method': 'text', 'encoding': 'us-ascii'}"
         message="[PRODUCE-TUTORIAL-MARKDOWN] Storing { $result-md-path }"/>
         <!--<p:identity message="[PRODUCE-TUTORIAL-MARKDOWN] Storing { $result-md-path }"/>-->
      </p:for-each>

   </p:for-each>
   
   
   
</p:declare-step>