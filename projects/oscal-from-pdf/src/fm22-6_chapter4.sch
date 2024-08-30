<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
   xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
   
   
   <sch:pattern>
     <sch:rule context="body/p | sec/p">
        <sch:assert test="child::*[1] is child::target[1]">We expect p element to start with a target.</sch:assert>
     </sch:rule>
   
   </sch:pattern>
   
</sch:schema>