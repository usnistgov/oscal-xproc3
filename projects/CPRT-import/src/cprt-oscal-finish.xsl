<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns="http://csrc.nist.gov/ns/oscal/1.0"
   xpath-default-namespace="http://csrc.nist.gov/ns/oscal/1.0"
   xmlns:cprt="http://csrc.nist.gov/ns/cprt"
   exclude-result-prefixes="#all"
   expand-text="true"
   version="3.0"
   xmlns:x3f="http://csrc.nist.gov/ns/xslt3-functions">
   

   <xsl:mode on-no-match="shallow-copy"/>
   
   <xsl:import href="xslt3-functions/random-util.xsl"/>
   
   <xsl:variable name="reference-uuid-map" as="map(*)" select="cprt:uuid-map((current-date()!string(.)),//resource/@id)"/>
   
   <!-- Returns a map of new UUIDs for a provided set of values -->
   <xsl:function name="cprt:uuid-map" as="map(*)">
      <xsl:param name="seed" as="xs:string"/>
      <xsl:param name="seq" as="item()*"/>
      <xsl:variable name="uuid-sequence" select="x3f:make-uuid-sequence( $seed, count($seq))"/>
      <xsl:map>
         <xsl:for-each select="$seq">
            <xsl:variable name="p" select="position()"/>
            <xsl:map-entry key="string(.)" select="$uuid-sequence[$p]"/>
         </xsl:for-each>
      </xsl:map>
   </xsl:function>
         
   <xsl:template match="cprt:*">
      <xsl:message>Warning: upstream element CPRT { local-name() } was encountered - results will be invalid -</xsl:message>
      <xsl:copy>
            <xsl:copy-of select="@*"/>
           <xsl:apply-templates/>
      </xsl:copy>
   </xsl:template>
   
   <xsl:template match="@id | @id-ref">
      <xsl:attribute name="{ local-name() }">{ translate(.,'([','..') => translate('])','') }</xsl:attribute>
   </xsl:template>
   
   <!-- overrides testing template in imported XSLT -->
   <xsl:template match="/">
      <xsl:apply-templates/>
   </xsl:template>
   
   <xsl:template match="/processing-instruction()"/>
   
   <xsl:template match="/*">
      <catalog uuid="{x3f:make-uuid( current-date() || '000' )}">
         <xsl:apply-templates/>
      </catalog>
   </xsl:template>
   
   <xsl:template match="link[@rel='related']">
      <xsl:variable name="control-id" select="lower-case(.) => translate('()','.') => replace('0(\d)','$1')"/>
      <link rel="related" href="sp800-53-oscal.xml#{ $control-id }"/>
   </xsl:template>
   
   <xsl:template match="control">
      <xsl:variable name="is-withdrawn" select="prop[@name='status']/@value='withdrawn'"/>
      <control>
         <xsl:apply-templates select="@*"/>
         <xsl:apply-templates select="title"/>
         <xsl:if test="empty(title)">
            <title>Control { substring-after(@id,'sp800-171_') }{ ' (Withdrawn)'[$is-withdrawn] }</title>
         </xsl:if>
         <xsl:apply-templates mode="migrate" select="descendant::param except control/descendant::param"/>
         <xsl:apply-templates select="prop"/>
         <xsl:apply-templates select="link"/>
         <xsl:apply-templates select="part[@name='statement']"/>
         <xsl:apply-templates select="part[@name='discussion']"/>
         <xsl:apply-templates select="part[@name='examine']"/>
         <xsl:apply-templates select="part[@name='interview']"/>
         <xsl:apply-templates select="part[@name='test']"/>
         <xsl:apply-templates
            select="part[(@name = ('statement','discussion','examine','interview','test')) => not()]"/>
         <xsl:apply-templates select="control"/>
      </control>
   </xsl:template>
         
   <xsl:template match="param"/>
   
   <!--<xsl:template match="param/label[.='SELECTED PARAMETER VALUES']"/>-->
   
   <xsl:template match="param" mode="migrate">
      <xsl:copy>
         <xsl:apply-templates select="@*"/>
         <xsl:apply-templates select="prop"/>
         <xsl:apply-templates select="link"/>
         <xsl:apply-templates select="label"/>
         <xsl:apply-templates select="usage"/>
         <xsl:apply-templates select="guideline"/>
         <xsl:apply-templates select="value | select"/>
         <xsl:apply-templates select="remarks"/>
      </xsl:copy>
   </xsl:template>
   
   <xsl:template match="@value">
      <xsl:attribute name="value">{ normalize-space(.) }</xsl:attribute>
   </xsl:template>
   
   <xsl:template match="link[starts-with(@href,'#')]">
      <link>
         <xsl:apply-templates select="@*"/>
         <xsl:apply-templates/>
      </link>
   </xsl:template>
   
   <xsl:template match="link[starts-with(@href,'#')]/@href">
      <xsl:attribute name="href">#{ replace(.,'^#','') ! $reference-uuid-map(.) }</xsl:attribute>
   </xsl:template>
   
   <xsl:template match="resource">
      <resource uuid="{ $reference-uuid-map(@id) }">
         <xsl:apply-templates select="@*"/>
         <xsl:apply-templates/>
      </resource>
   </xsl:template>
   
   <xsl:template match="resource/@id"/>
   
   <xsl:template match="part[@name=('examine','interview','test')]">
      <part name="assessment-method">
         <prop name="method" ns="http://csrc.nist.gov/ns/rmf" value="{ upper-case(@name) }"/>
         <xsl:apply-templates/>
      </part>
   </xsl:template>
   
</xsl:stylesheet>