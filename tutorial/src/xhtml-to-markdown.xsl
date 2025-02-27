<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.w3.org/1999/xhtml" version="3.0"
   exclude-result-prefixes="#all">

    <!-- Purpose: Convert XML to markdown. Note that namespace bindings must be given. -->

    <!--<XSLT:key name="parameters" match="param" use="@id"/>-->

    <!--<xsl:output indent="yes"/>-->
   
   
   <!-- change 'string' to line   -->
   <!-- unit test! -->
   
   <xsl:output omit-xml-declaration="true"/>
   <xsl:strip-space elements="*"/>
   
   <xsl:preserve-space elements="p li pre td th
       h1 h2 h3 h4 h5 h6
       i b a code span strong em q"/>

    <xsl:template match="/" mode="md">
       <md>  
         <xsl:apply-templates mode="md"/>
       </md>
    </xsl:template>
   
    <xsl:template match="/ | *">
       <xsl:variable name="lines">
          <md>
            <xsl:apply-templates mode="md"/>
          </md>
       </xsl:variable>
       <!--<xsl:copy-of select="$lines"/>-->
       <xsl:apply-templates mode="render" select="$lines"/>
    </xsl:template>
   
   <xsl:template match="ox:md" mode="render">
      <xsl:text>&#xA;</xsl:text>
      <xsl:apply-templates mode="render"/>
      <xsl:text>&#xA;</xsl:text>
   </xsl:template>
   
   <xsl:template match="ox:line" mode="render">
      <xsl:text>&#xA;</xsl:text>
      <xsl:apply-templates mode="render"/>
   </xsl:template>
   
   <xsl:template match="text()[empty(ancestor::pre)]" mode="md">
       <xsl:value-of select="replace(.,'\s\s+',' ')"/>
    </xsl:template>
   
    <xsl:template name="conditional-lf">
       <xsl:for-each select="preceding-sibling::*[1]">
            <line/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="html" mode="md">
       <xsl:apply-templates select="body" mode="md"/>
    </xsl:template>

    <xsl:template match="blockquote" mode="md">
       <xsl:call-template name="conditional-lf"/>
       <xsl:apply-templates mode="blockquoted"/>       
    </xsl:template>
   
   <xsl:template match="*" mode="blockquoted">
      <xsl:variable name="here">
         <xsl:apply-templates select="." mode="md"/>
      </xsl:variable>
      <xsl:apply-templates select="$here" mode="decorate-blockquote"/>   
   </xsl:template>
   
   <xsl:template match="line"   xpath-default-namespace="http://csrc.nist.gov/ns/oscal-xproc3" mode="decorate-blockquote">
      <xsl:copy>
        <xsl:text>&gt; </xsl:text>
         <xsl:apply-templates mode="#current"/>
      </xsl:copy>
   </xsl:template>
   
   <xsl:mode name="decorate-blockquote" on-no-match="shallow-copy"/>
   
   <xsl:template match="img" mode="md" expand-text="true">
      <xsl:call-template name="conditional-lf"/>
      <line>
         <xsl:text>!</xsl:text>
         <xsl:for-each select="@alt">[{ normalize-space(.) }]</xsl:for-each>
         <xsl:for-each select="@src">({ normalize-space(.) })</xsl:for-each>
      </line>
   </xsl:template>

   <xsl:template mode="md" match="div">
      <line/>
      <xsl:apply-templates mode="#current"/>
   </xsl:template>
   
    <xsl:template mode="md" match="p">
        <xsl:call-template name="conditional-lf"/>
        <line>
            <xsl:apply-templates mode="md"/>
        </line>
    </xsl:template>

    <xsl:template mode="md" match="h1 | h2 | h3 | h4 | h5 | h6">
        <line/>
        <line>
            <xsl:apply-templates select="." mode="mark"/>
            <xsl:apply-templates mode="md"/>
        </line>
    </xsl:template>

    <xsl:template mode="mark" match="h1"># </xsl:template>
    <xsl:template mode="mark" match="h2">## </xsl:template>
    <xsl:template mode="mark" match="h3">### </xsl:template>
    <xsl:template mode="mark" match="h4">#### </xsl:template>
    <xsl:template mode="mark" match="h5">##### </xsl:template>
    <xsl:template mode="mark" match="h6">###### </xsl:template>

    <xsl:template mode="md" match="table">
        <xsl:call-template name="conditional-lf"/>
        <xsl:apply-templates select="*" mode="md"/>
    </xsl:template>

    <xsl:template match="colgroup"/>
   
    <xsl:template mode="md" match="tr">
        <line>
            <xsl:apply-templates select="*" mode="md"/>
        </line>
        <xsl:if test="empty(preceding-sibling::tr | parent::tbody | parent::tgroup)">
            <line>
                <xsl:text>|</xsl:text>
                <xsl:for-each select="th | td">
                    <xsl:text> --- |</xsl:text>
                </xsl:for-each>
            </line>
        </xsl:if>
    </xsl:template>

    <xsl:template mode="md" match="th | td">
        <xsl:if test="empty(preceding-sibling::*)">|</xsl:if>
        <xsl:text> </xsl:text>
        <xsl:apply-templates mode="md"/>
        <xsl:text> |</xsl:text>
    </xsl:template>

    <xsl:template mode="md" priority="1" match="pre">
        <xsl:call-template name="conditional-lf"/>
        <line>```</line>
        <line>
            <xsl:apply-templates mode="md"/>
        </line>
        <line>```</line>
    </xsl:template>

    <xsl:template mode="md" priority="1" match="ul | ol">
        <line/>
        <xsl:apply-templates mode="md"/>       
    </xsl:template>

    <xsl:template mode="md" priority="10" match="ul//ul | ol//ol | ol//ul | ul//ol">
       <xsl:apply-templates mode="md"/>
    </xsl:template>

    <xsl:template mode="md" match="li">
        <line>
            <xsl:for-each select="../ancestor::ul">
                <xsl:text>&#32;&#32;</xsl:text>
            </xsl:for-each>
            <xsl:text>* </xsl:text>
            <xsl:apply-templates mode="md"/>
        </line>
    </xsl:template>
    <!-- Since XProc doesn't support character maps we do this in XSLT -   -->

    <xsl:template mode="md" match="ol/li">
        <line/>
        <line>
            <xsl:for-each select="../ancestor::ul">
                <xsl:text>&#32;&#32;</xsl:text>
            </xsl:for-each>
            <xsl:text>1. </xsl:text>
            <xsl:apply-templates mode="md"/>
        </line>
    </xsl:template>
    <!-- Since XProc doesn't support character maps we do this in XSLT -   -->



    <xsl:template mode="md" match="code | span[contains(@class, 'code')]">
        <xsl:text>`</xsl:text>
        <xsl:apply-templates mode="md"/>
        <xsl:text>`</xsl:text>
    </xsl:template>

    <xsl:template mode="md" match="em | i">
        <xsl:text>*</xsl:text>
        <xsl:apply-templates mode="md"/>
        <xsl:text>*</xsl:text>
    </xsl:template>

    <xsl:template mode="md" match="strong | b">
        <xsl:text>**</xsl:text>
        <xsl:apply-templates mode="md"/>
        <xsl:text>**</xsl:text>
    </xsl:template>

    <xsl:template mode="md" match="q">
        <xsl:text>&amp;ldquo;</xsl:text>
        <xsl:apply-templates mode="md"/>
       <xsl:text>&amp;rdquo;</xsl:text>
    </xsl:template>

    <xsl:key name="element-by-id" match="*[exists(@id)]" use="@id"/>

    <xsl:template mode="md" match="a">
        <xsl:text>[</xsl:text>
        <xsl:value-of select="replace(.,'\s',' ')"/>
        <xsl:text>]</xsl:text>
        <xsl:text>(</xsl:text>
        <xsl:value-of select="@href"/>
        <xsl:text>)</xsl:text>
    </xsl:template>
   
   <xsl:template match="details | summary" mode="md">
      <xsl:call-template name="conditional-lf"/>
      <xsl:apply-templates select="." mode="tag"/>
   </xsl:template>
   
   <xsl:template mode="tag" match="*" expand-text="true">
      <xsl:text>&lt;{ local-name() }&gt;</xsl:text>
      <xsl:apply-templates mode="md"/>
      <xsl:text>&lt;/{ local-name() }&gt;</xsl:text>
   </xsl:template>
      
    <!-- See top level template match="/" for XSLT:template match="text()" mode="md" -->


</xsl:stylesheet>