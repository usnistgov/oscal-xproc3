<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    default-mode="fair-copy"
    version="3.0">
    
<!-- NISO STS XML whitespace normalizer -->

<!--
   - Writes out STS
   
   - Block-level elements are indented
       'block-level' is defined as no text only element children (in valid documents)
       std-org-loc[empty(child::text()[matches(.,'\S')])] is added to this list as a buff
   - Medial whitespace is trimmed in text by replacing runs of whitespace with single spaces
   - Whitespace is left alone inside preformat, codeblock, code and things marked @xml:space='preserve'
   - Performs best on a text brick, ymmv otherwise (but whitespace stripping the inputs helps) 
   - For data safety, does *not* trim all whitespace anywhere possible (e.g. beginnings and ends of paragraphs)
   
   -->
    
<!--
        
    The NISO STS XSD is a convenient way to find elements that may contain elements only
    
    <xsl:variable name="mixed" select="//xs:complexType[@mixed='true']/../@name/string(.)"/>
    <xsl:sequence select="//xs:element[not(@name = $mixed)]/@name => distinct-values()"/>
    
    Elements whose whitespace is not subject to munging include `code`, `codeblock` and `preformat`
      (per docs at https://niso-sts.org/TagLibrary/niso-sts-TL-1-1d1-html/ )     

    -->
    
    <xsl:template match="/" mode="#default">
        <xsl:comment> &lt;!DOCTYPE standard
  PUBLIC "-//NISO//DTD NISO STS Extended Tag Set (NISO STS) DTD with OASIS and XHTML Tables with MathML 3.0 v1.0 20171031//EN" "NISO-STS-extended-1-mathml3.dtd"> </xsl:comment>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:strip-space elements="abstract ack address adoption adoption-front aff-alternatives alternatives annotation anonymous app app-group array article-categories article-meta author-comment author-notes award-group back bio body boxed-text break caption chem-struct-wrap citation-alternatives col colgroup collab-alternatives comm-ref-group compl-title-wrap compound-kwd compound-subject conference contrib contrib-group count counts custom-meta custom-meta-group date def def-item def-list disp-formula-group disp-quote doc-ident editing-instruction element-citation equation-count fig fig-count fig-group floats-group fn fn-group front funding-group glossary glyph-ref graphic history hr ics-wrap index index-div index-entry index-group index-term index-term-range-end index-title-group inline-graphic institution-wrap intro-title-wrap is-proof iso-meta kwd-group license list list-item main-title-wrap media meta-note milestone-end milestone-start name name-alternatives nat-meta nested-kwd nlm-citation non-normative-example non-normative-note normative-example normative-note note notes notes-group open-access overline-end overline-start page-count permissions private-char publisher ref ref-count ref-list reg-meta ruby sec sec-meta speech standard statement std-doc-meta std-id-group std-ident std-meta std-org std-org-group std-xref sub-part subj-group supplementary-material table table-count table-wrap table-wrap-foot table-wrap-group tbody term-display term-sec tfoot thead title-group title-wrap toc toc-div toc-entry toc-group toc-title-group tr trans-abstract trans-title-group underline-end underline-start verse-group volume-issue-group word-count"/>
    
    <xsl:mode name="fair-copy" on-no-match="shallow-copy"/>
    
    <xsl:output indent="no"/>

    <xsl:param name="indent-spaces" select="2"/>
    
    <xsl:variable name="indent-ws" select="(1 to xs:integer($indent-spaces)) ! ' '"/>
    
    <xsl:template mode="fair-copy" match="code//text() | codeblock//text() | preformat//text() | *[
        @xml:space='preserve']">
        <xsl:sequence select="string(.)"/>
    </xsl:template>
    
    <xsl:template mode="fair-copy" match="text()">
        <xsl:sequence select="replace(string(.),'\s+',' ')"/>
    </xsl:template>
    
    <xsl:template  mode="fair-copy" match="/comment() | /processing-instruction()">
            <xsl:text>&#xA;</xsl:text>
            <xsl:next-match/>
    </xsl:template>
        
    <xsl:template mode="fair-copy" match="abstract/* | ack/* | address/* | adoption/* | adoption-front/* | aff-alternatives/* | alternatives/* | annotation/* | anonymous/* | app/* | app-group/* | array/* | article-categories/* | article-meta/* | author-comment/* | author-notes/* | award-group/* | back/* | bio/* | body/* | boxed-text/* | break/* | caption/* | chem-struct-wrap/* | citation-alternatives/* | col/* | colgroup/* | collab-alternatives/* | comm-ref-group/* | compl-title-wrap/* | compound-kwd/* | compound-subject/* | conference/* | contrib/* | contrib-group/* | count/* | counts/* | custom-meta/* | custom-meta-group/* | date/* | def/* | def-item/* | def-list/* | disp-formula-group/* | disp-quote/* | doc-ident/* | editing-instruction/* | element-citation/* | equation-count/* | fig/* | fig-count/* | fig-group/* | floats-group/* | fn/* | fn-group/* | front/* | funding-group/* | glossary/* | glyph-ref/* | graphic/* | history/* | hr/* | ics-wrap/* | index/* | index-div/* | index-entry/* | index-group/* | index-term/* | index-term-range-end/* | index-title-group/* | inline-graphic/* | institution-wrap/* | intro-title-wrap/* | is-proof/* | iso-meta/* | kwd-group/* | license/* | list/* | list-item/* | main-title-wrap/* | media/* | meta-note/* | milestone-end/* | milestone-start/* | name/* | name-alternatives/* | nat-meta/* | nested-kwd/* | nlm-citation/* | non-normative-example/* | non-normative-note/* | normative-example/* | normative-note/* | note/* | notes/* | notes-group/* | open-access/* | overline-end/* | overline-start/* | page-count/* | permissions/* | private-char/* | publisher/* | ref/* | ref-count/* | ref-list/* | reg-meta/* | ruby/* | sec/* | sec-meta/* | speech/* | standard/* | statement/* | std-doc-meta/* | std-id-group/* | std-ident/* | std-meta/* | std-org/* | std-org-group/* | std-xref/* | sub-part/* | subj-group/* | supplementary-material/* | table/* | table-count/* | table-wrap/* | table-wrap-foot/* | table-wrap-group/* | tbody/* | term-display/* | term-sec/* | tfoot/* | thead/* | title-group/* | title-wrap/* | toc/* | toc-div/* | toc-entry/* | toc-group/* | toc-title-group/* | tr/* | trans-abstract/* | trans-title-group/* | underline-end/* | underline-start/* | verse-group/* | volume-issue-group/* | word-count/* | std-org-loc[empty(child::text()[matches(.,'\S')])]/*" expand-text="true"
        >
        <xsl:variable name="me" select="."/>
        <!--LF before start tag if no one has closed before us (giving an LF) -->
        <xsl:text>{ (: conditional LF :) '&#xA;'[$me/preceding-sibling::* => empty()] }</xsl:text>
        <xsl:text>{ (: indent :) (ancestor::* ! $indent-ws) => string-join('') }</xsl:text>
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates mode="fair-copy"/>
            <!-- conditionally indent before the end tag -->
            <xsl:apply-templates select="." mode="tag-indent"/>
        </xsl:copy>
        <!--LF after end tag-->
        <xsl:text>&#xA;</xsl:text>
    </xsl:template>
        
        <!-- will match any element not element-only -->
        <xsl:template match="*" mode="tag-indent"/>
        
        <!-- for indenting the end tag we match element-only, but not their children
             e.g. a 'p' is indented at the start (matching sec/* above) but not at the end (not matching here) -->
        <xsl:template
            match="abstract | ack | address | adoption | adoption-front | aff-alternatives | alternatives | annotation | anonymous | app | app-group | array | article-categories | article-meta | author-comment | author-notes | award-group | back | bio | body | boxed-text | break | caption | chem-struct-wrap | citation-alternatives | col | colgroup | collab-alternatives | comm-ref-group | compl-title-wrap | compound-kwd | compound-subject | conference | contrib | contrib-group | count | counts | custom-meta | custom-meta-group | date | def | def-item | def-list | disp-formula-group | disp-quote | doc-ident | editing-instruction | element-citation | equation-count | fig | fig-count | fig-group | floats-group | fn | fn-group | front | funding-group | glossary | glyph-ref | graphic | history | hr | ics-wrap | index | index-div | index-entry | index-group | index-term | index-term-range-end | index-title-group | inline-graphic | institution-wrap | intro-title-wrap | is-proof | iso-meta | kwd-group | license | list | list-item | main-title-wrap | media | meta-note | milestone-end | milestone-start | name | name-alternatives | nat-meta | nested-kwd | nlm-citation | non-normative-example | non-normative-note | normative-example | normative-note | note | notes | notes-group | open-access | overline-end | overline-start | page-count | permissions | private-char | publisher | ref | ref-count | ref-list | reg-meta | ruby | sec | sec-meta | speech | standard | statement | std-doc-meta | std-id-group | std-ident | std-meta | std-org | std-org-group | std-xref | sub-part | subj-group | supplementary-material | table | table-count | table-wrap | table-wrap-foot | table-wrap-group | tbody | term-display | term-sec | tfoot | thead | title-group | title-wrap | toc | toc-div | toc-entry | toc-group | toc-title-group | tr | trans-abstract | trans-title-group | underline-end | underline-start | verse-group | volume-issue-group | word-count | std-org-loc[empty(child::text()[matches(.,'\S')])]"
            mode="tag-indent"  expand-text="true">
            <xsl:text>{ (: indent :) (ancestor::* ! $indent-ws) => string-join('') }</xsl:text>
        </xsl:template>
        
</xsl:stylesheet>