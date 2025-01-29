<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
   xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
   
   <sch:ns prefix="cprt" uri="http://csrc.nist.gov/ns/cprt"/>
   
   <!--- Schematron checks:
   
   every @id is distinct
   every @id is linked (.=//projection/dest) except white-listed exceptions
   no fields are blank
   
   -->
   
   <sch:pattern>
      <sch:rule context="*[@id]">
         <sch:let name="id" value="@id"/>
         <sch:assert test="count(//*[@id=$id]) = 1">@id <sch:value-of select="@id"/> is not distinct</sch:assert>
         <sch:let name="exception" value="exists(self::cprt:document | self::cprt:relationship_type | self::cprt:family) or @id='single_select'"/>
         <sch:assert test="$exception or exists(//cprt:projection[cprt:dest=$id])">Nothing links to @id <sch:value-of select="@id"/> - it will be orphaned</sch:assert>
      </sch:rule>
      <sch:rule context="text | title | source | dest">
         <sch:assert test="boolean(normalize-space())"><name/> has no content</sch:assert>
      </sch:rule>
   </sch:pattern>
   
</sch:schema>