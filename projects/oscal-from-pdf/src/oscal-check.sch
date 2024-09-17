<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:o="http://csrc.nist.gov/ns/oscal/1.0">
    
    <sch:ns prefix="o"     uri="http://csrc.nist.gov/ns/oscal/1.0"/>
    <sch:ns prefix="oscal" uri="http://csrc.nist.gov/ns/oscal/1.0"/>
    
    <xsl:key name="xref" match="*[exists(@id)]" use="'#' || @id"/>
   
   <sch:pattern>
      <sch:rule context="*">
        <sch:assert test="empty(@id) or (count(key('xref',@id/('#' || .) )) = 1)">ID clash</sch:assert>
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <sch:rule context="oscal:a[starts-with(@href,'#')]">
         
         <sch:assert test="key('xref',@href) => exists()">Internal link href='<sch:value-of select="@href"/>' has no target</sch:assert>
      </sch:rule>
   </sch:pattern>
   
</sch:schema>