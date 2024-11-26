<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns="http://csrc.nist.gov/ns/oscal/1.0"
   xpath-default-namespace="http://csrc.nist.gov/ns/cprt"
   exclude-result-prefixes="#all"
   expand-text="true"
   version="3.0"
   xmlns:x3f="http://csrc.nist.gov/ns/xslt3-functions">
   

   <xsl:mode on-no-match="shallow-copy"/>
   
         
   <xsl:template match="*">
      <xsl:element name="cprt:{ name() }" namespace="http://csrc.nist.gov/ns/cprt">
            <xsl:copy-of select="@*"/>
           <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>
   
   <!-- overrides testing template in imported XSLT -->
   <xsl:template match="/">
      
      
      <xsl:apply-templates/>
   </xsl:template>
   
   <xsl:template match="/*">
      <catalog>
         <metadata>
            <title>SP 800-171 [OSCAL transcoded version PROVISIONAL FOR TESTING]</title>
            <last-modified>{ current-dateTime() }</last-modified>
            <version>NOT AUTHORITATIVE</version>
            <oscal-version>1.1.3</oscal-version>
         </metadata>
         <xsl:apply-templates/>
      </catalog>
   </xsl:template>
   
   <xsl:template match="family">
      <group class="family" id="sp800-171_{ @id }">
         <xsl:apply-templates/>
      </group>
   </xsl:template>
         
   <xsl:template match="title">
      <title>
         <xsl:apply-templates select="@*"/>
         <xsl:apply-templates/>
      </title>
   </xsl:template>
   
   <xsl:template match="requirement">
      <control>
         <xsl:apply-templates select="@*"/>
         <xsl:apply-templates/>
      </control>
   </xsl:template>
   
   <xsl:template match="requirement/withdraw_reason">
      <prop name="status" value="withdrawn"/>
      <xsl:apply-templates/>
   </xsl:template>
   
   <xsl:template match="withdraw_reason/text"/>
      
   <xsl:template match="withdraw_reason/addressed_by">
      <link rel="addressed-by" href="#sp800-171_{ . }"/>
   </xsl:template>
   
   <xsl:template match="withdraw_reason/incorporated_into">
      <link rel="incorporated-into" href="#sp800-171_{ . }"/>
   </xsl:template>
   
   <xsl:template match="@id">
      <xsl:attribute name="id">sp800-171_{ . }</xsl:attribute>
   </xsl:template>
   
   <xsl:template match="external_reference">
      <link rel="related">
         <xsl:apply-templates/>
      </link>
   </xsl:template>
   
   <xsl:template match="discussion">
      <part name="discussion" id="sp800-171_{@id}">
         <xsl:apply-templates/>
      </part>
   </xsl:template>
   
   <xsl:template match="text">
      <p>
         <xsl:apply-templates/>
      </p>
   </xsl:template>
   
   <xsl:template match="link[starts-with(@href,'#')]">
      <link>
         <xsl:apply-templates select="@*"/>
         <xsl:apply-templates/>
      </link>
   </xsl:template>
   
   <xsl:template match="link/@href[starts-with(.,'#')]">
      <xsl:attribute name="href">#sp800-171_{ replace(.,'^#','') }</xsl:attribute>
   </xsl:template>
   
   
   <xsl:template match="a">
      <a>
         <xsl:apply-templates select="@*"/>
         <xsl:apply-templates/>
      </a>
   </xsl:template>

   <xsl:variable name="cprt-linkstring" as="xs:string">#/cprt/framework/version/SP_800_171_3_0_0/home?element=</xsl:variable>
   
   <xsl:template match="a/@href[starts-with(.,$cprt-linkstring)]">
      <xsl:attribute name="href" select="'#sp800-171_' || substring-after(.,$cprt-linkstring)"/>
   </xsl:template>
   
   
   <xsl:template match="examine | interview | test">
      <part name="{ local-name() }" id="sp800-171_{@id}">
         <xsl:apply-templates/>
      </part>
   </xsl:template>
   
      
   <xsl:template match="examine/text | interview/text | test/text">
      <xsl:apply-templates select="select_from"/>
      <xsl:if test="exists(* except select_from[1])">
         <xsl:message terminate="yes">unexpected contents at { path(.) }</xsl:message>
      </xsl:if>
   </xsl:template>
   
   
   <xsl:template match="examine/text/select_from | interview/text/select_from | test/text/select_from">
      <xsl:for-each select="tokenize(.,';\s*')">
         <p>
            <xsl:text>{ . }</xsl:text>
         </p>
      </xsl:for-each>
   </xsl:template>
   
   
   
   
   <xsl:template match="security_requirement">
      <part name="statement">
         <xsl:apply-templates select="@*"/>
         <xsl:apply-templates/>
      </part>
   </xsl:template>
   
   <xsl:template priority="6" match="security_requirement/title">
      <prop name="label" value="{ . }"/>
   </xsl:template>
   
   <xsl:template match="determination">
      <part name="item">
         <xsl:apply-templates select="@*"/>
         <xsl:apply-templates/>
      </part>
   </xsl:template>
   
   
   <xsl:template match="odp">
      <param id="sp800-171_{@id}">
         <xsl:if test="odp_type/@id='single_entry' and empty(title)">
            <label>{ replace(odp_statement/text,'^organization-defined\s*','') }</label>
         </xsl:if>
         <prop name="label" value="{@id}"/>
         <xsl:apply-templates/>
      </param>
   </xsl:template>
   
   <xsl:template match="odp/text/choice">
      <choice>
         <xsl:apply-templates/>
      </choice>
   </xsl:template>
   
   <xsl:template match="odp/title">
      <label>
         <xsl:apply-templates/>
      </label>
   </xsl:template>
   
   <xsl:template match="odp/text">
      <usage>
         <p>
            <xsl:apply-templates/>
         </p>
      </usage>
   </xsl:template>

   <xsl:template priority="101" match="odp/text[exists(choice)]">
      <select>
         <xsl:if test="starts-with(.,'one or more')">
            <xsl:attribute name="how-many">one-or-more</xsl:attribute>
         </xsl:if>
         <xsl:apply-templates select="choice"/>
      </select>
   </xsl:template>
   
   <xsl:template match="odp/odp_statement">
      <guideline>
         <xsl:apply-templates/>
      </guideline>
   </xsl:template>
   
   <xsl:template match="odp/odp_type"/>
   
   <xsl:template match="REFERENCES">
      <back-matter>
         <xsl:apply-templates/>
      </back-matter>
   </xsl:template>
   
   <xsl:template match="odp-ref | assignment | selection">
      <insert type="param" id-ref="sp800-171_{ @odp-ref-id }"/>
   </xsl:template>
   
   <xsl:template match="odp-ref">
      <insert type="param" id-ref="sp800-171_{ @ref-id }"/>
   </xsl:template>
   
   <xsl:template match="reference">
      <resource>
         <xsl:apply-templates select="@*"/>
         <xsl:apply-templates/>
      </resource>
   </xsl:template>
   
   <xsl:template match="reference/label">
      <title>
         <xsl:apply-templates/>
      </title>
   </xsl:template>
   
   <xsl:template match="reference/title">
      <citation>
         <text>
            <xsl:apply-templates/>
         </text>
      </citation>
   </xsl:template>
   
   <xsl:template match="reference/text" priority="12">
      <rlink href="{ normalize-space(.) }"/>
   </xsl:template>
   
   
</xsl:stylesheet>