<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   type="ox:MINIMAL"
   name="MINIMAL"
   xmlns="http://www.w3.org/1999/xhtml">

   
  <!-- For samples and boilerplate see file ../../projects/xproc-doc/xproc-snippets.xml -->

   <!--<p:output port="schematron-messages" serialization="map{'indent' : true(), 'omit-xml-declaration': true() }"/>-->
   
  <p:load href="source/export/fm6_22.html"/>
   
   
   
  <!--<p:cast-content-type content-type="xml/application"/>-->
   
   <!--<p:store href="temp/in_html" message="saving input" serialization="map{'indent' : true(), 'omit-xml-declaration': true() }"/>-->
   
   
   <!-- The HTML coming in is poorly and incorrectly structured, with contents crammed into list items
     even across section boundaries
     In particular, Chapter 4 starts inside a list item within a purported list that spans across chapters.
   
   A filter deals with this by flattening all lists and marking where list bullets are presumed to appear. -->
   
   <p:xslt>
      <p:with-input port="stylesheet">
         <p:inline expand-text="false">
            <xsl:stylesheet version="3.0" xpath-default-namespace="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all">
               <xsl:mode on-no-match="shallow-copy"/>
               <xsl:template match="ul">
                  <xsl:apply-templates/>
               </xsl:template>
               <xsl:template match="li">
                  <bullet/>
                  <xsl:apply-templates/>
               </xsl:template>
            </xsl:stylesheet>
         </p:inline>
      </p:with-input>
   </p:xslt>
   
   <p:store href="temp/t01.html" message="Saving flattened input"  serialization="map{'indent' : true(), 'omit-xml-declaration': true() }"/>
   
   <!-- The path /*/body/p[normalize-space() => starts-with('Chapter')]
   shows that Chapters appear cleanly demarcated by body/p[matches(normalize-space(.),'Chapter \d')]
   so we will use these as our boundaries for pulling Chapter 4 only -->

   
   
   <!--<p:delete match="/*/body/*[/*/body/p[normalize-space()='Chapter 4'] >> .] |
      /*/body/*[. >> /*/body/p[normalize-space()='Chapter 5']] | /*/body/p[normalize-space()='Chapter 5']"/>-->
   
   <!-- Next we drop out everything but Chapter 4 - the above representing an effort to do this in
        XProc-alone - couldn't get it to work and bothersomely slow -->
   <p:xslt>
      <p:with-input port="stylesheet">
         <p:inline expand-text="false">
            <xsl:stylesheet version="3.0" xpath-default-namespace="http://www.w3.org/1999/xhtml" expand-text="true">
               <xsl:mode on-no-match="shallow-copy"/>
               <xsl:variable name="ch4_head" select="/*/body/p[normalize-space(.)='Chapter 4']"/>
               <xsl:variable name="ch5_head" select="/*/body/p[normalize-space(.)='Chapter 5']"/>
               <xsl:variable name="ch5" select="$ch5_head/(. | following-sibling::*)"/>
               <xsl:template match="body">
                  <xsl:copy>
                    <xsl:apply-templates select="$ch4_head/(. | following-sibling::*) except $ch5"/>
                  </xsl:copy>
               </xsl:template>
            </xsl:stylesheet>
         </p:inline>
      </p:with-input>
   </p:xslt>

   <p:store href="temp/t02.xml" message="Saving extracted chapter 4"  serialization="map{'indent' : true(), 'omit-xml-declaration': true() }"/>
   
   <!-- Now we have content we can restructure - see the XSLTs for the logic -->
   
   <p:xslt>
      <p:with-input port="stylesheet" href="src/fm22-6_structure.xsl"/>
   </p:xslt>
   
   <!-- Now with nested structures, although some collect multiple items (indicated by paragraph numbers) and tables (to be joined) -->
   <p:xslt>
      <p:with-input port="stylesheet" href="src/fm22-6_restructure.xsl"/>
   </p:xslt>
   
   <p:store href="temp/t03_structured.xml" message="Saving chapter 4 re/structured"  serialization="map{'indent' : true(), 'omit-xml-declaration': true() }"/>
   
   <p:xslt>
      <p:with-input port="stylesheet" href="src/fm22-6-html-to-sts.xsl"/>
   </p:xslt>
   
   <!-- This is valid STS, although not yet perfect -->
   <p:store href="temp/t04_sts-rough.xml" message="STS conversion - simple mapping"  serialization="map{'indent' : true(), 'omit-xml-declaration': true() }"/>
   
   
   <!-- enhancements -
          fix up initial sections (tables, boxes)
          pull out bulleted paragraphs into lists
          pull out paragraph numbering into labels?
          repair boxed-text in section 4.7
          cross-references? at least to tables (T|t)able\s+4\-\d\d?
          pull together table 5 and any other continued tables (e.g. 4-57, 4-58)
          remove 'legend' table footer
          boxed text starting with 'Employing Leadership Requirements Model Developmental 
Activities'

        convert to OSCAL
          Retain tables 1-5 as plain-old tables
          break numbered sections out into parts
          separate out a formal part for capabilities / indicators
          
-->
   <!-- Next convert into STS, then provide with enhancement / clean up / refactoring --> 

<!-- Analytic pass: for section, build a table containing cells with each of:
   strength_indicators (signs of strength)
   need_indicators (lapses / shortfalls)
   underlying_causes (shadow forms, negative projections or inversions)
   feedback
   study
   practice -->

   <!--
      Problems with HTML in include
        li mismanagement
        split tables
        flat structures / anomalous formatting
      
      structure nested sections via implicit headers on p/@class
      validate these against tables pulled from Table 4-4 and Table 4-5
        
      The plan is to start with the tables for each 
      These are the regularities we expect from these tables:
   We should see tables 4-6 through 4-80 in total (75 tables)
   tr 1 leads with "Strength Indicators" in td[1] and "Need Indicators" in td[2]
   tr 2 has two cells
   tr 3 spans two columns, reading "underlying causes"
   tr 4 / count(td) = 1
   tr 5 / td[1] reads 'Feedback'
   row 5 / td[2] reads 'Study'
   row 5 / td[3] reads 'Practice'
   each of tr[5] has count(td)=2-->
   
   <!--<p:validate-with-schematron assert-valid="true" name="table-check"
      message="Checking chapter 4 table integrity in data capture ...">
      <p:with-input port="schema" href="src/fm22-6_chapter4.sch"/>
   </p:validate-with-schematron>
   
   <p:identity name="schematron-messages">
      <p:with-input port="source" pipe="report@table-check"/>
   </p:identity>-->
   
</p:declare-step>