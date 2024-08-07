<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" 
   version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:TUTORIAL-PAGE"
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:html="http://www.w3.org/1999/xhtml"
   
   name="TUTORIAL-PAGE">


   <!--<p:output port="tutorial-singlepage" serialization="map{'indent': true() }" sequence="true"/>-->
   
   <p:input port="source" primary="true">
      <p:inline>
         <LESSON_PLAN>
            <Lesson key="setup"/>
            <Lesson key="unpack"/>            
            <Lesson key="oscal-convert"/>
         </LESSON_PLAN>
      </p:inline>
   </p:input>
   
   <p:variable name="ox:normalize-uri" as="function(*)"  
      xmlns:xs="http://www.w3.org/2001/XMLSchema"
      select="function($u as xs:anyURI) as xs:anyURI { xs:anyURI( replace($u,'^file:///','file:/') ) }"/>
   
   <p:for-each name="lessons">
      <p:with-input select="descendant::Lesson"/>
      <p:variable name="lesson-key" select="/*/@key"/>
      <!-- Note use of p:iteration-position to produce a sequence number
           https://spec.xproc.org/master/head/xproc/#f.iteration-position -->
      <!--<p:variable name="lesson-no" select="format-number(p:iteration-position(),'01')"/>-->

      <p:directory-list path="source/{ $lesson-key }" max-depth="unbounded" include-filter="_src\.html$"/>

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
      <p:add-attribute attribute-name="id" attribute-value="{ $lesson-key }" />
   </p:for-each>
   
   <p:wrap-sequence wrapper="sequence"/>
   
   <p:group name="full-body">

      <p:viewport match="c:file">
         <p:variable name="path" select="/*/@path"/>
         <p:variable name="project-uri" select="p:urify('.')"/>
         <p:variable name="lesson-no" select="format-number(p:iteration-position(),'01')"/>
         <!--<p:identity message="[PRODUCE-TUTORIAL-MARKDOWN] Loading {$path} "/>-->
         <p:load href="{$path}" message="[TUTORIAL-PAGE] Loading {$path} "/>

         <p:filter select="//body"/>
         <p:add-attribute attribute-name="id"
            attribute-value="{ substring-before($path,'_src.html') => replace('.*/','')}"/>
         <p:add-attribute attribute-name="class" attribute-value="unit"/>
         <p:rename match="body" new-name="section"/>
      </p:viewport>

      <p:add-attribute match="c:directory" attribute-name="class" attribute-value="lesson"/>
      <p:delete match="@xml:base | c:directory/@name"/>
      <p:rename match="body" new-name="section"/>
      <p:rename match="c:directory" new-name="section"/>
      <p:rename match="*:sequence" new-name="body"/>

      <p:namespace-rename to="http://www.w3.org/1999/xhtml"/>
      <p:namespace-delete prefixes="xsl ox c"/>

   </p:group>
   
   <p:group name="overview-div">
      <p:xslt>
         <p:with-input port="stylesheet">
            <p:inline expand-text="false">
               <xsl:stylesheet version="3.0">
                  <xsl:mode on-no-match="shallow-copy"/>
                  <xsl:template match="p | pre | ul | ol | table | details"
                     xpath-default-namespace="http://www.w3.org/1999/xhtml"/>
                  <xsl:template match="*:body">
                     <div class="toc">
                        <xsl:apply-templates/>
                        <!-- ... -->
                     </div>
                  </xsl:template>
                  <xsl:template match="*:section" expand-text="true">
                     <div>
                        <xsl:copy-of select="@*"/>
                        <xsl:apply-templates/>
                     </div>
                  </xsl:template>
               </xsl:stylesheet>
            </p:inline>
         </p:with-input>
      </p:xslt>

      <p:delete match="@id"/><!-- not getting attributes to match in my embedded XSLT ...? -->
   </p:group>
   
   <!-- Now having an 'overview' div albeit without links, we splice back in -->
   <p:insert position="first-child">
      <p:with-input port="source" pipe="@full-body"/>
      <p:with-input port="insertion" pipe="@overview-div"/>
   </p:insert>
   
   <p:wrap-sequence wrapper="html" />
   
   <p:insert position="first-child">
      <p:with-input port="insertion">
         <p:inline expand-text="false">
            <head>
               <title>TUTORIAL PREVIEW</title>
               <style type="text/css">
                  .toc { font-size: 80%; padding: 0.4em; outline: thin solid black; margin: 0.4em 0em; width: fit-content }
                  .toc * { margin: 0em; font-weight: normal }
                  .toc div { margin: 0.2em; margin-left: 1em; outline: thin solid grey }
                  .toc .lesson { display: flex }
                  .toc .unit { width: 30vw }
                  section section section { margin: 0.2em; margin-left: 1em; padding-left: 0.6em; border-left: medium solid grey }
               </style>
            </head>
         </p:inline>
      </p:with-input>
   </p:insert>
   
   <p:namespace-rename to="http://www.w3.org/1999/xhtml"/>
   
   <p:namespace-delete prefixes="xsl ox c"/>
   
   <p:store href="tutorial-preview.html" message="[TUTORIAL-PAGE] Storing tutorial-preview.html" serialization="map{ 'method': 'html', 'indent': true() }"/>
   
</p:declare-step>