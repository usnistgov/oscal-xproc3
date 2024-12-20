<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" type="ox:SOURCES-PREVIEW" name="SOURCES-PREVIEW">


   <!--<p:output serialization="map{'indent': true() }" sequence="true"/>-->

   <!--In this case a previewer needs only to aggregate all the documents, not alter them -->

   <p:directory-list path="source" max-depth="unbounded" include-filter="_src\.html$"/>

   <!-- is there a better way to annotate a directory list with full paths?
        or: make a step out of this and import it -->
   <!--<p:add-attribute match="//c:file" attribute-name="path" attribute-value="{ base-uri(.) }"/>-->
   
   <p:label-elements name="directory"
      match="c:file" attribute="path" label="ancestor-or-self::*/@xml:base => string-join('')"/>
   
   <p:for-each name="files">
      <p:with-input select="descendant::c:file"/>
      <!-- Remember that each input node is a root for its own tree - hence XPath context -->
      <p:variable name="path" select="/*/@path"/>

      <!--<p:identity message="[PRODUCE-TUTORIAL-MARKDOWN] Loading {$path} "/>-->
      <p:load href="{$path}" message="[SOURCES-PREVIEW] Loading {$path} "/>

      <!--<p:identity message="[PRODUCE-TUTORIAL-MARKDOWN] Storing { $result-md-path }"/>-->
   </p:for-each>

   <p:wrap-sequence wrapper="body" name="full-body">
      <p:with-input select="descendant::body/*"/>
   </p:wrap-sequence>

   <!--A cleaner preview production would push it all through an XSLT, but we are learning XProc so let's do it by steps -->
   <p:delete match="p | pre | ul | ol | table"/>
   
   <p:wrap match="/*" wrapper="div"/>
      
   <p:add-attribute attribute-name="class" attribute-value="overview" name="overview-div" />
   
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
                  .overview { font-size: 80%; padding: 0.4em; outline: thin solid black; margin: 0.4em 0em; width: fit-content }
                  .overview * { margin: 0em; font-weight: normal }
                  .overview section { margin: 0.2em; margin-left: 1em; outline: thin solid grey }
               </style>
            </head>
         </p:inline>
      </p:with-input>
   </p:insert>

   <p:namespace-delete prefixes="html xsl ox c"/>
   
   <p:store href="tutorial-preview.html" message="[SOURCES-PREVIEW] Storing tutorial-preview.html" serialization="map{ 'method': 'html' }"/>

</p:declare-step>