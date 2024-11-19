<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:cprt="http://csrc.nist.gov/ns/cprt"
   type="ox:PRODUCE_SP800-171-OSCAL" name="PRODUCE_SP800-171-OSCAL">
 
   <p:option name="doc-code" as="xs:string" select="'sp800-171'"/>
   
   <!-- with no pipe attachment, the output port captures the final result -->
   <!--<p:output port="result" serialization="map{ 'indent': true() }" pipe="result@cast"/>-->

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

   <p:xslt name="cast">
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
   
   <p:store href="temp/{ $doc-code }_01_extracted.xml" serialization="map{ 'indent': true() }"
      message="[PRODUCE_SP800-171-OSCAL] Saving intermediate result temp/{ $doc-code }_01_extracted.xml"/>
   
   
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
   
   <p:store href="temp/{ $doc-code }_02_expanded.xml" serialization="map{ 'indent': true() }"
      message="[PRODUCE_SP800-171-OSCAL] Saving intermediate result temp/{ $doc-code }_02_expanded.xml"/>


   <p:xslt>
      <p:with-input port="stylesheet" href="src/cprt-reduce.xsl"/>
   </p:xslt>
   
   <p:store href="temp/{ $doc-code }_03_declarative.xml" serialization="map{ 'indent': true() }"
      message="[PRODUCE_SP800-171-OSCAL] Saving intermediate result temp/{ $doc-code }_03_declarative.xml"/>


   <!-- Next step: convert all brackets in //text to <bracket>...</bracket> and try parsing ... -->
   
   <!-- Picks up implicit 'selection' markup; ODP reference codes, and escaped markup (<a href=" etc.) -->
   <p:viewport match="cprt:text[contains(.,'&lt;') or contains(.,'{')]">
      <p:variable name="me" select="/*"/>
      <p:try>
         <p:group>
            <!--<p:error code="boo"/>-->
            <!-- {a; b; c} becomes <choice>a</choice><choice>b</choice><choice>c</choice> note this is quite fragile -->
            <!-- brace characters { must be escaped for XProc -->
            <p:string-replace match="text()[contains(.,'{{')]" 
               replace="replace(.,'\{{','&lt;choice&gt;') => replace('\}}','&lt;/choice&gt;') => replace(';\s*','&lt;/choice&gt;&lt;choice&gt;')"/>            
            <!-- <A.03.15.03.ODP[01]: frequency> becomes
                 <odp-ref ref-id="A.03.15.03.ODP">frequency</odp-ref> -->
            <p:string-replace match="text()[contains(.,'&lt;A')]" replace="replace(.,
               '&lt;([^&lt;a-z]+):\s+([^&lt;&gt;]*)&gt;',
               '&lt;odp-ref ref-id=&quot;$1&quot;&gt;$2&lt;/odp-ref&gt;')"/>            
            <p:replace match="text()">
               <p:with-input port="replacement">
                  <p:inline>{ string(.) => parse-xml-fragment() }</p:inline>
               </p:with-input>
            </p:replace>
            <p:namespace-rename apply-to="elements" to="http://csrc.nist.gov/ns/cprt"/>
         </p:group>
         <p:catch name="parse-error">
            <p:identity message="[PRODUCE_SP800-171-OSCAL] Warning: cannot parse as XML: '{ string($me) }'"/>
         </p:catch>
      </p:try>
   </p:viewport>
   
   <!-- Picks up bracketed expressions when well nested, erroring when not -->
   <p:viewport match="cprt:text[contains(.,'[')]">
      <p:variable name="me" select="/*"/>
      <p:try>
         <p:group>
            <p:string-replace match="text()[contains(.,']')]" replace="replace(.,'\[','&lt;bracketed>') => replace('\]','&lt;/bracketed>')"/>
            <p:replace match="text()">
               <p:with-input port="replacement">
                  <p:inline>{ string(.) => parse-xml-fragment() }</p:inline>
               </p:with-input>
            </p:replace>
            <p:namespace-rename apply-to="elements" to="http://csrc.nist.gov/ns/cprt"/>
         </p:group>
         <p:catch name="parse-error">
            <p:identity message="[PRODUCE_SP800-171-OSCAL] Warning: cannot parse as XML: '{ string($me) }'"/>
         </p:catch>
      </p:try>
   </p:viewport>
   
   <p:xslt>
      <p:with-input port="stylesheet" href="src/brackets-map.xsl"/>
   </p:xslt>
   
   <p:store href="temp/{ $doc-code }_04-enhanced.xml" serialization="map{ 'indent': true() }"
      message="[PRODUCE_SP800-171-OSCAL] Saving intermediate result temp/{ $doc-code }_04_enhanced.xml"/>


   <p:xslt>
      <p:with-input port="stylesheet" href="src/cprt-link-odps.xsl"/>
   </p:xslt>
   
   <p:validate-with-schematron assert-valid="true" message="[PRODUCE_SP800-171-OSCAL] Validating CPRT XML for referential integrity">
      <p:with-input port="schema" href="src/cprt-ready.sch"/>
   </p:validate-with-schematron>
   
   <p:insert match="/*" position="before">
      <p:with-input port="insertion">
         <p:inline><?xml-model href="../src/cprt-ready.sch" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"?>
         </p:inline>
      </p:with-input>
   </p:insert>
   
   <p:xslt>
      <p:with-input port="stylesheet" href="src/cprt-group-references.xsl"/>
   </p:xslt>
   
   <p:store href="temp/{ $doc-code }_05-linked.xml" serialization="map{ 'indent': true() }"
      message="[PRODUCE_SP800-171-OSCAL] Saving intermediate result temp/{ $doc-code }_05-linked.xml"/>


   <p:xslt>
      <p:with-input port="stylesheet" href="src/cprt-to-oscal.xsl"/>
   </p:xslt>
   
   <p:xslt>
      <p:with-input port="stylesheet" href="src/cprt-oscal-finish.xsl"/>
   </p:xslt>
   
   <p:variable name="hash" select="/*/@uuid/tokenize(.,'-')[1]"/>
   <p:store href="{ $doc-code }_{ $hash }_xp3-oscal.xml" serialization="map{ 'indent': false() }"
      message="[PRODUCE_SP800-171-OSCAL] Saving intermediate result { $doc-code }_{ $hash }_xp3-oscal.xml"/>
   
</p:declare-step>