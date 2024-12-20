<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" 
   version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:PRODUCE-TUTORIAL-PREVIEW"
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:html="http://www.w3.org/1999/xhtml"
   name="PRODUCE-TUTORIAL-PREVIEW">

   <p:input port="source" primary="true">
      <p:document href="lesson-plan.xml"/>
      <!--<p:inline>
      <LESSON_PLAN>
         <Lesson key="setup"/>
         <Lesson key="unpack"/>            
         <Lesson key="oscal-convert"/>
         <Lesson key="oscal-validate"/>
         <Lesson key="oscal-publish"/>
      </LESSON_PLAN>
      </p:inline>-->
   </p:input>
   
   <!--<p:output port="tutorial-singlepage" pipe="@full-body" serialization="map{'indent': true() }" sequence="true"/>-->
   
   <p:variable name="lesson-plan" select="/*"/>
   
   <p:for-each name="lessons">
      <p:with-input select="descendant::*:Lesson"/>
      <!-- Lesson map is in no namespace, while currently we are defaulting to XHTML, hence *:Lesson -->
      <p:variable name="lesson-key" select="/*/@key"/>
      <!-- Note use of p:iteration-position to produce a sequence number
           https://spec.xproc.org/master/head/xproc/#f.iteration-position -->
      <!--<p:variable name="lesson-no" select="format-number(p:iteration-position(),'01')"/>-->

      <p:directory-list path="source/{ $lesson-key }" max-depth="unbounded" include-filter="_src\.html$"/>

      <!-- directory list path writing step annotates c:file with full path to resource -->
      <p:label-elements match="c:file" attribute="path" label="ancestor-or-self::*/@xml:base => string-join('')"/>
      
      <p:add-attribute attribute-name="id" attribute-value="{ $lesson-key }" />
   </p:for-each>
   
   <p:wrap-sequence wrapper="sequence"/>
   
   <p:group name="full-body">
      <p:viewport match="c:file">
         <p:variable name="path" select="/*/@path"/>
         <p:variable name="lesson-no" select="format-number(p:iteration-position(),'01')"/>

         <!-- Each file is resolved and its contents (body) loaded -->
         <p:load href="{$path}" message="[PRODUCE-TUTORIAL-PREVIEW] Loading {$path} "/>
         <p:filter select="descendant::body"/>
         <p:make-absolute-uris match="a/@href"/>
         <p:add-attribute match="/*" attribute-name="id"
            attribute-value="{ substring-before($path,'_src.html') => replace('.*/','')}"/>
         <p:add-attribute attribute-name="class" attribute-value="unit { /*/@data-track }"/>
         <p:rename match="body" new-name="section"/>
      </p:viewport>
      <p:add-attribute match="c:directory" attribute-name="class" attribute-value="lesson"/>      
      <!--<p:rename match="c:directory/@name" new-name="id"/>-->
      <p:delete match="@xml:base"/>
      <p:rename match="body" new-name="section"/>
      <p:rename match="c:directory" new-name="section"/>
      <!-- Rather than match 'section' (which doesn't work) or '*:section' (which does), we just rename the element at the top -->
      <p:rename match="/*" new-name="body"/>
      <!-- Applying namespace-rename to 'all' puts attributes in the XHTML namespace, outside the scope of default matching
           so we leave attributes in no-namespace -->
      <p:namespace-rename to="http://www.w3.org/1999/xhtml" apply-to="elements"/>
      <p:namespace-delete prefixes="xsl ox c"/>
   </p:group>
   
   <p:group name="overview-div">
      <p:xslt>
         <p:with-input port="stylesheet">
            <p:inline expand-text="false">
               <xsl:stylesheet version="3.0" expand-text="true"
                  xpath-default-namespace="http://www.w3.org/1999/xhtml">
                  <xsl:mode on-no-match="shallow-copy"/>                  
                  <xsl:template match="p | pre | ul | ol | table | details"/>
                  <xsl:template match="attribute::id">
                     <xsl:attribute name="id">toc-{ . }</xsl:attribute>
                  </xsl:template>      
                  <xsl:template match="body">
                     <div class="toc">
                        <xsl:apply-templates select="*"/>
                     </div>
                  </xsl:template>
                  <xsl:template match="section">
                     <div>
                        <xsl:apply-templates select="@*"/>
                        <xsl:apply-templates select="*"/>
                     </div>
                  </xsl:template>
                  <xsl:template match="h1">
                     <xsl:variable name="wordcount" select="string(parent::*) => tokenize('\s+') => count()"/>
                     <xsl:copy>
                        <xsl:apply-templates select="@*"/>
                        <xsl:apply-templates/>
                        <span class="wordcount { if ($wordcount gt 2000) then 'over' else 'okay' }">
                        <xsl:text expand-text="true"> (~{ $wordcount })</xsl:text>
                        </span>
                     </xsl:copy>
                  </xsl:template>
               </xsl:stylesheet>
            </p:inline>
         </p:with-input>
      </p:xslt>

      <!--<p:delete match="@id"/>-->
      <!--<p:add-attribute match="div" attribute-name="id" attribute-value="toc-{ /*/@id }"/>--><!-- not getting attributes to match in my embedded XSLT ...? -->
   </p:group>
   
   
   <!-- Now having an 'overview' div albeit without links, we splice back in -->
   <p:insert position="first-child">
      <p:with-input port="source" pipe="@full-body"/>
      <!--<p:with-input port="insertion" pipe="@overview-div"/>-->
      <p:with-input port="insertion">
         <p:inline>
            <h1>{ $lesson-plan/*:title/string(.) }</h1>
            <h3>version { $lesson-plan/*:version/string(.) } PREVIEW { current-date() => format-date('[MNn] [D] [Y]') }</h3>
         </p:inline>
         <p:pipe step="overview-div"/>
      </p:with-input>
   </p:insert>
   
   <p:wrap-sequence wrapper="html" />
   
   <!-- Please consider whether it is not overdue to factor all this out into XSLT ... -->
   
   <p:insert position="first-child">
      <p:with-input port="insertion">
         <p:inline expand-text="false">
            <head>
               <title>TUTORIAL PREVIEW</title>
               <style type="text/css" xml:space="preserve">
.toc { font-size: 70%; padding: 0.4em; outline: thin solid black; margin: 0.4em 0em; width: fit-content; counter-reset: lessonNo 0; font-family: sans-serif }
.toc * { margin: 0em; font-weight: normal }
.toc div { margin: 0.2em; margin-left: 1em; outline: thin solid grey; height: fit-content }
.toc .lesson { display: grid; grid-template-columns: 1fr repeat(3,3fr); counter-increment: lessonNo 1; padding: 0.8em }
.toc .lesson:nth-child(even) { background-color: lightsteelblue }
.toc div.lesson:before { content: attr(class) '&#xa0;' counter(lessonNo) ': ' attr(name); background-color: lavender; color: midnightblue; padding: 0.2em; font-family: sans-serif; display: inline-block; height: fit-content }
.toc .unit { clamp(12vw, 100%, 24vw) }
section section section { margin: 0.2em; margin-left: 1em; padding-left: 0.6em; border-left: medium solid grey }

table { width: 80vw; resize: horizontal; padding: 0.8em; background-color: whitesmoke; position: relative; border: thin solid grey; overflow: auto; display: inherit }
tr:nth-child(even) { background-color: gainsboro }


th { width: clamp(10em, auto, 40em) }
td { width: clamp(10em, auto, 40em); border-top: thin solid grey }

section.unit   { width: clamp(45ch, 100%, 75ch); padding: 0.8em; outline: thin solid black; margin: 0.6em 0em }
section.unit h1:first-child { margin-top: 0em }
.observer { background-color: honeydew ; grid-column: 2 }
.maker    { background-color: seashell ; grid-column: 3 }
.learner  { background-color: aliceblue; grid-column: 4 }                 
           
span.wordcount { font-size: smaller; font-weight: bolder; font-style: italic; break-inside: avoid }
span.wordcount.over { color: darkred }

</style>
            </head>
         </p:inline>
      </p:with-input>
   </p:insert>
   
   <!-- apply-to="elements" prevents attributes being cast -->
   <p:namespace-rename to="http://www.w3.org/1999/xhtml" apply-to="elements"/>
   
   <p:namespace-delete prefixes="xsl ox c"/>
   

   <!-- Rewriting @href from absolute to relative -->

   <p:variable name="project-uri" select="resolve-uri('..', static-base-uri()) => replace('/+','/')"/>
   
   <!--Doing this with a viewport so XPath context will be each 'a'
       not the document (on default readable port) -->
   <!--<p:viewport match="a">
      <p:variable name="file-href" select="/*/@href"/>
      <p:variable name="relative-href" select="substring-after($file-href,$project-uri)"/>
      <p:add-attribute match="/*" attribute-name="href" attribute-value="../{ $relative-href }"/>
   </p:viewport>-->
   
   <!--Alternatively, constructing an XPath for the new value -->
   <p:label-elements match="a" attribute="href" replace="true"
      label="('..', substring-after(@href,'{$project-uri}')) => string-join('/')"/>
   
   <p:store href="tutorial-preview.html" message="[PRODUCE-TUTORIAL-PREVIEW] Storing tutorial-preview.html" serialization="map{ 'method': 'html', 'indent': true() }"/>
   
</p:declare-step>