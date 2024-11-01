<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xvrl="http://www.xproc.org/ns/xvrl"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   type="ox:XSD-VALIDATE-OFFSITE"
   name="XSD-VALIDATE-OFFSITE">

   <p:import href="xsd-validate-catalog.xpl"/><!-- Encapsulates validation for all pipelines that use it -->
   
   <p:input port="source" primary="true" sequence="true">
      <!-- valid OSCAL catalogs, in a remote repository -->
      <p:document href="https://raw.githubusercontent.com/usnistgov/oscal-content/main/nist.gov/SP800-53/rev5/xml/NIST_SP-800-53_rev5_LOW-baseline-resolved-profile_catalog.xml"/>
      <p:document href="https://raw.githubusercontent.com/usnistgov/oscal-content/main/nist.gov/SP800-53/rev5/xml/NIST_SP-800-53_rev5_MODERATE-baseline-resolved-profile_catalog.xml"/>
      <p:document href="https://raw.githubusercontent.com/usnistgov/oscal-content/main/nist.gov/SP800-53/rev5/xml/NIST_SP-800-53_rev5_HIGH-baseline-resolved-profile_catalog.xml"/> 
      
      <!-- a valid instance: -->
      <p:document href="./samples/cat-catalog.xml"/>      
      <!-- an invalid instance: -->
      <p:document href="./samples/dog-catalog.xml"/>      
   </p:input>

   <!-- We report the validation report that comes back - stripping markup -->
   <p:output sequence="true" serialization="map{ 'indent': true()}"/>
   
   <p:for-each name="catalog-validation">
      <p:output port="report" pipe="report@catalog-validator"/>
      
      <!--The content-type coming back from Github is text/plain so we force into XML ... -->
      <p:if test="not(p:document-properties(.)?content-type='xml')">
         <p:cast-content-type content-type="application/xml"/>
      </p:if>
      
      <ox:xsd-validate-catalog name="catalog-validator"/>
   </p:for-each>
   
   <p:wrap-sequence wrapper="full_report">
      <p:with-input pipe="report"/>
   </p:wrap-sequence>
   
   <p:namespace-delete prefixes="xvrl"/>
   
   <!-- XSLT is the most comprehensive and capable way to trim down the validation report ...
     ... but YMMV - YOUR LOCAL REQUIREMENTS MATTER
     see the pipelines in project ../schema-field-tests/ for an approach more thoroughly worked out -->
   <p:xslt>
      <p:with-input port="stylesheet">
         <p:inline expand-text="false">
            <xsl:stylesheet version="3.0">
               <xsl:mode on-no-match="shallow-copy"/>
               <xsl:template match="report">
                  <xsl:copy>
                     <xsl:copy-of select="@*"/>
                     <xsl:copy-of select="descendant::document[1]/@href"/>
                     <xsl:apply-templates/>
                  </xsl:copy>
               </xsl:template>
               <xsl:template match="metadata | digest"/>
            </xsl:stylesheet>
         </p:inline>
      </p:with-input>
   </p:xslt>
   
</p:declare-step>