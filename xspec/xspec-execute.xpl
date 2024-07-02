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
   
   <p:declare-step name="execute-xslt-xspec" type="ox:execute-xslt-xspec">      
      <p:input port="xspec-source"        primary="true"  content-types="application/xml"/>      
      <p:output port="xspec-html-report"  primary="true"  pipe="result@html-report"/>
      <p:output port="xspec-junit-report" primary="false" pipe="result@junit-report"/>
      
      <!-- These paths are sensitive to the XSpec distribution at $xspec-home - take care -->
      <p:variable name="compiler-xslt"   select="$xspec-home || 'src/compiler/compile-xslt-tests.xsl'"/>
      <p:variable name="xspec-file-path" select="base-uri(/)"/>
      <p:variable name="xslt-path"       select="/*/@stylesheet"/>
      
      <p:xslt name="compile-xspec">
         <p:with-input port="stylesheet" href="{ $compiler-xslt }"/>
      </p:xslt>
      <!-- A small adjustment to the compiled XSLT wakes up the 'secondary' port where we can see it ...  -->
      <p:add-attribute name="adjusted-runtime"
         match="/*/xsl:template[@name='Q{{http://www.jenitennison.com/xslt/xspec}}main']/xsl:result-document"
         attribute-name="href" attribute-value="report" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"/>
      <!-- Run the XSLT -->
      <p:xslt name="xslt-xspec-execution"
         message="[### execute-xslt-xspec] Executing XSPec { base-uri(/) } testing XSLT { $xslt-path }">
         <p:with-input port="source">
            <p:empty/>
         </p:with-input>
         <p:with-input port="stylesheet" pipe="result@adjusted-runtime"/>
         <p:with-option name="template-name" select="'Q{http://www.jenitennison.com/xslt/xspec}main'"/>
      </p:xslt>
      <!-- Picking up this result and putting it back on the primary port. -->
      <p:identity name="xspec-report">
         <p:with-input port="source" pipe="secondary@xslt-xspec-execution"/>
      </p:identity>

      <ox:produce-html-report name="html-report"/>
      <p:sink/>
      
      <ox:produce-junit-report name="junit-report">
         <p:with-input port="source" pipe="result@xspec-report"/>
      </ox:produce-junit-report>
   </p:declare-step>
   
   <p:declare-step name="execute-xquery-xspec" type="ox:execute-xquery-xspec">      
      <p:input port="xspec-source" primary="true" content-types="application/xml"/>
      <p:output port="xspec-html-report" primary="true" pipe="result@html-report"/>
      <p:output port="xspec-junit-report" primary="false" pipe="result@junit-report"/>
      
      <p:variable name="compiler-xslt"      select="$xspec-home || 'src/compiler/compile-xquery-tests.xsl'"/>
      <p:variable name="xspec-file-path"    select="base-uri(/)"/>
      <p:variable name="xquery-target"      select="/*/@query-at"/>
      <p:variable name="xquery-target-path" select="resolve-uri($xquery-target,$xspec-file-path)"/>
      
      <p:xslt name="compiled-xspec">
         <p:with-input port="source" pipe="xspec-source@execute-xquery-xspec"/>
         <p:with-input port="stylesheet" href="{$compiler-xslt}"/>
         <p:with-option name="parameters" select="map { 'query-at': $xquery-target-path }"/>
      </p:xslt>
      <p:xquery name="xquery-xspec-execution" message="[### execute-xquery-xspec] Executing XQuery XSpec { $xspec-file-path } testing { $xquery-target } - no runtime messages, sorry">
         <p:with-input port="query" pipe="result@compiled-xspec"/>
      </p:xquery>
      <p:identity name="xspec-report"/>
      
      <ox:produce-html-report name="html-report"/>
      <p:sink/>
      
      <ox:produce-junit-report name="junit-report">
         <p:with-input port="source" pipe="result@xspec-report"/>
      </ox:produce-junit-report>
   </p:declare-step>
   
   <p:declare-step name="execute-schematron-xspec" type="ox:execute-schematron-xspec">      
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
         <p:with-input port="source" pipe="xspec-source@execute-schematron-xspec"/>
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
         <!-- parameter $imported carries the compiled Schematron templates to be folded in -->
         <p:with-option name="parameters" select="map { 'imported': $schematron-xslt }"/>
         <p:with-input port="stylesheet" href="xspec-expand-import.xsl"/>            
      </p:xslt>
      <!-- As above, a small adjustment to the compiled XSLT wakes up the 'secondary' port where we can see it ...  -->
      <p:add-attribute name="adjusted-runtime"
         match="/*/xsl:template[@name='Q{{http://www.jenitennison.com/xslt/xspec}}main']/xsl:result-document"
         attribute-name="href" attribute-value="report" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"/>
      <!-- Now, execute -->
      <p:xslt name="schematron-xspec-execution" message="[### execute-schematron-xspec] Executing XSPec { $xspec-file-path } testing Schematron { $target-schematron-path } ">
         <p:with-input port="source">
            <p:empty/>
         </p:with-input>
         <p:with-input port="stylesheet" pipe="result@adjusted-runtime"/>
         <p:with-option name="template-name" select="'Q{http://www.jenitennison.com/xslt/xspec}main'"/>
      </p:xslt>
      <p:identity name="xspec-report">
         <p:with-input port="source" pipe="secondary@schematron-xspec-execution"/>
      </p:identity>
      
      <ox:produce-html-report name="html-report"/>      
      <p:sink/>
      
      <ox:produce-junit-report name="junit-report">
         <p:with-input port="source" pipe="result@xspec-report"/>
      </ox:produce-junit-report>
   </p:declare-step>
   
   <p:declare-step name="execute-xspec" type="ox:execute-xspec">
      <p:input port="xspec-source" primary="true" content-types="application/xml"/>
      <p:output port="xspec-html-report" primary="true" pipe="xspec-html-report@switcher"/>
      <p:output port="xspec-junit-report" primary="false" pipe="xspec-junit-report@switcher"/>

      <p:choose name="switcher">
         <p:when test="exists(/x:description/@schematron)">
            <p:output port="xspec-html-report" primary="true"   pipe="xspec-html-report@schematron-xspec-execution"/>
            <p:output port="xspec-junit-report" primary="false" pipe="xspec-junit-report@schematron-xspec-execution"/>
            <ox:execute-schematron-xspec name="schematron-xspec-execution"/>
         </p:when>
         <p:when test="exists(/x:description/@stylesheet)">
            <p:output port="xspec-html-report" primary="true"   pipe="xspec-html-report@xslt-xspec-execution"/>
            <p:output port="xspec-junit-report" primary="false" pipe="xspec-junit-report@xslt-xspec-execution"/>
            <ox:execute-xslt-xspec name="xslt-xspec-execution"/>
         </p:when>
         <p:when test="exists(/x:description/@query)">
            <p:output port="xspec-html-report" primary="true"   pipe="xspec-html-report@xquery-xspec-execution"/>
            <p:output port="xspec-junit-report" primary="false" pipe="xspec-junit-report@xquery-xspec-execution"/>
            <ox:execute-xquery-xspec name="xquery-xspec-execution"/>
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

      <p:variable name="junit-xslt" select="$xspec-home || 'src/reporter/junit-report.xsl'"/>

      <p:xslt name="junit-report">
         <p:with-input port="stylesheet" href="{ $junit-xslt }"/>
      </p:xslt>
   </p:declare-step>
   
</p:library>
