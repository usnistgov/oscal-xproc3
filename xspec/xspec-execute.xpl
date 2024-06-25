<?xml version="1.0" encoding="UTF-8"?>
<p:library xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:x="http://www.jenitennison.com/xslt/xspec"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

   <!-- XProc 3.0 rendition of saxon-xslt-harness -->
   <!-- Credit: Florent Georges is the author of the original XProc 1.0 XSpec testing harnesses,
        which this code (in its first iteration) sets out to emulate
   
   NB: variable references locate XSLT and other resources in the XSpec distribution -
    take care to see these links are adjusted as necessary. -->
   
   <p:import href="../lib/schxslt-1.9.5/xproc/3.0/library.xpl"/>
   
   <!-- Providing a relative path to XSpec (top-level directory) on this system. with trailing slash -->   
   <p:option name="xspec-home" select="'../lib/xspec-3.0.3/'" static="true"/>
   
   <p:declare-step name="xslt-xspec-execute" type="ox:xslt-xspec-execute">      
      <p:input port="xspec-source" primary="true" content-types="application/xml"/>      
      <p:output port="xspec-html-report" primary="true" pipe="result@html-report"/>
      <p:output port="xspec-junit-report" primary="false" pipe="result@junit-report"/>
      
      <!-- These paths are sensitive to the XSpec distribution at $xspec-home - take care -->
      <p:variable name="compiler-xslt"  select="$xspec-home || 'src/compiler/compile-xslt-tests.xsl'"/>
      <p:variable name="xspec-file-path" select="base-uri(/)"/>
      
      <p:xslt name="compile-xspec">
         <p:with-input port="stylesheet" href="{ $compiler-xslt }"/>
      </p:xslt>
      <!-- A small adjustment to the compiled XSLT wakes up the 'secondary' port where we can see it ...  -->
      <p:add-attribute name="adjusted-runtime"
         match="/*/xsl:template[@name='Q{{http://www.jenitennison.com/xslt/xspec}}main']/xsl:result-document"
         attribute-name="href" attribute-value="report" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"/>
      <!-- Run the XSLT -->
      <p:xslt name="execute-xspec"
         message="[xslt-xspec-execute] Executing XSPec { base-uri(/) } testing XSLT { /*/@stylesheet }">
         <p:with-input port="source">
            <p:empty/>
         </p:with-input>
         <p:with-input port="stylesheet" pipe="result@adjusted-runtime"/>
         <p:with-option name="template-name" select="'Q{http://www.jenitennison.com/xslt/xspec}main'"/>
      </p:xslt>
      <!-- Picking up this result and putting it back on the primary port. -->
      <p:identity name="xspec-report">
         <p:with-input port="source" pipe="secondary@execute-xspec"/>
      </p:identity>

      <ox:produce-html-report name="html-report"/>
      <p:sink/>
      
      <ox:produce-junit-report name="junit-report">
         <p:with-input port="source" pipe="result@xspec-report"/>
      </ox:produce-junit-report>
   </p:declare-step>
   
   <p:declare-step name="xquery-xspec-execute" type="ox:xquery-xspec-execute">      
      <p:input port="xspec-source" primary="true" content-types="application/xml"/>
      
      <p:output port="xspec-html-report" primary="true" pipe="result@html-report"/>
      <p:output port="xspec-junit-report" primary="false" pipe="result@junit-report"/>
      
      <p:variable name="compiler-xslt"  select="$xspec-home || 'src/compiler/compile-xquery-tests.xsl'"/>
      <p:variable name="xspec-file-path" select="base-uri(/)"/>
      <p:variable name="xquery-target-path" select="resolve-uri(/*/@query-at,$xspec-file-path)"/>
      
      <p:xslt name="compiled-xspec">
         <p:with-input port="source" pipe="xspec-source@xquery-xspec-execute"/>
         <p:with-input port="stylesheet" href="{$compiler-xslt}"/>
         <p:with-option name="parameters" select="map { 'query-at': $xquery-target-path }"/>
      </p:xslt>
      <p:xquery name="execute-xspec" message="[xquery-xspec-execute] Executing XQuery XSpec - no runtime messages, sorry">
         <p:with-input port="query" pipe="result@compiled-xspec"/>
      </p:xquery>
      <p:identity name="xspec-report"/>
      
      
      <ox:produce-html-report name="html-report"/>
      <p:sink/>
      
      <ox:produce-junit-report name="junit-report">
         <p:with-input port="source" pipe="result@xspec-report"/>
      </ox:produce-junit-report>
   </p:declare-step>
   
   <p:declare-step name="schematron-xspec-execute" type="ox:schematron-xspec-execute">      
      <p:input port="xspec-source" primary="true" content-types="application/xml"/>
      
      <p:output port="xspec-html-report"  primary="true"  pipe="result@html-report"/>
      <p:output port="xspec-junit-report" primary="false" pipe="result@junit-report"/>
      
      <!-- These paths are sensitive to the XSpec distribution at $xspec-home - take care -->
      <p:variable name="schematron-xspec-reducer-xslt"  select="$xspec-home || 'src/schematron/schut-to-xspec.xsl'"/>
      <p:variable name="compiler-xslt"  select="$xspec-home || 'src/compiler/compile-xslt-tests.xsl'"/>
      
      <p:variable name="xspec-file-path" select="base-uri(/)"/>
      <p:variable name="target-schematron-path" select="/*/@schematron"/>
      
      <schxslt:compile-schematron name="target-schematron-xslt" xmlns:schxslt="https://doi.org/10.5281/zenodo.1495494">
         <p:with-input port="source" href="{ resolve-uri($target-schematron-path, $xspec-file-path) }"/>
      </schxslt:compile-schematron>
      <p:sink/>
      
      <p:variable name="schematron-xslt" select="/" pipe="result@target-schematron-xslt"/>
      <p:variable name="schematron-xslt-uri" select="base-uri($schematron-xslt) => replace('\.sch$','-sch.xslt')"/>
      
      <!-- Pick up XSpec for Schematron and reduce to XSpec for XSLT -->
      <p:xslt name="reduce-schematron-xspec">
         <p:with-input port="source" pipe="xspec-source@schematron-xspec-execute"/>
         <p:with-input port="stylesheet" href="{ $schematron-xspec-reducer-xslt }"/>
         <p:with-option name="parameters" select="map { 'stylesheet-uri': $schematron-xslt-uri }"/>
      </p:xslt>
      <!-- compile this as an XSLT XSpec -->
      <p:xslt name="compile-xspec">
         <p:with-input port="stylesheet" href="{ $compiler-xslt }"/>
      </p:xslt>
      <!-- Next rewrite the XSLT to include templates (and all) from the target Schematron-compiled-as-XSLT
           in place of the xsl:import --> 
      <p:xslt name="import-rewrite" message="[xspec-execute] importing XSLT into XSpec...">
         <p:with-option name="parameters" select="map { 'imported': $schematron-xslt }"/>
         <p:with-input port="stylesheet" href="xspec-expand-import.xsl"/>            
      </p:xslt>
      <!-- As above, a small adjustment to the compiled XSLT wakes up the 'secondary' port where we can see it ...  -->
      <p:add-attribute name="adjusted-runtime"
         match="/*/xsl:template[@name='Q{{http://www.jenitennison.com/xslt/xspec}}main']/xsl:result-document"
         attribute-name="href" attribute-value="report" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"/>
      <!-- Now, execute -->
      <p:xslt name="execute-xspec" message="[schematron-xspec-execute] Executing XSPec { $xspec-file-path } testing Schematron { resolve-uri($target-schematron-path, $xspec-file-path) } ">
         <p:with-input port="source">
            <p:empty/>
         </p:with-input>
         <p:with-input port="stylesheet" pipe="result@adjusted-runtime"/>
         <p:with-option name="template-name" select="'Q{http://www.jenitennison.com/xslt/xspec}main'"/>
      </p:xslt>
      <p:identity name="xspec-report">
         <p:with-input port="source" pipe="secondary@execute-xspec"/>
      </p:identity>
      
      <ox:produce-html-report name="html-report"/>      
      <p:sink/>
      
      <ox:produce-junit-report name="junit-report">
         <p:with-input port="source" pipe="result@xspec-report"/>
      </ox:produce-junit-report>
   </p:declare-step>
   
   <p:declare-step name="xspec-execute" type="ox:xspec-execute">
      <p:input port="xspec-source" primary="true" content-types="application/xml"/>
      <p:output port="xspec-html-report" primary="true" pipe="xspec-html-report@switcher"/>
      <p:output port="xspec-junit-report" primary="false" pipe="xspec-junit-report@switcher"/>

      <p:choose name="switcher">
         <p:when test="exists(/x:description/@schematron)">
            <p:output port="xspec-html-report" primary="true"   pipe="xspec-html-report@schematron-xspec-execute"/>
            <p:output port="xspec-junit-report" primary="false" pipe="xspec-junit-report@schematron-xspec-execute"/>
            <ox:schematron-xspec-execute name="schematron-xspec-execute"/>
         </p:when>
         <p:when test="exists(/x:description/@stylesheet)">
            <p:output port="xspec-html-report" primary="true"   pipe="xspec-html-report@xslt-xspec-execute"/>
            <p:output port="xspec-junit-report" primary="false" pipe="xspec-junit-report@xslt-xspec-execute"/>
            <ox:xslt-xspec-execute name="xslt-xspec-execute"/>
         </p:when>
         <p:when test="exists(/x:description/@query)">
            <p:output port="xspec-html-report" primary="true"   pipe="xspec-html-report@xquery-xspec-execute"/>
            <p:output port="xspec-junit-report" primary="false" pipe="xspec-junit-report@xquery-xspec-execute"/>
            <ox:xquery-xspec-execute name="xquery-xspec-execute"/>
         </p:when>
         <p:otherwise>
            <p:output port="xspec-html-report" primary="true"/>
            <p:output port="xspec-junit-report" primary="false"/>
            <p:sink/>
         </p:otherwise>
      </p:choose>
   </p:declare-step>
   
   <p:declare-step name="produce-html-report" type="ox:produce-html-report">
      <p:input  port="source" primary="true"/>
      <p:output port="result"/>

      <p:variable name="formatter-xslt" select="$xspec-home || 'src/reporter/format-xspec-report.xsl'"/>
      
      <p:xslt name="html-report">
         <p:with-input port="stylesheet" href="{ $formatter-xslt }"/>
         <p:with-option name="parameters" select="map { 'inline-css': 'true' }"/>
      </p:xslt>
      <p:string-replace match="text()" replace="translate(., '', '&lt;&gt;')"/>
   </p:declare-step>
   
   <p:declare-step name="produce-junit-report" type="ox:produce-junit-report">
      <p:input  port="source" primary="true"/>
      <p:output port="result"/>

      <p:variable name="junit-xslt"     select="$xspec-home || 'src/reporter/junit-report.xsl'"/>

      <p:xslt name="junit-report">
         <p:with-input port="stylesheet" href="{ $junit-xslt }"/>
      </p:xslt>
   </p:declare-step>
   
</p:library>
