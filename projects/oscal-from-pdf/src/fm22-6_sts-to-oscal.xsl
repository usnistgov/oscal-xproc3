<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xlink="http://www.w3.org/1999/xlink"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   exclude-result-prefixes="#all"
   xmlns="http://csrc.nist.gov/ns/oscal/1.0">

   <xsl:output indent="true"/>

   <xsl:mode on-no-match="text-only-copy"/>

   <xsl:template match="/processing-instruction()"/>
   
   <xsl:template match="/*">      
      <catalog uuid="3f6dfe83-7241-4619-a253-185e530a35ac">
         <xsl:call-template name="metadata-block"/>
         <group id="full-text">
            <title>Learning and Developmental Activities</title>
            <xsl:apply-templates/>
         </group>
         <group id="attributes">
            <title>Attributes</title>
            <xsl:apply-templates mode="competency-controls"
               select="body/descendant::table-wrap[@custom-type = 'attribute']">
               <xsl:with-param name="class">attribute</xsl:with-param>
            </xsl:apply-templates>
         </group>
         <group id="competencies">
            <title>Competencies</title>
            <xsl:apply-templates mode="competency-controls"
               select="body/descendant::table-wrap[@custom-type = 'competency']"/>
         </group>
      </catalog>
   </xsl:template>
   
   <xsl:template name="metadata-block">
      <metadata>
         <title>Electronic Transcription - US Army Field Manual 6-22: Developing Leaders (November 2022) - Chapter 4: Learning and Developmental Activities</title>
         <last-modified>2024-09-10T15:19:38.6995852-04:00</last-modified>
         <version>0.9 draft</version>
         <oscal-version>1.1.2</oscal-version>
         <role id="encoder">
            <title>Document encoder</title>
         </role>
         <role id="contact">
            <title>Contact</title>
         </role>
         <party uuid="1cbbb30d-fb20-44ba-830a-c7ff821a7616" type="organization">
            <name>XSLT Initiative, OSCAL Project (Open Security Controls Assessment Language)</name>
            <link rel="repository" href="https://github.com/usnistgov/oscal-xproc3"/>
            <email-address>xslt-interest@nist.gov</email-address>
            <address>
               <addr-line>National Institute of Standards and Technology</addr-line>
               <addr-line>Attn: Computer Security Division 773-03</addr-line>
               <addr-line>Information Technology Laboratory</addr-line>
               <addr-line>100 Bureau Drive (Mail Stop 8930)</addr-line>
               <city>Gaithersburg</city>
               <state>MD</state>
               <postal-code>20899-8930</postal-code>
            </address>
         </party>
         <responsible-party role-id="encoder">
            <party-uuid>1cbbb30d-fb20-44ba-830a-c7ff821a7616</party-uuid>
         </responsible-party>
         <responsible-party role-id="contact">
            <party-uuid>1cbbb30d-fb20-44ba-830a-c7ff821a7616</party-uuid>
         </responsible-party>
         <remarks>
            <p>This encoded representation of <b>Field Manual 6-22</b> was produced from published sources independently of the document's originators, <em>without explicit authorization</em> from the US Army or its representatives. While we have done our best to represent the document contents accurately, reliance on this representation without reference to the publication from which it is derived is not advised.</p>
            <p>See the <a href="https://github.com/usnistgov/oscal-xproc3">repository</a> for further information on the project and how we tested the fidelity of the transcription.</p>
         </remarks>
      </metadata>
   </xsl:template>

   <xsl:template match="front"/>
   
   <xsl:template match="body">
      <part name="intro">
         <xsl:apply-templates select="* except sec"/>
      </part>
      <xsl:apply-templates select="sec"/>
      
   </xsl:template>
   
   <xsl:template match="tbody | caption">
      <xsl:apply-templates/>
   </xsl:template>
   
   <xsl:template match="caption/title">
      <title>
         <xsl:apply-templates/>
      </title>
   </xsl:template>
   
   <xsl:template match="sec">
      <!-- for the @id, mapping space to _ and stripping characters not permitted in XML names -->
      <control id="{ title/normalize-space() => lower-case() => translate(' /','__') => replace('\C','') }">
         <xsl:apply-templates select="title"/>
         <xsl:for-each-group select="* except (title|sec)" group-starting-with="p[exists(target)]">
            <xsl:choose>
               <xsl:when test="exists(target)">
                  <part name="enumeration" id="part-{  replace(target,'\.$','') }">
                     <xsl:for-each select="child::target">
                        <prop name="label" value="{ normalize-space(.) }"/>
                     </xsl:for-each>
                     <xsl:apply-templates select="current-group()"/>
                  </part>
               </xsl:when>
            </xsl:choose>
         </xsl:for-each-group>
         <xsl:apply-templates select="sec"/>
      </control>
   </xsl:template>
   
   <xsl:template match="target"/>

   <xsl:variable name="lookup-tables" select="//table-wrap[@id=('table4_4','table4_5')]/table"/>

   <xsl:function name="ox:category-for-control" as="xs:string?">
      <xsl:param name="tableID" as="xs:string"/>
      <xsl:variable name="linking-row" select="$lookup-tables/tbody/tr[td/p/xref/@rid=$tableID]"/>
      <xsl:sequence select="($linking-row | $linking-row/preceding-sibling::tr)[count(td) eq 4][last()]/td[1]/normalize-space(.)"/>
   </xsl:function>
   
   <xsl:function name="ox:subcategory-for-control" as="xs:string?">
      <xsl:param name="tableID" as="xs:string"/>
      <xsl:variable name="linking-row"     select="$lookup-tables/tbody/tr[td/p/xref/@rid=$tableID]"/>
      <xsl:sequence select="($linking-row | $linking-row/preceding-sibling::tr)[count(td) = (3,4)][last()]/td[2]/normalize-space(.)"/>
   </xsl:function>
   
   <xsl:template match="p[starts-with(.,'Tip:')]">
      <part name="tip">
         <prop name="label" value="Tip:"/>
         <p>
           <xsl:apply-templates/>
         </p>
      </part>
   </xsl:template>
   
   <xsl:template match="p[starts-with(.,'Tip:')]/text()[1]">
      <xsl:text expand-text="true">{ substring-after(.,'Tip: ') }</xsl:text>
   </xsl:template>
      
   <xsl:template match="table-wrap">
      <part id="{@id}" name="directory">
         <xsl:apply-templates select="caption, label"/>
         
         <xsl:if test="@id=('table4_4','table4_5')" expand-text="true">
            <xsl:variable name="control-key">{ if (contains(caption/title,'attribute')) then 'attribute' else 'competency' }</xsl:variable>
            <xsl:processing-instruction name="directory"> //control[@class='{ $control-key }'] by prop[@name=('category','subcategory')]</xsl:processing-instruction>
         </xsl:if>
         <xsl:apply-templates select="* except (caption | label)"/>         
      </part>
   </xsl:template>
   
   <xsl:template match="table-wrap[@id='table4_2']">
      <part id="{@id}" name="directory">
         <xsl:apply-templates select="caption, label"/>
         <xsl:call-template name="pivot-table4_2">
            <xsl:with-param name="rows" select="table/tbody/(tr except tr[1])"/>
         </xsl:call-template>
                  
      </part>
   </xsl:template>
   
      
   <xsl:template name="pivot-table4_2" expand-text="true">
      <xsl:param name="rows" as="element(tr)*"/>
      <xsl:for-each-group select="$rows" group-starting-with="tr[count(td) eq 3]">
         <part name="activity">
            <title>{ ./td[1] }</title>
            <xsl:for-each select="current-group() except .">
               <part name="option">
                  <title>{ td[1] }</title>
                  <p>{ td[2]}</p>
               </part>
            </xsl:for-each>
         </part>
      </xsl:for-each-group>
   </xsl:template>
   
   <xsl:template match="boxed-text">
      <part name="boxed">
         <xsl:apply-templates/>
      </part>
   </xsl:template>
   
   <xsl:template match="disp-quote">
      <part name="quoted">
         <xsl:apply-templates/>
      </part>
   </xsl:template>
   
   <xsl:template match="sec/title">
      <title>
         <xsl:apply-templates/>
      </title>
   </xsl:template>
   
   <xsl:template match="table | tr | th | td">
      <xsl:element name="{ name() }" namespace="http://csrc.nist.gov/ns/oscal/1.0">
         <xsl:apply-templates/>
      </xsl:element>
   </xsl:template>
   
   <xsl:template match="label">
      <prop name="label" value="{normalize-space(.)}"/>
   </xsl:template>

   <!-- Dropping in default (no mode) traversal -->
   <xsl:template match="table-wrap[@custom-type=('competency','attribute')]">
      <link href="#{@id}" rel="related"/>
   </xsl:template>
   
   <xsl:key name="by-id" match="*[exists(@id)]" use="@id"/>
   
   <xsl:template match="table-wrap" mode="competency-controls" expand-text="true">
      <xsl:param name="class">competency</xsl:param>
      <control id="{ @id }" class="{ $class }">
         <title>{ caption/title/normalize-space() }</title>
         <prop name="category"    value="{ ox:category-for-control(@id/string(.)) }"/>
         <prop name="subcategory" value="{ ox:subcategory-for-control(@id) }"/>
         
         <part name="evaluation">
            <xsl:apply-templates mode="#current" select="table/tbody/tr[2]/td[1]">
               <xsl:with-param name="title">Strength Indicators</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates mode="#current" select="table/tbody/tr[2]/td[2]">
               <xsl:with-param name="title">Need Indicators</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates mode="#current" select="table/tbody/tr[4]/td[1]">
               <xsl:with-param name="title">Underlying Causes</xsl:with-param>
            </xsl:apply-templates>
         </part>
         <part name="growth-activities">
            <xsl:apply-templates mode="#current" select="table/tbody/tr[5]/td[2]">
               <xsl:with-param name="title">Feedback</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates mode="#current" select="table/tbody/tr[6]/td[2]">
               <xsl:with-param name="title">Study</xsl:with-param>
            </xsl:apply-templates>
            <xsl:apply-templates mode="#current" select="table/tbody/tr[7]/td[2]">
               <xsl:with-param name="title">Practice</xsl:with-param>
            </xsl:apply-templates>
         </part>
      </control>
   </xsl:template>
   
   <xsl:template mode="competency-controls" match="td" expand-text="true">
      <xsl:param name="title">Untitled</xsl:param>
      <part name="{ $title ! lower-case(.) ! translate(.,' ','_') }">
         <title>{ $title }</title>
         <xsl:apply-templates/>
      </part>
   </xsl:template>
   
   <xsl:template match="list">
      <ul>
         <xsl:apply-templates/>
      </ul>
   </xsl:template>
   
   <xsl:template match="list-item">
      <li>
         <xsl:apply-templates/>
      </li>
   </xsl:template>
   
   <xsl:template match="table-wrap[empty(@custom-type)]//td/p">
      <xsl:for-each select="preceding-sibling::*[1]"><br/></xsl:for-each>
      <xsl:apply-templates/>
   </xsl:template>
   
   <xsl:template match="p | attrib">
      <p>
         <xsl:apply-templates/>
      </p>
   </xsl:template>
   
   <xsl:template match="bold">
      <b>
         <xsl:apply-templates/>
      </b>
   </xsl:template>
   
   <xsl:template match="em">
      <emph>
         <xsl:apply-templates/>
      </emph>
   </xsl:template>
   
   <xsl:template match="italic">
      <i>
         <xsl:apply-templates/>
      </i>
   </xsl:template>
   
   <xsl:template match="xref">
      <a href="#{@rid}">
         <xsl:apply-templates/>
      </a>
   </xsl:template>
   
   <xsl:template match="*">
      <xsl:message expand-text="true">Not matching { name() }</xsl:message>
      <xsl:copy copy-namespaces="no">
         <xsl:apply-templates/>
      </xsl:copy>
   </xsl:template>
   
</xsl:stylesheet>