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
   
   As a bonues (not an error condition) we get a listing of XProc and XSpec files in the repository
   that are *not* in the file list - this does not error, only echoes
   
   Running this in the local repository we can keep track
   Running it under CI/CD, we get an early fail before HARDFAIL batch schematron is run
     i.e. no longer have to blow up for a file missing
   This is second-best to aligning with git directly
   -->
   
   
   
   <!-- Input: a set of files is collected dynamically via p:directory - all *.xpr files outside a directory named 'no_test' or 'no-test' -->
   <!--<p:output port="result" sequence="true" serialization="map{'indent' : true()}">
      <!-\-<p:pipe step="house-rules-check-fileset"/>
      <p:pipe step="xspec-fileset"/>-\->
      <!-\-<p:pipe step="final"/>-\->
   </p:output>-->

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
   
   
   
   <!--<p:add-attribute 
      attribute-name="house-rules-checking"
      attribute-value="{ @path }"
      match="file"/>-->
   
   <!--<p:add-attribute 
      attribute-name="house-rules-checking"
      attribute-value="{ if (=$house-rules-hrefs) then 'true' else 'false' }"
      match="file"/>
   -->
   <!--<p:add-attribute 
      attribute-name="xspec-execution"
      attribute-value="true"
      match="file[@path=$xspec-hrefs]"/>-->
   
   <!--<p:variable name="house-rule-check-fileset" select="descendant::p:document">
         <p:document href="FILESET_XPROC3_HOUSE-RULES.xpl"/>
   </p:variable>-->
   
   <!--<p:variable name="xspec-fileset" select="descendant::p:document">
      <p:with-input name="source">
         <p:document href="FILESET_XSPEC.xpl"/>
      </p:with-input>
   </p:variable>-->
   <!--
   To list files on system not named in fileset (info) read 
     $file-list 
     checking against filesets provided as paramaters
     
     results
     
   To list files in fileset not present in info
   -->
   
   <!--Make this an XQuery?-->
   
<!--  
   declare variable $house-rule-check-fileset as element(p:document)*;
   declare variable $xspec-fileset as element(p:document)*;
   
   
   <h>Files not checked for house rules under CI/CD</h>
   <ul>
   <li>{
   //c:file ! <li>{ @path }</li> 
   }</li>
   </ul>
   
   -->
   <p:xslt name="path-list">
      <p:with-input port="stylesheet">
         <p:inline expand-text="false">
            <xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               >
               <xsl:param name="for-house-rules" select="()"/>
               <xsl:param name="for-xspec" select="()"/>
               
               <xsl:mode on-no-match="shallow-copy"/>
               <xsl:variable name="file-paths" select="//@path"/>
               <xsl:template match="/">
                  <house-rules-file-set>
                     <xsl:apply-templates select="$for-house-rules"/>
                  </house-rules-file-set>
                  <xspec-fileset>
                     <xsl:apply-templates select="$for-xspec"/>
                  </xspec-fileset>
                  <xsl:apply-templates/>
               </xsl:template>
               <xsl:template match="file">
                  <xsl:copy>
                     <xsl:copy-of select="@*"/>
                     <xsl:if test="@path = $for-house-rules/@href">
                        <xsl:attribute name="house-rules-check">true</xsl:attribute>
                     </xsl:if>
                     <xsl:if test="@path = $for-xspec/@href">
                        <xsl:attribute name="xspec-execute">true</xsl:attribute>
                     </xsl:if>
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
      <p:with-option name="parameters" select="map{'for-house-rules': $house-rules-files,
                                                   'for-xspec': $xspec-files }"/>
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

