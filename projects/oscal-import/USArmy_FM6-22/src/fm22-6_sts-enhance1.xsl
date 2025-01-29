<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xlink="http://www.w3.org/1999/xlink"
   exclude-result-prefixes="#all">

   <!--<xsl:output indent="true"/>-->

   <xsl:mode on-no-match="shallow-copy"/>

<!--splitting secs into:
everything split apart except 
table-wrap grouped by @id
p when bulleted
drop p when not bulleted?
pull in boxed-text/p per sec
repair boxed-text where needed

-->

<xsl:template match="/*">
   <xsl:processing-instruction name="xml-model">href="../lib/NISO-STS-interchange-1-MathML3-RNG/NISO-STS-interchange-1-mathml3.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:processing-instruction>
   <xsl:processing-instruction name="xml-model">href="../src/fm22-6_chapter4.sch" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:processing-instruction>
   <xsl:next-match/>
</xsl:template>
   
<!-- Repairing the botch job produced by Acrobat and its HTML export here -->
   <xsl:template
      match="boxed-text[string(.) => normalize-space() => starts-with('Determining Developmental Activities')]">
      <boxed-text>
         <caption>
            <title>Determining Developmental Activities</title>
         </caption>
         <p>Answer these to select appropriate developmental activities:</p>
         <list list-type="simple">
            <list-item>
               <p><bold>Developmental Activity:</bold> How do I need to improve?</p>
            </list-item>
            <list-item>
               <p><bold>Desired Outcome:</bold> What do I hope to achieve? </p>
            </list-item>
            <list-item>
               <p><bold>Method:</bold> How am I going to do this? What resources do I need? </p>
            </list-item>
            <list-item>
               <p><bold>Time available:</bold> When will I do this? How will I monitor progress (such as identifying and monitoring milestones, rewarding success, or identifying accountability partners)?</p>
            </list-item>
            <list-item>
               <p><bold>Limits:</bold> What factors will affect or hinder successfully implementing this activity? </p>
            </list-item>
            <list-item>
               <p><bold>Controls:</bold> What minimizes or controls the factors that hinder implementing this activity?</p>
            </list-item>
         </list>
      </boxed-text>
   </xsl:template>
   
   <xsl:template match="p[. = 'Employing Leadership Requirements Model Developmental Activities']">
      <boxed-text>
         <caption>
         <title>
            <xsl:apply-templates/>
         </title>
         </caption>
         <!-- including the following p elements through to the sec end -->
         <xsl:copy-of select="following-sibling::*"/>
      </boxed-text>
   </xsl:template>
      
   <xsl:template match="p[preceding-sibling::p = 'Employing Leadership Requirements Model Developmental Activities']"/>
   
   
  <xsl:template match="sec">
     <xsl:copy>
        <xsl:copy-of select="@*"/>
     <xsl:for-each-group select="*" group-adjacent="(self::p/@style-type,self::table-wrap/@id,'fallback')[1]">
        <xsl:choose>
           <xsl:when test="current-grouping-key() = 'fallback'">
              <xsl:apply-templates select="current-group()"/>
           </xsl:when>
           <xsl:when test="current-grouping-key() = 'bullet'">
              <list list-type="bullet">
                 <xsl:for-each select="current-group()">
                    <list-item>
                       <xsl:apply-templates select="."/>
                    </list-item>
                 </xsl:for-each>
              </list>
           </xsl:when>
           <xsl:when test="starts-with(current-grouping-key(),'table')">
              <table-wrap id="{ current-grouping-key() }">
                 <xsl:apply-templates select="./label"/>
                 <xsl:apply-templates select="./caption"/>
                 <table>
                    <tbody>
                       <xsl:apply-templates select="current-group()//tr"/>
                    </tbody>
                 </table>
              </table-wrap>
           </xsl:when>
           <xsl:otherwise>
              <xsl:apply-templates select="current-group()"/>
              <xsl:message>Unexpected unnaccounted-for element(s) being grouped on key { current-grouping-key() }</xsl:message>
           </xsl:otherwise>
        </xsl:choose>
<!-- groups - current-grouping-key() is '' spill out
           except special case
        @bulleted these are p to be grouped as list
        table ID value - table to be grouped
        
        -->
     </xsl:for-each-group>
     </xsl:copy>
  </xsl:template>
   
   <xsl:template match="body/p[matches(.,'^Table \d\-\d\d?')] | sec/p[matches(.,'^Table \d\-\d\d?')]"/>
   
   <xsl:template match="p/@style-type"/>
   
   <xsl:variable name="pid-regex" as="xs:string">^\s*4\-\d\d?\d?\.</xsl:variable>
   
   <xsl:template match="p/text()[1][matches(.,$pid-regex)]">
      <xsl:analyze-string select="string(.)" regex="{$pid-regex}">
         <xsl:matching-substring>
            <target id="p{ normalize-space(.) ! replace(.,'\.$','') }">
               <xsl:value-of select="normalize-space(.)"/>
            </target>
         </xsl:matching-substring>
         <xsl:non-matching-substring>
            <xsl:value-of select="."/>
         </xsl:non-matching-substring>
      </xsl:analyze-string>
   </xsl:template>
  
  <!--Further adjustments:-->
    <!--Table 4-31 has a cell incorrectly labeled "Needs Indicators"-->
   
   <xsl:template match="tbody/tr/td/p[.='Needs Indicators']">
      <p>Need Indicators</p>
   </xsl:template>
  
   <!--Table 4-78 has a spurious table row capturing text that belongs in the last paragraph of the preceding table row.-->
   
   <xsl:template match="tbody/tr[normalize-space(.)='and prioritize needs. Identify candidates for immediate feedback and coaching.']"/>
   
   <xsl:template match="tbody/tr[following-sibling::tr[1]/normalize-space(.)='and prioritize needs. Identify candidates for immediate feedback and coaching.']/td[2]/p[last()]">
      
      <xsl:copy>
         <xsl:apply-templates/>
         <xsl:text> </xsl:text>
         <xsl:for-each select="parent::td/../following-sibling::tr[1]/td[1]/p">
            <xsl:apply-templates/>
         </xsl:for-each>
      </xsl:copy>
      
   </xsl:template>
   
   
<!--
      
Remediations  to data produced from the HTML sources -

- Repairing boxed-text
  x "Determining Developmental Activities" in section 4-7
  x "Employing Leadership Requirements Model Developmental Activities" in 4-9
   x Grouping list items into lists
   x Consolidating tables where now broken
   x Pull enumerations from p

To validate results:
- diff ../temp/t04_sts-rough.xml and ../temp/t05_sts-nicer.xml
- tables : all in order, all regular, structured correctly?
    (next step being to cast into OSCAL)
- paragraphs - numbered properly?
- compare a generated vs the received copy of Table 4-4

-->




</xsl:stylesheet>