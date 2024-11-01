<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" type="ox:PRODUCE-PROJECTS-ELEMENTLIST" name="PRODUCE-PROJECTS-ELEMENTLIST">

   <!-- PRODUCE-TUTORIAL-ELEMENTLIST produces an XML file

     Listing directories in sequence, with the XProc elements first used in pipelines in that directory
     Along with an index to XProc elements in all directories
     
   -->

   <!-- Our source is a controlled list of directories wherein to find our files
        we assume alphabetical order within each subdirectory is fine -->
   <p:input port="source" primary="true">
      <p:inline>
         <SEQUENCE><!-- should align with lesson-plan.xml -->
            <project dir="../lib"/>
            <project dir="../smoketest"/>
            <project dir="../projects/oscal-convert/"/>
            <project dir="../projects/oscal-validate/"/>
            <project dir="../projects/oscal-publish/"/>
            <project dir="../projects/oscal-import/"/>
            <project dir="../projects/profile-resolution/"/>
            <project dir="../projects/xproc-doc/"/>
         </SEQUENCE>
      </p:inline>
   </p:input>
   
   <!-- /prologue -->
   
   <p:variable name="result-md-path" select="resolve-uri('sequence/element-directory.md')"/>
   
   <p:for-each name="lessons">
      <p:with-input select="descendant::project"/>
      <p:variable name="lesson_dir" select="/*/@dir"/>
      <!-- Note use of p:iteration-position to produce a sequence number
           https://spec.xproc.org/master/head/xproc/#f.iteration-position -->
      <p:variable name="lesson-no" select="format-number(p:iteration-position(),'01')"/>
      
      <p:directory-list path="{ $lesson_dir }" max-depth="unbounded" include-filter=".xpl$"/>
      <p:add-attribute attribute-name="position" attribute-value="{p:iteration-position()}"/>      
      <p:add-attribute attribute-name="dir"      attribute-value="{$lesson_dir}"/>
      
      <!-- directory list path writing step annotates c:file with full path to resource -->
      <p:label-elements match="c:file" attribute="path" label="ancestor-or-self::*/@xml:base => string-join('')"/>
      <p:delete match="c:directory[@name='lib']/c:directory"/>
      <p:viewport match="c:file">
         <p:variable name="path" select="/*/@path"/>
         <!-- Names are grabbed from the documents loaded dynamically, whee -->
         <p:variable name="names" select="//p:*/name() => distinct-values()">
            <p:document href="{ $path }"/>
         </p:variable>
         <!-- Adding this list of names to the c:file element -->
         <p:add-attribute attribute-name="elements" attribute-value="{ $names }"/>
      </p:viewport>
   </p:for-each>
   
   <p:wrap-sequence wrapper="SEQUENCE"/>

   <!-- XSLT uses an accumulator to collect element names provided per XProc file,
        annotating the c:file elements further -->
   <p:xslt>
      <p:with-input port="stylesheet">
         <p:inline expand-text="true">
            <xsl:stylesheet version="3.0">
               <xsl:mode on-no-match="shallow-copy"  use-accumulators="so-far"/>
               <xsl:accumulator name="so-far" initial-value="()">
                  <xsl:accumulator-rule match="c:file" select="$value,@elements/tokenize(.,'\s+')"/>
               </xsl:accumulator>
               <xsl:template match="c:file">
                  <xsl:variable name="already" select="preceding::c:file[1]/accumulator-before('so-far')"/>
                  <xsl:variable name="e" select="tokenize(@elements,'\s+')"/>
                  <xsl:variable name="new" select="$e[not( . = $already )]"/>
                  <xsl:copy>
                     <xsl:copy-of select="@*"/>
                     <xsl:if test="exists($new)">
                       <xsl:attribute name="introducing" select="$new"/>
                     </xsl:if>
                  </xsl:copy>
               </xsl:template>
            </xsl:stylesheet>
         </p:inline>
      </p:with-input>
   </p:xslt>
   
   <!-- Now all this information is available we can display it via another XSLT -->
   <p:xslt>
      <p:with-input port="stylesheet">
         <p:inline expand-text="false">
            <xsl:stylesheet version="3.0" expand-text="true">
               <xsl:template match="SEQUENCE">
                  <body>
                     <section style="border: thin solid black; padding: 0.4em">
                        <h1>XProc pipelines with first appearances</h1>
                        <p>Projects in this tutorial include the following pipelines. Each is listed here with the XProc elements that appear in that pipeline first, in the sequence given.</p>
                        <xsl:apply-templates/>
                     </section>
                     <section style="border: thin solid black; padding: 0.4em">
                        <h1>Index to XProc elements appearing</h1>
                        <xsl:for-each-group select="//c:file" group-by="@elements/tokenize(.,'\s+')">
                           <xsl:sort select="current-grouping-key()"/>
                           <div>
                              <h4>{ current-grouping-key() }</h4>
                              <p>
                                 <xsl:apply-templates select="current-group()" mode="anyway"/>
                              </p>
                           </div>
                        </xsl:for-each-group>
                     </section>
                  </body>
               </xsl:template>
               <xsl:template match="c:directory[empty(.//@introducing)]"/>
               <xsl:template match="c:directory" expand-text="true">
                  <div>
                     <xsl:element name="h{count(ancestor-or-self::*)}">{ ancestor-or-self::*/@name => string-join('/') }</xsl:element>
                     <xsl:where-populated>
                        <ul>
                           <xsl:apply-templates select="c:file"/>
                        </ul>
                     </xsl:where-populated>
                     <xsl:apply-templates select="c:directory"/>
                  </div>
               </xsl:template>
               <xsl:template match="c:file[empty(@introducing)]">
                  <li>
                     <b>{ @name }</b>
                  </li>
               </xsl:template>
               <xsl:template match="c:file">
                  <li>
                     <xsl:apply-templates select="." mode="link"/>
                     <xsl:text>: </xsl:text>
                     <xsl:for-each select="@introducing/tokenize(.,'\s+')">
                        <xsl:if test="not(position() eq 1)">, </xsl:if>
                        <code>{ . }</code>
                     </xsl:for-each>
                  </li>
               </xsl:template>
               <xsl:template match="c:file" mode="anyway">
                  <xsl:if test="not(position() eq 1)">, </xsl:if>
                  <span>
                     <xsl:apply-templates select="." mode="link"/>
                  </span>
               </xsl:template>
               <xsl:template match="c:file" mode="link">
                  <a href="{@path}">{ @name }</a>
               </xsl:template>
            </xsl:stylesheet>
         </p:inline>
      </p:with-input>
   </p:xslt>
   
   <!-- Cleanup -->
   <p:namespace-delete prefixes="xsl ox c"/>
   
   <!-- Making Markdown -->
   <p:xslt name="make-markdown">
      <p:with-input port="stylesheet" href="src/xhtml-to-markdown.xsl"/>
   </p:xslt>
   
   <!-- Saving that -->
   <p:store href="{$result-md-path}" serialization="map{'method': 'text', 'encoding': 'us-ascii'}"
      message="[PRODUCE-PROJECTS-ELEMENTLIST] Storing { $result-md-path }"/>
   
   <!--<p:identity message="[PRODUCE-TUTORIAL-MARKDOWN] Storing { $result-md-path }"/>-->
   
</p:declare-step>