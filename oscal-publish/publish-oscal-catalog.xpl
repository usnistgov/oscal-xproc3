<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" type="ox:publish-oscal-catalog" name="publish-oscal-catalog">

   <p:input port="source" primary="true">
      <p:document href="data/cat_catalog.xml"/>
   </p:input>

   <p:input port="schema" primary="false">
      <p:document  content-type="application/xml" href="lib/oscal_catalog_schema.xsd"/>
      <!--<p:document  content-type="application/xml" href="https://github.com/usnistgov/OSCAL/releases/download/v1.1.2/oscal_catalog_schema.xsd"/>-->
   </p:input>
   
   <!--<p:output port="result" serialization="map{'indent' : true()}" />-->
   
   <p:variable name="result-html-path" select="(base-uri(/) => replace('\.xml$','')) || '.html'"/>
   <!--<p:variable name="result-md-path"  select="(base-uri(/) => replace('\.xml$','')) || '.md'"/>-->

   <p:variable name="base" select="base-uri(/*)"/>
      
   <p:validate-with-xml-schema name="validating" assert-valid="false">
      <p:with-input port="schema" pipe="schema@publish-oscal-catalog" />
   </p:validate-with-xml-schema>
   
   <p:choose>
   <p:when test="exists(/*/xvrl:detection)" xmlns:xvrl="http://www.xproc.org/ns/xvrl">
      <p:with-input pipe="report@validating"/>
      <p:identity name="invalid-warning"
         message="[### publish-oscal-catalog] WARNING: input INVALID at {$base} -- Expect defective results"/>
   </p:when>
      <p:otherwise>
         <p:identity name="invalid-warning"
            message="[### publish-oscal-catalog] INFO: input found VALID at {$base} -- Thank you"/>
            </p:otherwise>
   </p:choose>
   <!--<p:delete match="/*/node()"/>-->
   
   <!--<p:identity>
      <p:with-input pipe="report@validating"/>
   </p:identity>-->
   
   <p:xslt name="make-html">
      <p:with-input port="stylesheet" href="lib/xslt/publish/nist-emulation/sp800-53A-catalog_html.xsl"/>
   </p:xslt>

   <!-- Serialization matters! If this is serialized in XML syntax browsers can have trouble parsing -->
   <p:store href="{$result-html-path}" message="[publish-oscal-catalog] Storing { $result-html-path }"
   serialization="map{'method': 'html', 'indent': true() }"/>

</p:declare-step>