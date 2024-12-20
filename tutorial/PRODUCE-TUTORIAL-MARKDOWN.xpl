<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" 
   version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:PRODUCE-TUTORIAL-MARKDOWN"
   name="PRODUCE-TUTORIAL-MARKDOWN">


   <p:output serialization="map{'indent': true() }" sequence="true"/>
   
   <p:input port="source" primary="true" href="lesson-plan.xml"/>
   
   <p:for-each name="lessons">
      <p:with-input select="descendant::Lesson"/>
      <p:variable name="lesson_key" select="/*/@key"/>
      <!-- Note use of p:iteration-position to produce a sequence number
           https://spec.xproc.org/master/head/xproc/#f.iteration-position -->
      <p:variable name="lesson-no" select="format-number(p:iteration-position(),'01')"/>

      <p:directory-list  path="source/{ $lesson_key }" max-depth="unbounded" include-filter="(_src\.html|png)$"/>

      <!-- currently in lieu of p:make-absolute-uris -->
      <p:label-elements name="directory"
         match="c:file" attribute="path" label="ancestor-or-self::*/@xml:base => string-join('')"/>
      
            
      <p:for-each name="files">
         <p:with-input select="descendant::c:file[ends-with(@path,'_src.html')]"/>
         <!-- Remember that each input node is a root for its own tree - hence XPath context -->
         <p:variable name="path" select="/*/@path => resolve-uri() => p:urify()"/>
         <p:variable name="project-uri" select="resolve-uri('.') => p:urify()"/>
         
         <!--<p:identity message="[PRODUCE-TUTORIAL-MARKDOWN] Loading {$path} "/>-->
         <p:load href="{$path}" message="[PRODUCE-TUTORIAL-MARKDOWN] Loading {$path} "/>

         <!-- for debugging: <p:identity message="[PRODUCE-TUTORIAL-MARKDOWN] $path is ......: { $path }"/>
         <p:identity message="[PRODUCE-TUTORIAL-MARKDOWN] $project-uri is: { $project-uri }"/>-->
         
         <p:variable name="result-md-filename"
            select="base-uri() => replace('.*/','') => replace('_src\.html$','.md')"/>
         <p:variable name="result-md-path" select="('sequence',('Lesson' || $lesson-no), $result-md-filename) => string-join('/') => resolve-uri()"/>

         <!-- binding html namespace here so it can be unprefixed - less clutter -->
         <p:insert match="body" position="first-child" xmlns="http://www.w3.org/1999/xhtml">
            <p:with-input port="insertion">
               <p:inline>
               <blockquote>
                  <p><i>Warning:</i> this Markdown file will be rewritten under continuous deployment (CD): edit the source in <a href="../../{substring-after($path,$project-uri)}">../../{ substring-after($path,$project-uri)}</a>.</p>
                  <p>Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).</p>
               </blockquote>
               </p:inline>
            </p:with-input>
         </p:insert>
         
         <!--Rewriting cross-referencing links from HTML to presumed Markdown file targets -->
         <!-- This is of course so that GH can rewrite the Markdown links back into HTML links! -->
         
         <p:string-replace name="link-rewrite"
            match="a[@class='LessonUnit']/@href"  xmlns="http://www.w3.org/1999/xhtml"
            replace="replace(.,'_src\.html','.md')"/>
         
         <p:xslt name="make-markdown">
            <p:with-input port="stylesheet" href="src/xhtml-to-markdown.xsl"/>
         </p:xslt>

         <!-- Since 'md' mode delivers <string> elements wanting whitespace, we provide it here -->
         <!--<p:insert match="ox:string" position="after">
            <p:with-input port="insertion">
               <p:inline>&#xA;</p:inline>
            </p:with-input>
         </p:insert>-->

         <!-- Unwrap everything -->
         <!--<p:unwrap match="*"/>-->
         
         <!-- Shocking that this works, needing some explanation -->
         
         <!--<p:cast-content-type content-type="text/plain"/>-->
         
         <p:text-replace pattern="â€“" replacement="&amp;mdash;"/>
         
         <!--<p:text-replace pattern="–" replacement="&amp;mdash;"/>-->
         
         <p:store href="{$result-md-path}" serialization="map{'method': 'text', 'encoding': 'utf-8'}"
         message="[PRODUCE-TUTORIAL-MARKDOWN] Storing { $result-md-path }"/>
         <!--<p:identity message="[PRODUCE-TUTORIAL-MARKDOWN] Storing { $result-md-path }"/>-->
      </p:for-each>

      <p:for-each name="graphics">
         <p:with-input select="descendant::c:file[ends-with(@path,'.png')]">
            <p:pipe port="result" step="directory"/>
         </p:with-input>
         <!-- Remember that each input node is a root for its own tree - hence XPath context -->
         <p:variable name="path" select="/*/@path => p:urify()"/>
         <!--<p:variable name="project-uri" select="p:urify('.')"/>-->
         
         <p:variable name="filename" select="replace($path,'.*/','')"/>
         <!--<p:identity message="$path is { $path }"/>-->
         <!--<p:identity message="$project-uri is { $project-uri }"/>-->
         
         <p:variable name="target-path" select="('sequence',('Lesson' || $lesson-no), $filename) => string-join('/') => resolve-uri()"/>
         
         <p:file-copy href="{$path}" target="{$target-path}"/>
         
         <!--p:sink inhibits p:file-copy from reporting to result -->         
         <p:sink  message="[PRODUCE-TUTORIAL-MARKDOWN] Copied { $path } into Lesson { $lesson-no }"/>
      </p:for-each>

   </p:for-each>
   
</p:declare-step>