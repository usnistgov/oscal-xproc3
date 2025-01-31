<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" type="ox:MINI_worksheet" name="MINI_worksheet"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:html="http://www.w3.org/1999/xhtml">

   <p:input port="source" sequence="true">
      <p:document href="../../projects/oscal-import/NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl"/>
      <p:document href="../../projects/oscal-import/USDS-2024_Playbook/OSCAL-PLAYBOOK.xpl"/>
      <p:document href="../../projects/oscal-import/USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl"/>
   </p:input>
   
   <p:output port="result"/>
   
   
   <p:for-each>
      <p:add-attribute match="*" attribute-name="path" attribute-value="{ p:document-property(.,'base-uri') => substring-after('projects/oscal-import/') }"/>
   </p:for-each>
   
   <p:wrap-sequence wrapper="collection"/>
   
   <p:xslt>
      <p:with-input port="stylesheet">
         <p:inline expand-text="false"><!-- Note XProc text expansion is *off* -->
            <!-- And XSLT expand-text is *on* -->
            <xsl:stylesheet version="3.0" xpath-default-namespace="http://www.w3.org/1999/xhtml" expand-text="true">
               <xsl:mode on-no-match="shallow-copy"/>
               <xsl:template match="/*">
                  <section>
                     <!-- group to pull only distinct hrefs - using an XProc AVT -->
                     <xsl:for-each-group select="//p:* | //ox:*" group-by="name()">
                        <xsl:sort select="distinct-values(current-group()/@path) => count()" order="descending"/>
                        <xsl:sort select="current-grouping-key()"/>
                        <section>
                           <h4><code>{ current-grouping-key() }</code></h4>
                           <ul>
                              <xsl:for-each-group select="current-group()/@path" group-by="string(.)">
                                 <li><a href="../../../projects/oscal-import/{ current-grouping-key() }">{ current-grouping-key() }</a></li>
                              </xsl:for-each-group>
                           </ul>
                        </section>
                     </xsl:for-each-group>
                  </section>
               </xsl:template>
            </xsl:stylesheet>
         </p:inline>
      </p:with-input>
   </p:xslt>
   
   <p:namespace-delete prefixes="ox p c xs"/>

   <p:store href="xproc-poll.xml" serialization="map{ 'indent': true() }"/>
   
</p:declare-step>