<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
   
   <!-- Binding XHTML namespace to 'html' prefix -->
   <sch:ns prefix="html" uri="http://www.w3.org/1999/xhtml"/>
   
   <sch:pattern>
      <sch:rule context="html:html">
         <sch:assert sqf:fix="add-head" test="html:head">HTML requires a 'head'</sch:assert>
         <sqf:fix id="add-head">
            <sqf:description>
               <sqf:title>Add a stub head</sqf:title>
            </sqf:description>
            <sqf:add position="first-child">
               <head>
                  <title>Lesson: ...</title>
                  <meta charset="utf-8"/>
               </head>
            </sqf:add>
         </sqf:fix> </sch:rule>
      <sch:rule context="html:head"> 
         <sch:assert sqf:fix="add-meta" test="html:meta/@charset='utf-8'">Document character set should be marked UTF-8</sch:assert>
         <sqf:fix id="add-meta">
            <sqf:description>
               <sqf:title>Add a meta charset='utf-8'</sqf:title>
            </sqf:description>
            <sqf:add position="last-child">
               <meta charset="utf-8"/>
            </sqf:add>
         </sqf:fix>  
      </sch:rule>
      <sch:rule context="html:head/html:title">
         <sch:let name="nominal-title" value="/*/html:body/$header(.)"/>
         <sch:assert sqf:fix="retag-pagetitle" test=". = $nominal-title">Page title looks wrong: expecting '<sch:value-of select="$nominal-title"/>'</sch:assert>
         <sqf:fix id="retag-pagetitle">
            <sqf:description>
               <sqf:title>Make the title '<sch:value-of select="$nominal-title"/>'</sqf:title>
            </sqf:description>
            <sqf:replace target="html:title" node-type="element" select="$nominal-title/string(.)"/>
         </sqf:fix> 
      </sch:rule>
      <sch:rule context="html:body">
         <sch:let name="tracks" value="'observer','maker','learner'"/>
         <sch:assert sqf:fix="assign-track" test="@data-track=$tracks">Please assign this page to a track</sch:assert>
         <sqf:fix id="assign-track">
            <sqf:description>
               <sqf:title>Assign to Observer track</sqf:title>
            </sqf:description>
            <sqf:add node-type="attribute" select="'observer'" target="data-track"/>
         </sqf:fix>  
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="html:li/html:p">
         <sch:report test="true()">p cannot appear inside li - only single-line list items are supported</sch:report>
      </sch:rule>
      <sch:rule context="html:html | html:head | html:meta | html:title | html:body | html:section |
         html:p | html:ul | html:ol | html:li | html:pre | html:details | html:summary"/>
      <sch:rule context="html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6"/>
      <sch:rule context="html:b | html:i | html:code | html:a | html:q | html:em"/>
      <sch:rule context="html:table | html:thead | html:tbody | html:tr | html:th | html:td"/>
      <sch:rule context="html:body/html:img | html:section/html:img | html:div"/>
      <sch:rule context="*">
         <sch:report test="true()">Element <sch:name/> is not expected in this HTML profile.</sch:report>
      </sch:rule>
   </sch:pattern>
   
   <xsl:variable name="header" as="function(*)"  
      select="function($e as element()) as element()?
              { $e ! (html:h1, html:h2, html:h3, html:h4, html:h5, html:h6)[1] }"/>
   
   <sch:pattern id="errant-text">
      <sch:rule context="html:section | html:body">
         <sch:assert test="text()[matches(., '\S')] => empty()">Element <name/> has loose text contents.</sch:assert>
         <sch:assert test="exists(self::html:section) or child::html:section[$header(.)='Goals']">Body must have a "Goals" section</sch:assert>
         <sch:assert test="not($header(.)='Goals') or empty(preceding-sibling::html:section)">A (single) "Goals" section should come first</sch:assert>
         <sch:assert test="not($header(.)='Prerequisites') or empty(preceding-sibling::html:section[not($header(.)='Goals')])">A "Prerequisites" section can come only directly after "Goals"</sch:assert>
         <sch:assert test="not($header(.)='Resources') or empty(preceding-sibling::html:section[not($header(.)=('Goals','Prerequisites'))])">A "Resources" section can come after only "Goals" and "Prerequisites"</sch:assert>
         
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="html:section/* | html:body/*">
         <sch:assert test="exists(self::html:section|self::html:div) or empty(preceding-sibling::html:section)">Element not expected following a section</sch:assert>
         <sch:report test="preceding-sibling::node()[1]/self::text()[matches(.,'\S')] => exists()" role="warning">Look there ...</sch:report>
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="html:section">
         <sch:assert test="exists(parent::html:body|parent::html:section|parent::html:div)"><sch:name/> found out of place</sch:assert>
      </sch:rule>
      <sch:rule context="html:h1 | html:h2 | html:h3 | html:h4 | html:h5 | html:h6">
         <sch:let name="deep" value="count(ancestor::html:body | ancestor::html:section)"/>
         <sch:let name="fixup" value="'h' || $deep"/>
         <sch:assert sqf:fix="retag-header" test="number(replace(local-name(), '\D', '')) = $deep"><sch:name/> found out of place - try
               <sch:value-of select="$fixup"/></sch:assert>
         <sch:assert test="empty(parent::* except (parent::html:body|parent::html:section))">Not expecting to see <name/> here</sch:assert>
         
         <sqf:fix id="retag-header">
            <sqf:description>
               <sqf:title>Retag the section head as <sch:value-of select="$fixup"/></sqf:title>
            </sqf:description>
            <sqf:replace node-type="element" target="html:{$fixup}">
               <sqf:copy-of select="child::node()"/>
            </sqf:replace>
         </sqf:fix>  
      </sch:rule>
      
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="html:p">
         <sch:assert test="matches(.,'[!?\.:\)…]$')">Paragraph should be punctuated</sch:assert>
      </sch:rule>
      
      <sch:rule context="html:a">        
         <!--<sch:rule context="html:a[matches(@href,'^https?:')] | html:a[matches(@href,'/$')]"/>-->
         <sch:let name="internal" value="not(matches(@href,'^https?:/')) and matches(@href,'_src\.html$')"/>
         <sch:let name="excepting" value="matches(@href,'^https?:') or matches(@href,'/$')"/>
         <sch:assert test="$excepting or unparsed-text-available(resolve-uri(@href,base-uri(.)))">Not seeing anything at href <sch:value-of select="@href"/></sch:assert>
            
         <sch:assert test="not(matches(.,'\.\S{2,4}$')) or (replace(.,'^.*/','') = replace(@href,'^.*/',''))">Internal link is misdirected - href does not match element content</sch:assert>
         <sch:assert test="normalize-space(.) => boolean()">Anchor is missing link contents</sch:assert>
         <sch:assert sqf:fix="tag-lessonUnit-link" test="@class='LessonUnit' or not($internal)">Link to lesson should be given @class='LessonUnit'</sch:assert>
         <sqf:fix id="tag-lessonUnit-link">
            <sqf:description>
               <sqf:title>Tag the link with class='LessonUnit'</sqf:title>
            </sqf:description>
            <sqf:add node-type="attribute" select="'LessonUnit'" target="class"/>
         </sqf:fix>  
      </sch:rule>
   </sch:pattern>


</sch:schema>