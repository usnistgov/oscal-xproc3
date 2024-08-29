<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    expand-text="true" version="3.0">

<!-- Generic STS enhancement XSLT
        
     Fixing up sloppy and weird STS into nice, tight, clean, meaningful and correct STS.
    
    -->
    
    <xsl:param name="show-tracing" static="true" as="xs:string" select="'no'"/>
    <xsl:variable static="true" name="noisy" select="$show-tracing = 'yes'"/>
    
    <xsl:mode on-no-match="shallow-copy"/>
    
    <!-- Key definition permits retrieving elements by means of their ID values. -->
    <xsl:key name="by-id" match="*[@id]" use="@id"/>
    
<!--    <xsl:key name="ref-by-label" match="ref" use="child::label"/>
    
    <xsl:key name="linkable-element-by-textref" match="*[exists(@id)]">
        <xsl:apply-templates select="." mode="make-textref"/>
    </xsl:key>
    
    <!-\- 'make-textref' mode provides dynamic extensible keying of elements to data values for
      purposes of indexing and cross-referencing. -\->
    <xsl:mode name="make-textref" on-no-match="shallow-skip"/>
    
   <xsl:template mode="make-textref" as="xs:string*" match="*"/>

    <!-\- Specific to SP 800-53 STS XML   -\->
    <xsl:template mode="make-textref" as="xs:string*" match="ref[label='CNSSI1253']">
        <xsl:text>CNSS Instruction 1253</xsl:text>
        <xsl:next-match/>
    </xsl:template>
    
    <!-\-<sec id="sr">
        <label>3.20</label>
        <title>Supply Chain Risk Management (SR) Family</title>-\->
    <xsl:template mode="make-textref" as="xs:string*" match="*[ends-with(title,'Family')]" priority="120">
        <xsl:text>{ replace(title,'\s*Family','') }</xsl:text>
        <xsl:next-match/>
    </xsl:template>
    
    <!-\-<app id="sec_B">
        <label>Appendix B</label>
        <title>List of Acronyms</title>-\->
    <xsl:template mode="make-textref" as="xs:string*" match="*[title='List of Acronyms']" priority="110">
        <xsl:text>Acronyms</xsl:text>
        <xsl:next-match/>
    </xsl:template>
    
    <xsl:template mode="make-textref" as="xs:string*" match="*[exists(title)]" priority="101">
        <xsl:text>{ child::title }</xsl:text>
        <xsl:next-match/>
    </xsl:template>
    
    <xsl:template mode="make-textref" as="xs:string*" match="sec[exists(label)]">
        <xsl:text>Section { child::label }</xsl:text>
        <xsl:next-match/>
    </xsl:template>
    
    <xsl:template mode="make-textref" as="xs:string*" match="app[exists(label)]">
        <xsl:text>{ child::label }</xsl:text>
        <xsl:next-match/>
    </xsl:template>
    
    <!-\- Rewrite ref-types emitting warnings where discrepancies are found -\->
    
    <xsl:template priority="101" match="xref//underline">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-\- Capture underlines and rewrite as xlinks when they point to labels -\->
    <xsl:template priority="10" match="underline[exists(key('linkable-element-by-textref',normalize-space(.)))]">
        <xsl:variable name="ref" select="key('linkable-element-by-textref',normalize-space(.))"/>
        <xsl:choose>
            <xsl:when test="count($ref) eq 1">
                <xsl:message use-when="$noisy">Converting underline _{ normalize-space(.) }_ to xref[@rid='{ $ref/@id }'] ...</xsl:message>
                <xref rid="{ $ref/@id }">
                    <xsl:apply-templates select="$ref" mode="ref-type"/>
                    <xsl:apply-templates/>
                </xref>        
            </xsl:when>
            <xsl:otherwise>
                <xsl:message>underline _{ normalize-space(.) }_ points to { $ref/@id => string-join(', ') } so we leave in place ...</xsl:message>
                <xsl:next-match/></xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    <xsl:template match="underline">
        <xsl:copy  copy-namespaces="no">
            <xsl:message>Seeing underline _{ . }_</xsl:message>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*" mode="ref-type">
        <xsl:message>No ref-type added for { local-name() }</xsl:message>
    </xsl:template>
    
    <xsl:template match="sec | app" mode="ref-type">
        <xsl:attribute name="ref-type">{ local-name() }</xsl:attribute>
    </xsl:template>
    
    <xsl:template match="ref" mode="ref-type">
        <xsl:attribute name="ref-type">bibr</xsl:attribute>
    </xsl:template>
    
    
    <xsl:template match="underline[exists(key('ref-by-label',normalize-space(.)))]">
        <xsl:variable name="ref" select="key('ref-by-label',normalize-space(.))"/>
        <xsl:message use-when="$noisy">Converting underline _{ normalize-space(.) }_ to xref[@rid='{ $ref/@id }'] ...</xsl:message>
        <xref rid="{ $ref/@id }">
            <xsl:apply-templates select="$ref" mode="ref-type"/>
            <xsl:apply-templates/>
        </xref>
    </xsl:template>
    <!-\- Do the label promotion thing in ref-list/ref elements -\->
    
    <xsl:template match="ref[empty(label) and mixed-citation/(child::*[1] is label[1])]">
        <xsl:copy copy-namespaces="no">
            <xsl:copy-of select="@*"/>
            <xsl:copy-of select="mixed-citation/label[1]" copy-namespaces="no"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <!-\- Labels are dropped from mixed-citations when they are the first child -\->
    <xsl:template match="ref/mixed-citation[child::*[1] is label[1]]/label[1]"/>
    
    <!-\- And text in the neighborhood is trimmed -\->
    <xsl:template match="ref/mixed-citation[child::*[1] is label[1]]//text()">
        <xsl:choose>
            <xsl:when test="empty(preceding-sibling::text()|preceding-sibling::*) and exists(following-sibling::*[1]/self::label)">
                <xsl:sequence select="replace(.,'\s*\[\s*$','')"/>
            </xsl:when>
            <xsl:when test="exists(preceding-sibling::*[1]/self::label[empty(preceding-sibling::*)])">
                <xsl:sequence select="replace(.,'^\s*\]\s*','')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:next-match/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    -->
    
</xsl:stylesheet>