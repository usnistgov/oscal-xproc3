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
      
      <catalog uuid="27d2b146-2a4b-4a4e-9562-f18564b77b5c">
         <metadata>
            <title>Electronic Transcription - US Army Field Manual 6-22: Developing Leaders (November 2022) - Chapter 4: Learning and Developmental Activities</title>
            <last-modified>2024-09-10T15:19:38.6995852-04:00</last-modified>
            <version>0.8 draft</version>
            <oscal-version>1.1.2</oscal-version>
            <remarks>
               <p>This encoded representation of Field Manual 6-22 was produced from published source <em>without explicit authorization from</em> or <em>any coordination with</em> the document's originators or the US Army. Reliance on this representation without reference to the publication from which it is derived is not advised.</p>
               <p>See the repository readme for further documentation.</p>
            </remarks>
         </metadata>
         <group id="full-text">
            <title>Learning and Developmental Activities</title>
            <xsl:apply-templates/>
         </group>
         <group id="attributes">
            <title>Attributes</title>
            <xsl:apply-templates select="body/descendant::table-wrap[@custom-type = 'attribute']"
               mode="competency-controls"/>
         </group>
         <group id="competencies">
            <title>Competencies</title>
            <xsl:apply-templates select="body/descendant::table-wrap[@custom-type = 'competency']"
               mode="competency-controls"/>
         </group>
      </catalog>
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
         <xsl:apply-templates select="* except (caption | label)"/>         
      </part>
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
      <xsl:variable name="class" select="if (@id = key('by-id','table4_4')//td/p/xref/@rid) then 'attribute' else 'competency'"/>
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