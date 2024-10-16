<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:REPO-FILESET-CHECK"
   name="REPO-FILESET-CHECK"
   ><!--
   --><p:documentation>HOUSE RULES HALL PASS - add this file to ../../testing/FILESET_XPROC3_HOUSE-RULES.xpl and remove this element</p:documentation>
   
   <!--
   High-level validation pipeline for checking the repository against the file sets
   
   We get an early clean fail if any files listed in a file set are not here in the repo
   
   As a bonus (not an error condition) we get a listing of XProc and XSpec files in the repository
   that are *not* in the file list - this does not error, only echoes
   
   Running this in the local repository we can keep track
   Running it under CI/CD, we get an early fail before HARDFAIL batch schematron is run
     i.e. no longer have to blow up for a file missing
   This is second-best to aligning with git directly
   -->

  <!-- <p:output port="result" serialization="map{ 'indent': true() }"/> -->
   
<!-- /prologue -->
<!-- INCIPIT  -->

<p:group name="house-rules-check-fileset">
   <p:load href="FILESET_XPROC3_HOUSE-RULES.xpl"/>
   <!--<p:filter select="descendant::p:document"/>-->
   <p:make-absolute-uris match="@href"/>
</p:group>

   <p:variable name="house-rules-files" select="//@href/..">
      <p:pipe step="house-rules-check-fileset"/>
   </p:variable>
   <!-- -->
   
   <p:group name="xspec-fileset">
      <p:load href="FILESET_XSPEC.xpl"/>
      <!--<p:filter select="descendant::p:document"/>-->
      <p:make-absolute-uris match="@href"/>
   </p:group>
   
   <p:variable name="xspec-files" select="//@href/..">
      <p:pipe step="xspec-fileset"/>
   </p:variable>
   
   
   <p:directory-list name="dir-list" path=".." max-depth="unbounded" include-filter="\.x(pl|spec)$" exclude-filter=".*no[-_]test.*"/>
   
   <!-- filter directory step flattens everything and excludes files in top-level /lib  -->
   <p:xslt name="file-list">
      <p:with-input port="stylesheet" href="src/filter-directory.xsl"/>
   </p:xslt>
   

   <!-- Next step annotates the directory structure based on findings passed in -->
   <p:xslt name="path-list">
      <p:with-input port="stylesheet">
         <p:inline expand-text="false">
            <xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:map="http://www.w3.org/2005/xpath-functions/map">
               <xsl:param name="file-lists" select="()" as="map(*)?"/>
               
               <xsl:mode on-no-match="shallow-copy"/>
               <xsl:variable name="file-paths" select="//@path"/>
               <xsl:template match="/">
                  <SURVEY>
                     <xsl:for-each select="map:keys($file-lists)">
                        <document-set name="{ . }">
                           <xsl:apply-templates select="$file-lists(.)"/>
                        </document-set>
                     </xsl:for-each>
                     <xsl:apply-templates/>
                  </SURVEY>
               </xsl:template>
               <xsl:template match="file">
                  <xsl:variable name="here" select="."/>
                  <xsl:copy>
                     <xsl:copy-of select="@*"/>
                     <xsl:iterate select="map:keys($file-lists)">
                        <xsl:if test="$here/@path = $file-lists(.)/@href">
                           <xsl:attribute name="{ . }">true</xsl:attribute>
                        </xsl:if>
                     </xsl:iterate>
                  </xsl:copy>
               </xsl:template>
               <xsl:template match="p:document">
                  <document in-place="{ @href = $file-paths }">
                     <xsl:copy-of select="@*"/>
                  </document>
               </xsl:template>
            </xsl:stylesheet>
         </p:inline>
      </p:with-input>
      <p:with-option name="parameters" select="map{
         
         'file-lists': map{ 'house-rules': $house-rules-files,
                         'xspec': $xspec-files } }"/>
   </p:xslt>
      
   <p:namespace-delete prefixes="c p ox"/>
   
   <p:choose>
      <p:when test="exists(descendant::document[@in-place='false'])">
         <p:error code="ox:missing-resource">
            <p:with-input>               
               <message>[REPO-FILESET-CHECK.xpl] Missing files for validation or checking:{'&#xA;'}{ descendant::document[@in-place='false']/@href => string-join('&#xA;') }</message>
            </p:with-input>
         </p:error>
      </p:when>
      <p:otherwise>
         <p:identity message="[REPO-FILESET-CHECK.xpl] File sets for validation check out on this system - TESTING SYSTEMS GO"/>
      </p:otherwise>
   </p:choose>
               

   <p:identity name="final"/>

</p:declare-step>

