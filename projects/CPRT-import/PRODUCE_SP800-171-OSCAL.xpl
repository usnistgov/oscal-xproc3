<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:cprt="http://csrc.nist.gov/ns/cprt"
   type="ox:PRODUCE_SP800-171-OSCAL" name="PRODUCE_SP800-171-OSCAL">

<p:documentation>HOUSE RULES HALL PASS - add this file to ../../testing/FILESET_XPROC3_HOUSE-RULES.xpl and remove this element</p:documentation>
<p:documentation>
   <p:document href="../projects/oscal-convert/PRODUCE_SP800-171-OSCAL.xpr"/>
</p:documentation>
   
   <p:option name="doc-code" as="xs:string" select="'sp800-171'"/>
   
   <!-- with no pipe attachment, the output port captures the final result -->
   <!--<p:output port="result" serialization="map{ 'indent': true() }"/>-->

<!-- /end prologue -->

   <!-- This chooser is a little cumbersome but permits us to bind arbitrary ID values (as found in the sources)
   with the files in their locations, while naming them properly -->
   <p:variable name="document-map" as="map(*)"
      select="map {
        'sp800-171':  map { 'doc-id': 'SP_800_171_3_0_0',
                            'path':   'data/cprt/cprt_SP_800_171_3_0_0_11-12-2024.json' },
        'sp800-171A': map { 'doc-id': 'SP_800_171_A_3_0_0',
                            'path':   'data/cprt/cprt_SP_800_171_A_3_0_0_11-12-2024.json' }                     
      }"/>
      
   <p:variable name="doc-id" select="$document-map($doc-code)?doc-id"/>
   
   
   <p:load href="{ $document-map($doc-code)?path => resolve-uri() }" message="[PRODUCE_SP800-171-OSCAL] Loading { $document-map($doc-code)?path }"/>
   
   <p:cast-content-type content-type="application/xml"/>

   <p:xslt>
      <p:with-input port="stylesheet" href="src/cast-jon-by-keys.xsl"/>
   </p:xslt>
   
   <p:xslt>
      <p:with-input port="stylesheet" href="src/sp800-171_json-fixup.xsl"/>
   </p:xslt>
   
   <p:namespace-delete prefixes="xpath" xmlns:xpath="http://www.w3.org/2005/xpath-functions"/>
   
   <p:delete match="cprt:text[string() => not()]" message="[PRODUCE_SP800-171-OSCAL] Deleting { count(//cprt:text[string() =&gt; not()]) } empty 'text' elements"/>
   
   <p:delete match="cprt:title[string() => not()]" message="[PRODUCE_SP800-171-OSCAL] Deleting { count(//cprt:title[string() =&gt; not()]) } empty 'title' elements"/>
   
   <!-- delete @doc-id everywhere when they are all the given value -->
   <p:if test="(//@doc-id != $doc-id) => not()">
      <p:delete match="@doc-id" message="[PRODUCE_SP800-171-OSCAL] Deleting all { count(//@doc-id) } @doc-id attributes - all values are '{ $doc-id }'"/>
   </p:if>
   
   <!-- same for @provenance -->
   <p:if test="(//@provenance != $doc-id) => not()">
      <p:delete match="@provenance" message="[PRODUCE_SP800-171-OSCAL] Deleting all { count(//@provenance) } @provenance attributes - all values are '{ $doc-id }'"/>
   </p:if>
   
   <p:store href="temp/{ $doc-code }-01_extracted.xml" serialization="map{ 'indent': true() }"
      message="[PRODUCE_SP800-171-OSCAL] Saving intermediate result temp/{ $doc-code }-01_extracted.xml"/>
   
   <p:validate-with-relax-ng assert-valid="true" message="[PRODUCE_SP800-171-OSCAL] Validating JSON extract against reduced schema">
      <p:with-input port="schema">
         <!-- @content-type text/plain triggers RNC evaluation -->
         <p:document href="src/cprt-extract.rnc" content-type="text/plain"/>
      </p:with-input>
   </p:validate-with-relax-ng>

   <p:validate-with-schematron assert-valid="true" message="[PRODUCE_SP800-171-OSCAL] Validating JSON extract against Schematron - referential integrity check" >
      <p:with-input port="schema" href="src/json-extract.sch"/>
   </p:validate-with-schematron>
   
   <p:xslt>
      <p:with-input port="stylesheet" href="src/cprt-structure.xsl"/>
   </p:xslt>
   
   <p:store href="temp/{ $doc-code }-02_expanded.xml" serialization="map{ 'indent': true() }"
      message="[PRODUCE_SP800-171-OSCAL] Saving intermediate result temp/{ $doc-code }-02_expanded.xml"/>

   <p:xslt>
      <p:with-input port="stylesheet" href="src/cprt-reduce.xsl"/>
   </p:xslt>
   
   <p:store href="temp/{ $doc-code }-03_declarative.xml" serialization="map{ 'indent': true() }"
      message="[PRODUCE_SP800-171-OSCAL] Saving intermediate result temp/{ $doc-code }-03_declarative.xml"/>
   
   <!-- Next step: convert all brackets in //text to <bracket>...</bracket> and try parsing ... -->
   
   <!--<A.03.15.03.ODP[01]: frequency>-->
   
   <!-- Picks up ODP reference codes as well as escaped markup -->
   <p:viewport match="cprt:text[contains(.,'&lt;')]">
      <p:variable name="me" select="/*"/>
      <!--<p:identity message="[PRODUCE_SP800-171-OSCAL]]] { replace(.,
         '&lt;([^&lt;a-z]+):\s+([^&lt;&gt;]*)&gt;',
         '&lt;odp-ref ref-id=&quot;$1&quot;&gt;$2&lt;/odp-ref&gt;') }"/>  -->          
      <p:try>
         <p:group>
            <!--<p:error code="boo"/>-->
            <p:string-replace match="text()[contains(.,'&lt;A')]" replace="replace(.,
               '&lt;([^&lt;a-z]+):\s+([^&lt;&gt;]*)&gt;',
               '&lt;odp-ref ref-id=&quot;$1&quot;&gt;$2&lt;/odp-ref&gt;')"
               message="[PRODUCE_SP800-171-OSCAL]]] { replace(.,
               '&lt;([^&lt;a-z]+):\s+([^&lt;&gt;]*)&gt;',
               '&lt;odp-ref ref-id=&quot;$1&quot;&gt;$2&lt;/odp-ref&gt;') }"/>            
            <!--<p:string-replace match="text()[contains(.,'[')]" replace="replace(.,'\[','&lt;bracketed>')"/>
            <p:string-replace match="text()[contains(.,']')]" replace="replace(.,'\]','&lt;/bracketed>')"/>-->
            <p:replace match="text()">
               <p:with-input port="replacement">
                  <p:inline>{ string(.) => parse-xml-fragment() }</p:inline>
               </p:with-input>
            </p:replace>
            <p:namespace-rename apply-to="elements" to="http://csrc.nist.gov/ns/cprt"/>
         </p:group>
         <p:catch name="parse-error">
            <p:identity message="[PRODUCE_SP800-171-OSCAL] Warning: XML not parsed: '{ string($me) }'"/>
         </p:catch>
      </p:try>
   </p:viewport>
   
   <!-- Picks up bracketed expressions when well nested, errors when not -->
   <p:viewport match="cprt:text[contains(.,'[')]">
      <p:variable name="me" select="/*"/>
      <p:try>
         <p:group>
            <!-- not replacing except in direct children - they had better match across element boundaries -->
            <p:string-replace match="cprt:text/text()[contains(.,'[')]" replace="replace(.,'\[','&lt;bracketed>')"/>
            <p:string-replace match="cprt:text/text()[contains(.,']')]" replace="replace(.,'\]','&lt;/bracketed>')"/>
            <p:replace match="text()">
               <p:with-input port="replacement">
                  <p:inline>{ string(.) => parse-xml-fragment() }</p:inline>
               </p:with-input>
            </p:replace>
            <p:namespace-rename apply-to="elements" to="http://csrc.nist.gov/ns/cprt"/>
         </p:group>
         <p:catch name="parse-error">
            <p:identity message="[PRODUCE_SP800-171-OSCAL] Warning: XML not parsed: '{ string($me) }'"/>
         </p:catch>
      </p:try>
   </p:viewport>
   
   
   <!-- Restoring brackets where they actually belong -->
   <p:string-replace match="cprt:bracketed[every $s in ('Assignment:','SELECT FROM:','Selection (one or more):')
      satisfies (string(.) => starts-with($s) => not())]" replace="'[' || . || ']'"/>
      
   <p:store href="temp/{ $doc-code }-04-enriched.xml" serialization="map{ 'indent': true() }"
      message="[PRODUCE_SP800-171-OSCAL] Saving intermediate result temp/{ $doc-code }-04_enriched.xml"/>
   
   
</p:declare-step>