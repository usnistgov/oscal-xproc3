<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xlink="http://www.w3.org/1999/xlink" exclude-result-prefixes="#all"
    xpath-default-namespace="http://csrc.nist.gov/ns/oscal/1.0" version="3.0">

    <xsl:output indent="true"/><!-- for now; make a post-process later -->
    
    <xsl:strip-space
        elements="catalog metadata group control part link back-matter resource param select"/>
    <!--
        
    OSCAL to NIST STS conversion
    
    find STS here: https://niso-sts.org/
    Tag Library here: https://niso-sts.org/TagLibrary/niso-sts-TL-1-1d1-html/index.html
    
    'Full text' combining main text of SP800-53 with
      assessement objectives and methods from SP800-53A
      Baseline assignments in "impact tables" per control?
      
    Other versions will render separately
      53A Assessment Objectives and Methods
      53B Baseline assignment tables
      Tables C1-C20
      
    fun stuff - transpose from HTML rendition
      x SP800-53A (assessment objectives and methods; ODP surveys) into a separate section?
        x Q for VP
      x Tables C1-C20
        o Withdrawn notices with links
        o moved-to links?
      x Add label to control/control/title
      x 'withdrawn' controls
        x amend control title with "(Withdrawn)"
        x make sure links work
      x References and Related controls list
      x check: do enhancements never have References?
        (//control//control//link/@rel => distinct-values() => string-join(' ') returns
         'required related incorporated-into moved-to') 
      x Back matter
      x nested list for statement items
      x tabular display for SP800-53A contents
      x anchors and cross-references
      x anything that might happen inline
      x front / metadata

      o generic handling of props, links and parts
      o handling of prop/remarks - non-normative-note
      o extend STS display for new stuff
        o RLM examples
        
    -->

    <!--<xsl:import href="sts-reflow-ws.xsl"/>-->
    
    <xsl:param name="include-53A" as="xs:string">false</xsl:param>
    
    <xsl:variable name="dropping-53A" select="not($include-53A = 'true')"/>
   
    <xsl:variable name="drop-properties" as="xs:string*" select="'fisma-baseline','implementation-level','contributes-to-assurance'"/>

    <xsl:template match="/catalog">
            <standard>
                <front>
                    <xsl:call-template name="metadata-block"/>
                </front>
                <body>
                    <xsl:apply-templates/>
                </body>
                <xsl:apply-templates select="back-matter" mode="back-matter"/>
            </standard>
    </xsl:template>

    <xsl:template match="@*"/>

    <xsl:template match="@id">
        <xsl:copy-of select="."/>
    </xsl:template>


    <xsl:template match="metadata"/>

    <xsl:template match="group">
        <sec sec-type="family">
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </sec>
    </xsl:template>

    <xsl:template match="control">
        <xsl:variable name="withdrawn" select="prop[@name = 'status']/@value = ('Withdrawn','withdrawn')"/>
        <sec sec-type="{ 'withdrawn-'[$withdrawn] }{ if (parent::control) then 'control-enhancement' else 'control' }">
            <xsl:apply-templates select="@id"/>
            <xsl:apply-templates select="." mode="title"/>
            <xsl:apply-templates select="* except (control | link | part)"/>
            
            <xsl:choose>
                <xsl:when test="$dropping-53A">
                    <xsl:apply-templates select="part"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:for-each-group select="part" group-adjacent="@name">
                        <xsl:choose>
                            <xsl:when test="not(current-grouping-key() = 'assessment-method')">
                                <xsl:apply-templates select="current-group()"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <!-- there's only one type in the data so we hard code it -->
                                <xsl:call-template name="conditional-section">
                                    <xsl:with-param name="things" select="current-group()"/>
                                    <xsl:with-param name="sg">Assessment Method</xsl:with-param>
                                    <xsl:with-param name="pl">Assessment Methods</xsl:with-param>
                                    <xsl:with-param name="sec-type"
                                        select="current-grouping-key() || 's'"/>
                                </xsl:call-template>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each-group>
                </xsl:otherwise>
            </xsl:choose>
            

            <xsl:call-template name="link-listing">
                <xsl:with-param name="links" select="link[@rel = 'related']"/>
                <xsl:with-param name="sg">Related Control</xsl:with-param>
                <xsl:with-param name="pl">Related Controls</xsl:with-param>
                <xsl:with-param name="sec-type">related-controls</xsl:with-param>
            </xsl:call-template>

            <xsl:if test="empty(parent::control)">
                <xsl:if test="not($withdrawn)">
                    <xsl:call-template name="link-listing">
                        <xsl:with-param name="links" select="child::link[@rel = 'reference']"/>
                        <xsl:with-param name="sg">Reference</xsl:with-param>
                        <xsl:with-param name="pl">References</xsl:with-param>
                        <xsl:with-param name="sec-type">references</xsl:with-param>
                    </xsl:call-template>
                </xsl:if>
                <xsl:call-template name="conditional-section">
                    <xsl:with-param name="things" select="child::control"/>
                    <xsl:with-param name="sg">Control Enhancement</xsl:with-param>
                    <xsl:with-param name="pl">Control Enhancements</xsl:with-param>
                    <xsl:with-param name="sec-type">control-enhancements</xsl:with-param>
                </xsl:call-template>
            </xsl:if>
            <!--<xsl:call-template name="control-section-title"/>-->

            <!-- impact table went here -->
        </sec>
    </xsl:template>

    <xsl:template match="param"/>

    <xsl:template match="title">
        <title>
            <xsl:apply-templates/>
        </title>
    </xsl:template>

    <xsl:template match="control/control/title" mode="title" priority="12" expand-text="true">
        <label>{ ../prop[@name = 'label'][1]/@value }</label>
        <title><sc>{ ancestor::control/title => string-join(' | ') }</sc>
            <xsl:call-template name="mark-withdrawn"/>
        </title>
    </xsl:template>


    <xsl:template priority="50" match="part[@name=('assessment-method', 'assessment-objective')][$dropping-53A]"/>
    
    <xsl:template match="part">
        <sec sec-type="{ @name }">
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="." mode="title"/>
            <xsl:apply-templates select="* except part"/>
            <xsl:where-populated>
                <list list-type="simple" list-content="{@name}-list">
                    <xsl:apply-templates select="." mode="list-type"/>
                    <xsl:apply-templates select="part"/>
                </list>
            </xsl:where-populated>
        </sec>
    </xsl:template>

    <xsl:template match="part[@name = 'assessment-method']">
        <sec sec-type="{ @name }">
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="." mode="title"/>
            <xsl:apply-templates select="*"/>
        </sec>
    </xsl:template>

    <xsl:template match="part/title"/>

    <xsl:template match="part" mode="title">
        <xsl:apply-templates mode="title" select="prop[@name = 'label'][1]"/>
        <xsl:apply-templates mode="title" select="title"/>
        <xsl:on-empty expand-text="true">
            <title>{ (@name/string(),'part') => head() => upper-case() }</title>
        </xsl:on-empty>
    </xsl:template>

    <xsl:template match="part/title" mode="title">
        <title>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </title>
    </xsl:template>

    <xsl:template match="prop[@name='status'][matches(.,'Withdrawn','i')]">
        <p class="withdrawn-status">
            <xsl:text>[Withdrawn</xsl:text>
            <xsl:variable name="withdrawn-to" select="../link[@rel = ('moved-to', 'incorporated-into')]"/>
            <xsl:variable name="link-label">
                <xsl:choose>
                    <xsl:when test="empty($withdrawn-to)">. </xsl:when>
                    <xsl:when test="$withdrawn-to/@rel = 'incorporated-into'">: Incorporated into </xsl:when>
                    <xsl:otherwise>: Moved to </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="withdrawn-statement">
                <xsl:sequence select="$link-label"/>
                <xsl:for-each-group select="$withdrawn-to" group-by="true()">
                    <xsl:for-each select="current-group()">
                        <xsl:if test="position() gt 1">, </xsl:if>
                        <xsl:apply-templates select="." mode="link-as-link"/>
                    </xsl:for-each>
                </xsl:for-each-group>
                <xsl:for-each select="../part[@name = 'statement']/*">
                    <xsl:apply-templates/>
                </xsl:for-each>
            </xsl:variable>
            <xsl:sequence select="$withdrawn-statement"/>
            <xsl:if test="not(matches(string($withdrawn-statement), '\.\s*$'))">.</xsl:if>
            <xsl:text>]</xsl:text>
        </p>
    </xsl:template>
    
    <xsl:template match="prop[@name = 'label']"/>

    <xsl:template match="prop[@name = 'sort-id']"/>

    <xsl:template match="prop[@name = 'label']" mode="title">
        <label>
            <xsl:apply-templates select="@* except @value"/>
            <xsl:value-of select="@value"/>
        </label>
    </xsl:template>

    <xsl:template match="prop">
        <p>
            <xsl:apply-templates select="@* except @value"/>
            <xsl:value-of select="@value"/>
            <xsl:apply-templates select="remarks"/>
        </p>
    </xsl:template>

    <xsl:template match="remarks">
        <non-normative-note>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </non-normative-note>
    </xsl:template>

    <xsl:template match="p">
        <p>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="insert" expand-text="true">
        <xsl:variable name="param" select="key('param-by-id', attribute::id-ref)"/>
        <italic>
            <named-content content-type="odp">
                <!-- vocab-term-identifier="{ @id-ref }" -->
                <xsl:apply-templates mode="insert" select="$param"/>
                <!--if the param is defined outside the nearest containing control -->
                <xsl:if test="exists($param except ancestor::control[1]/child::param)">
                    <xsl:variable name="param-control-label"
                        select="$param/../prop[@name = 'label'][1]/@value"/>
                    <!--defined in the base control (SI-10)-->
                    <xsl:choose>
                        <!--if the param is not defined outside any ancestor -->
                        <xsl:when test="exists($param except ancestor::control/param)"> defined in {
                            $param-control-label }</xsl:when>
                        <xsl:otherwise> defined in the base control ({ $param-control-label
                            })</xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </named-content>
        </italic>
    </xsl:template>

    <xsl:key name="param-by-id" match="param" use="@id"/>

    <xsl:template match="param" mode="insert">
        <xsl:text>[</xsl:text>
        <xsl:apply-templates select="value, select"/>
        <xsl:if test="empty(value | select)">
            <xsl:text>Assignment: </xsl:text>
            <xsl:apply-templates select="label"/>
        </xsl:if>
        <xsl:text>]</xsl:text>
    </xsl:template>

    <xsl:template match="value">
        <xsl:if test="empty(preceding-sibling::value)">Assignment: </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="select">
        <xsl:text expand-text="true">Select{ if (@how-many='one-or-more') then ' (one or more):'  else ':' } </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="select/choice">
        <xsl:if test="exists(preceding-sibling::choice)">; </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>

    
    <xsl:template match="a[starts-with(@href,'#')]">
        <xsl:variable name="id">
            <xsl:apply-templates select="key('link-targets',@href)" mode="coin-ID"/>
        </xsl:variable>
        <xref rid="{ $id }" ref-type="bibr">
            <xsl:apply-templates select="key('link-targets',@href)" mode="add-ref-type"/>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </xref>
    </xsl:template>
    
    <xsl:template match="a">
        <ext-link>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </ext-link>
    </xsl:template>
    
    <xsl:template match="@href[starts-with(.,'#')]"/>
    
    <xsl:template match="@href">
        <xsl:attribute name="xlink:href" select="."/>
    </xsl:template>

    <xsl:template match="q">
        <xsl:text>&#8220;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&#8220;</xsl:text>
    </xsl:template>

    <xsl:template match="b | strong">
        <bold>
            <xsl:apply-templates/>
        </bold>
    </xsl:template>

    <xsl:template match="i | emph">
        <italic>
            <xsl:apply-templates/>
        </italic>
    </xsl:template>


    <xsl:template name="link-listing" expand-text="true">
        <xsl:param name="links"/>
        <xsl:param name="sg">Link</xsl:param>
        <xsl:param name="pl">Links</xsl:param>
        <xsl:param name="sec-type">links</xsl:param>
        <xsl:variable name="count-of-things" select="count($links)"/>
        <xsl:if test="exists($links)">
            <sec sec-type="{ $sec-type }">
                <title>{ if (count($links) = 1) then $sg else $pl }</title>
                <p>
                    <xsl:iterate select="$links">
                        <xsl:apply-templates select="." mode="link-as-link"/>
                        <xsl:if test="not(position() eq last())">; </xsl:if>
                    </xsl:iterate>
                </p>
            </sec>
        </xsl:if>
    </xsl:template>

    <xsl:template name="conditional-section" expand-text="true">
        <xsl:param name="things"/>
        <xsl:param name="sg">Thing</xsl:param>
        <xsl:param name="pl">Things</xsl:param>
        <xsl:param name="sec-type">section</xsl:param>
        <xsl:if test="exists($things)">
            <sec sec-type="{ $sec-type }">
                <title>{ if (count($things) = 1) then $sg else $pl }</title>
                <xsl:apply-templates select="$things"/>
            </sec>
        </xsl:if>
    </xsl:template>

    <!-- Check out xsl:template[@mode='impact-table'] in the original SP800-53 rendering XSL
       for drawing the impact table in HTML -->

    <!-- Picked up in parent -->
    <xsl:template match="control/title"/>

    <xsl:template name="make-title">
        <xsl:param name="runins" select="/text()"/>
        <title>
            <xsl:apply-templates select="$runins" mode="run-in"/>
            <xsl:for-each select="title">
                <xsl:apply-templates/>
            </xsl:for-each>
        </title>
    </xsl:template>

    <!--<xsl:template match="control/part">
      <div class="part {@name}">
         <xsl:copy-of select="@id"/>
            <xsl:apply-templates select="." mode="summary-title"/>
            <xsl:apply-templates/>
      </div>
   </xsl:template>-->

    <!--<xsl:template match="control/part[@name='statement']" priority="2">
      <div class="part {@name}">
         <xsl:copy-of select="@id"/>
            <xsl:apply-templates/>
       </div>
   </xsl:template>-->

    <xsl:template mode="title" priority="3" match="control/part[@name = 'statement']">
        <title>Control</title>
    </xsl:template>

    <xsl:template mode="title" priority="3" match="control/part[@name = 'guidance']">
        <title>Discussion</title>
    </xsl:template>

    <!-- Statements of withdrawn controls are picked up with the 'withdrawn' prop below. -->
    <xsl:template priority="5"
        match="control[matches(prop[@name = 'status'][1], 'Withdrawn', 'i')]/part[@name = 'statement']"/>

    <xsl:template match="part[@name = 'assessment-method']/prop[@name = 'method']"/>

    <xsl:template
        match="part[@name = 'item'] | part[@name = 'assessment-objective']/part[@name = 'assessment-objective']">
        <list-item>
            <xsl:apply-templates select="@*"/>
            <label>
                <xsl:apply-templates select="." mode="part-number"/>
            </label>
            <xsl:apply-templates select="* except part"/>
            <xsl:where-populated>
                <list list-type="simple" list-content="{@name}-list">
                    <xsl:apply-templates select="." mode="list-type"/>
                    <xsl:apply-templates select="part"/>
                </list>
            </xsl:where-populated>
        </list-item>
    </xsl:template>

    <xsl:template match="*" mode="list-type">
        <xsl:attribute name="list-type">simple</xsl:attribute>
    </xsl:template>
    
    <!-- calling these numeric by default -->
    <xsl:template match="part[part/@name='item']" mode="list-type">
        <xsl:attribute name="list-type">order</xsl:attribute>
    </xsl:template>
    
    <!-- unless they are marked with alphabetic chars -->
    <xsl:template priority="10" match="part[exists( part[@name='item'][matches(prop[@name='label']/@value,'[a-z]')] )]" mode="list-type">
        <xsl:attribute name="list-type">alpha-lower</xsl:attribute>
    </xsl:template>
    
    <xsl:template match="part[@name = 'assessment-objects']">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="part[@name = 'assessment-objects']/p">
        <named-content content-type="obj">
            <xsl:apply-templates/>
        </named-content>
        <xsl:for-each select="following-sibling::p[1]">; </xsl:for-each>
    </xsl:template>

    <xsl:template priority="10" match="part//part" mode="title"/>

    <xsl:template match="part" mode="part-number"/>

    <xsl:template match="part[prop/@name = 'label']" mode="part-number">
        <xsl:value-of select="prop[@name = 'label'][1]/@value"/>
    </xsl:template>

    <xsl:template priority="3" match="part[@name = 'assessment-objective']" mode="part-number">
        <xsl:variable name="inherited-no"
            select="ancestor::*[prop/@name = 'label'][1]/prop[@name = 'label'][1]/@value"/>
        <xsl:variable name="inherited-trimmed" select="translate($inherited-no, ' ', '')"/>
        <xsl:value-of
            select="substring-after(translate(prop[@name = 'label']/@value, ' ', ''), $inherited-trimmed)"
        />
    </xsl:template>

    <xsl:template match="group/title" expand-text="true">
        <title>{ . } Family ({ upper-case(../@id) })</title>
        <p>See <bold><xref rid="tableC-{../@id}" ref-type="table">Table C-<xsl:value-of select="count(../(. | preceding-sibling::group))"/></xref></bold> for control summaries.</p>
    </xsl:template>

    <xsl:template match="control" mode="title">
        <xsl:apply-templates select="title" mode="#current"/>
    </xsl:template>

    <xsl:template match="control/title" mode="title" expand-text="true">
        <label>{ parent::control/prop[@name='label'][1]/@value }</label>
        <title>
            <xsl:apply-templates/>
            <xsl:call-template name="mark-withdrawn"/>
        </title>
    </xsl:template>
    
    <xsl:template name="mark-withdrawn">
        <xsl:if test="../prop[@name = 'status']/@value = ('Withdrawn', 'withdrawn')"> (WITHDRAWN)</xsl:if>
    </xsl:template>

    <xsl:template priority="2" match="part[@name = 'assessment-objective']" mode="title">
        <title>
            <xsl:text>Assessment Objective</xsl:text>
            <xsl:if test="part">s</xsl:if>
        </title>
    </xsl:template>

    <xsl:template priority="2" match="part[@name = 'assessment-method']" mode="title">
        <title>
            <xsl:value-of select="prop[@name = 'method']/@value"/>
        </title>
    </xsl:template>

    <xsl:template match="part[@name = 'overview']/title" priority="2" mode="title">
        <title>
            <xsl:apply-templates/>
        </title>
    </xsl:template>

    <xsl:template
        match="part[@name = 'assessment-objects']/p/text()[last()]">
        <xsl:value-of select="."/>
        <xsl:text expand-text="true">{ if (exists(../following-sibling::p)) then ';' else '.' } </xsl:text>
    </xsl:template>

    <xsl:template match="part[@name = 'guidance']/link"/>

    <xsl:template match="prop[@name = 'status'][@value = ('Withdrawn','withdrawn')]">
        <p>
            <xsl:text>[</xsl:text>
            <xsl:call-template name="annotate-withdrawn-control">
                <xsl:with-param name="withdrawn-to" select="../link[@rel = ('moved-to', 'incorporated-into')]"/>
                <xsl:with-param name="statement" select="../part[@name = 'statement']"/>
            </xsl:call-template>
            <xsl:text>]</xsl:text>
        </p>
    </xsl:template>
    
    <xsl:template name="annotate-withdrawn-control">
        <xsl:param name="label" as="xs:string">Withdrawn</xsl:param>
        <xsl:param name="withdrawn-to" select="()"/>
        <xsl:param name="statement" select="()"/>
        <xsl:variable name="withdrawn-statement">
            <xsl:value-of select="$label"/>
            <xsl:choose>
                <xsl:when test="empty($withdrawn-to)">. </xsl:when>
                <xsl:when test="$withdrawn-to/@rel = 'incorporated-into'">: Incorporated into </xsl:when>
                <xsl:otherwise>: Moved to </xsl:otherwise>
            </xsl:choose>
            <xsl:for-each-group select="$withdrawn-to" group-by="true()">
                <xsl:for-each select="current-group()">
                    <xsl:if test="position() gt 1">, </xsl:if>
                    <xsl:apply-templates select="." mode="link-as-link"/>
                </xsl:for-each>
            </xsl:for-each-group>
            <xsl:for-each select="$statement/*">
                <xsl:apply-templates/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:sequence select="$withdrawn-statement"/>
        <!-- add a period if not already there -->
        <xsl:if test="not(matches(string($withdrawn-statement), '\.\s*$'))">.</xsl:if>
    </xsl:template>
    
    

    <!-- Don't want to display -->
    <xsl:template match="prop[@name = $drop-properties]"/>

    <!-- overriding the imported stylesheet to suppress labeling of links  -->
    <xsl:template match="link" mode="link-label"/>

    <xsl:template match="part[@name = 'assessment-objective']//part[@name = 'assessment-objective']"
        priority="2" mode="title"/>

    <xsl:template name="guidance-links">
        <xsl:param name="links" select="link[@rel = 'related']"/>
        <p>
            <xsl:for-each-group select="$links" group-by="true()" expand-text="true">
                <bold> Related { if (count(current-group()) eq 1) then 'control' else 'controls'
                    }</bold>
                <xsl:text>: </xsl:text>
                <xsl:for-each select="current-group()">
                    <xsl:if test="position() gt 1">, </xsl:if>
                    <xsl:apply-templates select="." mode="link-as-link"/>
                </xsl:for-each>
                <xsl:text>.</xsl:text>
            </xsl:for-each-group>
        </p>
    </xsl:template>

    <xsl:template match="link[starts-with(@href, '#')]" mode="link-as-link" expand-text="true">
        <xsl:variable name="target" select="key('link-targets', @href)"/>
        <xsl:variable name="id">
            <xsl:apply-templates select="$target" mode="coin-ID"/>
        </xsl:variable>
        <xref rid="{ $id }">
            <xsl:apply-templates select="$target" mode="add-ref-type"/>
            <xsl:apply-templates select="$target" mode="link-text"/>
        </xref>
    </xsl:template>


    <xsl:template match="*[exists(title)]" priority="-0.3" mode="title"/>

    <xsl:key name="param-for-id" match="param" use="@id"/>

    <xsl:template match="back-matter"/>
    
    <xsl:template match="back-matter" mode="back-matter">
        <back>
            <xsl:call-template name="make-resource-table"/>
            <xsl:where-populated>
                <app-group>
                    <xsl:call-template name="inject-AppendixC"/>
                </app-group>
            </xsl:where-populated>
        </back>
    </xsl:template>
    
    <!--<xsl:key name="cross-references" match="link[starts-with(@href,'#')]" use="replace(@href,'^#','')"/>-->
    <xsl:key name="link-targets" match="*[exists(@id | @uuid)]" use="'#' || (@id, @uuid)[1]"/>

    <xsl:template name="make-resource-table">
        <xsl:where-populated>
        <ref-list>
            <xsl:apply-templates select="resource"/>
        </ref-list>
        </xsl:where-populated>
    </xsl:template>

    <xsl:template match="@uuid">
        <xsl:variable name="id">
            <xsl:apply-templates select=".." mode="coin-ID"/>
        </xsl:variable>
        <xsl:attribute name="id" select="$id"/>
    </xsl:template>

    <xsl:template match="*[@id]" mode="coin-ID" priority="5">
        <xsl:text expand-text="true">{ @id }</xsl:text>
    </xsl:template>

    <xsl:template match="*[@uuid]" mode="coin-ID">
        <xsl:variable name="pos">
            <xsl:number level="any"/>
        </xsl:variable>
        <xsl:text expand-text="true">{ local-name() }-{ $pos }_{ @uuid => substring(1,3) }</xsl:text>
    </xsl:template>

    <xsl:template match="back-matter/resource">
        <ref>
            <xsl:apply-templates select="@uuid"/>
            <xsl:apply-templates/>
            <xsl:if test="empty(citation)">
                <mixed-citation>
                    <xsl:for-each select="title">
                        <source>
                            <xsl:apply-templates/>
                        </source>    
                    </xsl:for-each>
                    <xsl:apply-templates select="rlink" mode="cited"/>
                </mixed-citation>
            </xsl:if>
        </ref>
    </xsl:template>
    
    <xsl:template match="resource/title" priority="4">
        <label>
            <xsl:apply-templates/>
        </label>
    </xsl:template>

    <xsl:template priority="2" match="resource/citation">
        <mixed-citation>
            <xsl:apply-templates select="./text"/>
            <xsl:apply-templates select="../rlink" mode="cited"/>
        </mixed-citation>
    </xsl:template>

    <xsl:template match="rlink" priority="2"/>

    <xsl:template match="rlink" mode="cited" priority="2">
        <xsl:text> </xsl:text>
        <ext-link>
            <xsl:apply-templates select="@href"/>
            <xsl:value-of select="@href"/>
        </ext-link>
        <xsl:if test="not(matches(@href, '\.$'))">.</xsl:if>
    </xsl:template>

    <xsl:template match="control" mode="link">
        <xref rid="{ @id }" ref-type="sec">
            <xsl:value-of select="prop[@name = 'label']"/>
        </xref>
    </xsl:template>

    <xsl:template match="control" mode="link-text">
        <xsl:value-of select="prop[@name = 'label'][1]/@value"/>
    </xsl:template>

    <xsl:template match="part" mode="link-text">
        <xsl:for-each select="ancestor::control[1] | ancestor-or-self::part">
            <xsl:value-of select="prop[@name = 'label'][1]/@value"/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="resource" mode="link-text">
        <xsl:value-of select="title"/>
    </xsl:template>


    <xsl:template name="metadata-block">
        <std-doc-meta>
            <title-wrap>
                <main-title-wrap>
                    <xsl:for-each select="/catalog/metadata/title" expand-text="true">
                        <main>
                            <xsl:apply-templates/>
                        </main>
                    </xsl:for-each>
                </main-title-wrap>
            </title-wrap>
            <std-ident>
                <doc-type>NIST Special Publication</doc-type>
                <doc-number>SP 800-53</doc-number>
                <version>5.1</version>
            </std-ident>
                <std-org std-org-role="developer">
                    <std-org-name>National Institute of Standards and Technology: Computer Security Division</std-org-name>
                    <std-org-abbrev>NIST CSD</std-org-abbrev>
                    <std-org-loc>
                        <addr-line>National Institute of Standards and Technology</addr-line>
                        <addr-line>Attn: Computer Security Division</addr-line>
                        <addr-line>Information Technology Laboratory</addr-line>
                        <addr-line>100 Bureau Drive (Mail Stop 8930)</addr-line>
                        <city>Gaithersburg</city>
                        <state>MD</state>
                        <postal-code>20899-8930</postal-code>
                        <email>sec-cert@nist.gov</email>
                    </std-org-loc>
                </std-org>
            <content-language>en</content-language>
            <std-ref>NIST SP 800-53</std-ref>
            <kwd-group>
                <xsl:for-each select="/catalog/metadata/prop[@name='keywords']/tokenize(@value,',')" expand-text="true">
                    <kwd>{ normalize-space(.) }</kwd>
                </xsl:for-each>
            </kwd-group>
        </std-doc-meta>
    </xsl:template>
    
    <xsl:mode name="table-C" on-no-match="text-only-copy"/>
    
    <xsl:template match="/catalog" mode="table-C">
        <xsl:apply-templates select="group" mode="#current"/>
    </xsl:template>
    
    <xsl:template match="catalog/group" mode="table-C" expand-text="true">
        <table-wrap id="tableC-{@id}" position="anchor">
            <label>Table C-{ count(.|preceding-sibling::group) }</label>
            <caption>
                <xsl:apply-templates select="title" mode="#current"/>
            </caption>
            <table content-type="control-matrix" id="{@id}-matrix" rules="groups">
                <col width="10%"/>
                <col width="60%"/>
                <col width="15%"/>
                <col width="15%"/>
                <thead>
                    <tr content-type="control-matrix-header">
                        <th scope="col" content-type="label">Control number</th>
                        <th scope="col" content-type="control-title">Control name<break/><sc>control enhancement name</sc></th>
                        <th scope="col">implemented<break/>by</th>
                        <th scope="col">assurance</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:apply-templates select="group | control" mode="table-C"/>
                </tbody>
            </table>
        </table-wrap>
    </xsl:template>
    
    <xsl:template match="group/title" mode="table-C" expand-text="true">
        <title>
            <xsl:apply-templates/>
            <xsl:text> Family — Implementation and Assurance</xsl:text>
        </title>
        <p>
            <xsl:text>See section </xsl:text>
            <xref rid="{../@id}" ref-type="sec">
                <xsl:apply-templates/>
            </xref>
            <xsl:text> for control definitions.</xsl:text>
        </p>
    </xsl:template>
    
    <xsl:template match="control" mode="table-C">
        <xsl:variable name="is-enhancing" select="exists(parent::control)"/>
        <xsl:variable name="withdrawn" select="prop[@name='status']/@value='withdrawn'"/>
        <tr id="tableC-{@id}"
            content-type="{ if ($is-enhancing) then 'enhancement' else 'control' }-summary{ '-withdrawn'[$withdrawn] }">
            <td content-type="control-no">
                <xref rid="{ @id }" ref-type="sec">
                    <xsl:apply-templates mode="#current" select="prop[@name = 'label']"/>
                </xref>
            </td>
            <td content-type="control{'-enhancement'[$is-enhancing]}-title">
                <xsl:apply-templates select="." mode="style-td"/>
                <xsl:apply-templates mode="#current" select="title"/>
            </td>
            <xsl:choose>
                <xsl:when test="$withdrawn">
                    <td colspan="2" content-type="withdrawn-notice">
                        <xsl:call-template name="annotate-withdrawn-control">
                            <xsl:with-param name="label">W</xsl:with-param>
                            <xsl:with-param name="withdrawn-to" select="link[@rel = ('moved-to', 'incorporated-into')]"/>
                        </xsl:call-template>
                    </td>
                </xsl:when>
                <xsl:otherwise>
                    <td align="center">
                        <xsl:apply-templates select="." mode="mark-implementors"/>
                    </td>
                    <td align="center">
                        <xsl:apply-templates select="." mode="mark-assurance"/>
                    </td>        
                </xsl:otherwise>
            </xsl:choose>
        </tr>
        <xsl:apply-templates mode="#current" select="control"/>
    </xsl:template>
    
    <xsl:template priority="2" match="control/control/title" mode="table-C" expand-text="true">
        <sc>
            <xsl:apply-templates/>
        </sc>
    </xsl:template>
    
    <!-- already inside td -->
    <xsl:template match="control/title" mode="table-C" expand-text="true">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template mode="table-C" match="prop"/>
    
    
    <xsl:template mode="table-C" match="prop[@name='label'][not(@class='sp800-53a')]">
        <xsl:value-of select="@value"/>
    </xsl:template>
    
    
    
    <!-- xslt3 -t -xsl:dp.xsl -export:dp.sef.json -nogo   -->
    
    <!--<xsl:param name="fileName" as="xs:string"/>-->
    
    <!--<xsl:key name="item-by-id" match="o:control | o:part" use="@id" xmlns:o="http://csrc.nist.gov/ns/oscal/1.0"/>-->
    
    <xsl:key name="cross-reference" match="control | part" use="'#' || @id"/>
    
    <xsl:variable name="catalog" select="/"/>
    
    <xsl:template name="inject-AppendixC">
        <xsl:apply-templates select="document('AppendixC-intro-sts.xml')/descendant::*:app[@id='appendixC']" mode="acquire"/>
    </xsl:template>
    
    <xsl:mode name="acquire" on-no-match="shallow-copy"/>
    
    <xsl:template match="comment()" mode="acquire"/>
    
    <!-- wildcard match gets around no-namespace on STS data to drop this stub (kept for validity) -->
    <xsl:template match="*:table-wrap[empty(*)]" mode="acquire"/>
    
    <xsl:template mode="acquire" match="processing-instruction('oscal_sp800-53')[normalize-space() = 'Appendix C Tables']">
        <!--<table-wrap-group>-->
            <xsl:apply-templates select="$catalog/*" mode="table-C"/>
        <!--</table-wrap-group>-->
    </xsl:template>
    
    <xsl:template match="control" mode="style-td" expand-text="true">
        <xsl:attribute name="style">font-weight: bold</xsl:attribute>
    </xsl:template>
    
    <xsl:template priority="2" match="control/control" mode="style-td" expand-text="true">
        <xsl:attribute name="style">font-size: smaller</xsl:attribute>
    </xsl:template>
    
    <xsl:template match="control" mode="mark-implementors">
        <xsl:variable name="my" select="."/>
        <xsl:text expand-text="true">{ ('o'[$my/prop[@name='implementation-level']/@value='organization'],
            's'[$my/prop[@name='implementation-level']/@value='system']) => string-join('/') }</xsl:text>
    </xsl:template>
    
    <xsl:template match="control" mode="mark-assurance">
        <xsl:if test="prop[@name='contributes-to-assurance']/@value = 'true'">√</xsl:if>
    </xsl:template>
    
    <xsl:template mode="label" match="group" expand-text="true">{ upper-case(@id) }</xsl:template>
    
    <xsl:template mode="label" match="control" expand-text="true">{ child::prop[@name='label'][not(@class='sp800-53a')]/@value }</xsl:template>
    
    <xsl:template mode="label" match="part" expand-text="true">{ ancestor-or-self::*/prop[@name='label'][not(@class='sp800-53a')]/@value => string-join() }</xsl:template>
    
    <!-- ref-type mode delivers a reference type for a reference targeting any element -->
    
    <xsl:template match="*" mode="add-ref-type">
        <xsl:attribute name="ref-type" select="local-name()"/>
    </xsl:template>
    
    <xsl:template match="group | control | part" mode="add-ref-type">
        <xsl:attribute name="ref-type">sec</xsl:attribute>
    </xsl:template>
    
    <xsl:template match="resource" mode="add-ref-type">
        <xsl:attribute name="ref-type">bibr</xsl:attribute>
    </xsl:template>
    
    
    
    
</xsl:stylesheet>