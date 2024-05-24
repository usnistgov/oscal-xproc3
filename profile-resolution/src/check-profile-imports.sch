<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
   
   <sch:ns prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform"/>
   <sch:ns prefix="o"   uri="http://csrc.nist.gov/ns/oscal/1.0"/>
   <sch:ns prefix="ox"  uri="http://csrc.nist.gov/ns/oscal-xproc3"/>
   
   <xsl:import href="trace-profile-imports.xsl"/>
   
   <sch:pattern>
      <sch:rule context="/o:profile">
         <sch:assert test="ox:imports-okay(.)">Profile imports are out of order: use XSLT trace-profile-imports.xsl for a diagnostic.</sch:assert>
      </sch:rule>
   </sch:pattern>
   
</sch:schema>