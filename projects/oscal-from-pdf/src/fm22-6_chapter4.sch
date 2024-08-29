<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
   xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
   
   
   <sch:pattern>
     <sch:rule context="sec">
        <sch:assert test="count(table) = 75">We expect to see 75 tables; only <sch:value-of select="count(table)"/> are here</sch:assert>
     </sch:rule>
   
   </sch:pattern>
   
</sch:schema>