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
   
   <xsl:import href="xslt3-functions/random-util.xsl"/>
   
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
      <catalog uuid="{x3f:make-uuid( current-date() )}">
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
         <xsl:copy-of select="@*"/>
         <xsl:apply-templates/>
      </title>
   </xsl:template>
   
   <xsl:template match="requirement">
      <control>
         <xsl:copy-of select="@*"/>
         <xsl:apply-templates/>
      </control>
   </xsl:template>
   
   <xsl:template match="external_reference">
      <link class="reference">
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
   
   <xsl:template match="a">
      <a>
         <xsl:copy-of select="@*"/>
         <xsl:apply-templates/>
      </a>
      
   </xsl:template>

   <xsl:template match="examine | interview | test">
      <part name="{ local-name() }" id="sp800-171_{@id}">
         <xsl:apply-templates/>
      </part>
   </xsl:template>
   
      
   <xsl:template match="examine/text | interview/text | test/text">
      <xsl:apply-templates select="selection"/>
      <xsl:if test="* except selection[1]">
         <xsl:message terminate="yes">unexpected contents at { path(.) }</xsl:message>
      </xsl:if>
   </xsl:template>
   
   
   <xsl:template match="examine/text/selection | interview/text/selection | test/text/selection">
      <xsl:for-each select="tokenize(.,';\s*')">
         <p>
            <xsl:text>{ . }</xsl:text>
         </p>
      </xsl:for-each>
   </xsl:template>
   
   <!--<xsl:template match="odp">
      <param id="sp800-171_{@id}">
         <xsl:apply-templates/>
      </param>
   </xsl:template>
   
   <xsl:template match="odp/title">
      <label>
         <xsl:apply-templates/>
      </label>
   </xsl:template>
   
   <xsl:template match="odp/text">
      <usage>
         <xsl:apply-templates/>
      </usage>
   </xsl:template>
   
   <xsl:template match="odp/odp_statement">
      <guideline>
         <xsl:apply-templates/>
      </guideline>
   </xsl:template>-->
   
   <!--<xsl:template match="odp/odp_type"/>-->
   
   <!-- Used to retrieve ODPs from implicit references in <assignment> -->
   <xsl:key name="odp-by-statement" match="odp" use="odp_statement/normalize-space(.)"/>
   
   
</xsl:stylesheet>