<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
   xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
   
   
   <sch:pattern>
      <sch:rule context="p">
         <sch:let name="exception" value="matches(.,'[…:\?\.][”\)]?\s*$') or exists(ancestor::table-wrap )"/>
         <sch:assert test="child::*[1] is child::target[1] or $exception">Punctuation check.</sch:assert>
      </sch:rule>
      <sch:rule context="table-wrap">
         <sch:let name="table-label" value="label"/>
         <sch:let name="other-tables" value="//table-wrap except ."/>
         <sch:assert test="empty($other-tables[label=$table-label])">Table label '<sch:value-of select="label"/>' is not distinctive</sch:assert>
         
      </sch:rule>
      <sch:rule context="table-wrap[@custom-type=('competency','attribute')]/table/tbody">
         <sch:assert test="tr[1]/td[1]!normalize-space(.)='Strength Indicators'">table out of order (Strength Indicators label missing)</sch:assert>
         <sch:assert test="tr[1]/td[2]!normalize-space(.)='Need Indicators'">table out of order ('Need Indicators' label missing)</sch:assert>
         <sch:assert test="(tr[2]/td => count()) eq 2">table out of order</sch:assert>
         <sch:assert test="tr[3]/td[1]!normalize-space(.)='Underlying Causes'">table out of order ('Underlying Causes' label missing)</sch:assert>
         <sch:assert test="(tr[4]/td => count()) eq 1">table out of order</sch:assert>
         <sch:assert test="tr[5]/td[1]!normalize-space(.)='Feedback'">table out of order ('Feedback' label missing)</sch:assert>
         <sch:assert test="tr[6]/td[1]!normalize-space(.)='Study'">table out of order ('Study' label missing)</sch:assert>
         <sch:assert test="tr[7]/td[1]!normalize-space(.)='Practice'">table out of order ('Practice' label missing)</sch:assert>
      </sch:rule>
         <!--These are the regularities we expect from these tables:
      
      tr 1 leads with "Strength Indicators" in td[1] and "Need Indicators" in td[2]
      tr 2 has two cells
      tr 3 spans two columns, reading "underlying causes"
      tr 4 / count(td) = 1
      tr 5 / td[1] reads 'Feedback'
      row 5 / td[2] reads 'Study'
      row 5 / td[3] reads 'Practice'
      each of tr[5] has count(td)=2
      -->
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="body/p | sec/p">
         <sch:let name="exception" value="starts-with(.,'Tip:')"/>
         <sch:assert test="child::*[1] is child::target[1] or $exception">We expect p element to start with a target.</sch:assert>
      </sch:rule>
      
   </sch:pattern>
   
</sch:schema>