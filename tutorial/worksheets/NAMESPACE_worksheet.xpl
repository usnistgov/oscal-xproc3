<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" type="ox:NAMESPACE_worksheet" name="NAMESPACE_worksheet"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   >

<!-- Worksheet for messing with XML namespaces in XProc

concept for later: shouldn't it be possible build a namespace-normalizer in XProc
  indeed due to namespace fixup, some normalization may be inevitable and normal
  
  question: how to test such a tool? with all out-of-line targets? comparing serialized forms?

Use this worksheet to test behaviors both wrt namespaces in parsing (XProc as XML document) and
namespaces in data, together and separately. -->

   <p:input port="source">
      <!--A document inline has namespaces both as declared
          and as inherited from ancestors including ancestors within the pipeline itself --> 
      <p:inline>
         <ddd:doc xmlns:ddd="local/namespace" xmlns:another="another/namespace"/>
      </p:inline>
      
      <!-- Out of line it will have only whatever namespaces it has -->
      <!--<p:document href="../lesson-plan.xml"/>-->
   </p:input>
   
   <p:output port="result" serialization="map{ 'indent': true() }" sequence="true"/>

   <!-- /end prologue -->
   
   <p:variable name="ox:document-info" as="function(*)"  
      select="function($d as item()) as xs:string { p:document-property($d,'content-type') || ' at ' || p:document-property($d,'base-uri') }"/>
   
   
   <p:identity message="[NAMESPACE_worksheet] Seeing { $ox:document-info(.) }"/>

   <!-- Prefixes ox, xs and c are assigned to namespaces in scope - if not stripped here they will show -->
   
   <!-- B/c not declared in a common ancestor we have to repeat declarations
        for namespaces defined elsewhere - but the prefixes don't have to be the same -->
   <p:namespace-delete prefixes="ox xs xsl bah" xmlns:bah="another/namespace"/>
   
   <p:xslt name="inline-xslt" message="[NAMESPACE_worksheet] Applying transformation ...">
      <p:with-input port="stylesheet">
         <p:inline expand-text="false">
            <!-- XSL namespace is declared at the top -->
            <xsl:stylesheet version="3.0" exclude-result-prefixes="#all">
               <xsl:variable name="product-name" select="system-property('xsl:product-name')"/>
               <xsl:variable name="product-version" select="system-property('xsl:product-version')"/>
               
               <!-- nb namespaces must align, but prefixes do not have to -->
               <xsl:template match="/doc" xpath-default-namespace="local/namespace">
                  <xsl:copy>
                     <!-- Note that { works only because p:inline above has expand-text="false" - otherwise the TVT would break -->
                     <message>
                        <xsl:text expand-text="true">You have successfully executed an XSL transformation, using { $product-name }, version { $product-version }</xsl:text>
                     </message>
                  </xsl:copy>
               </xsl:template>
               
            </xsl:stylesheet>
         </p:inline>
      </p:with-input>
   </p:xslt>
   
</p:declare-step>