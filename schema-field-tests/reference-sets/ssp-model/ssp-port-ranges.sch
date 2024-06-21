<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
   
   <sch:ns prefix="o" uri="http://csrc.nist.gov/ns/oscal/1.0"/>
   
   <!--<xsl:variable name="original">
      <expect level="WARNING" id="port-range-start-and-end-not-specified" target="." test="exists(@start) and exists(@end)">
         <message>If a protocol is defined, it should include a start and end port range. To define a single port, the start and end should be the same value.</message>
      </expect>
      <expect level="WARNING" id="port-range-start-specified-with-no-end" target="." test="exists(@start) and not(exists(@end))">
         <message>A start port exists, but an end point does not. To define a single port, the start and end should be the same value.</message>
      </expect>
      <expect level="WARNING" id="port-range-end-specified-with-no-start" target="." test="not(exists(@start)) and exists(@end)">
         <message>An end point exists, but a start port does not. To define a single port, the start and end should be the same value.</message>
      </expect>
      <expect level="WARNING" id="port-range-end-date-is-before-start-date" target="." test="@start &lt;= @end">
         <message>The port range specified has an end port that is less than the start port.</message>
      </expect>
   </xsl:variable>-->
   
   <!--<sch:pattern id="as-given">      
      <sch:rule context="o:port-range">
         <sch:assert test="exists(@start) and exists(@end)" id="as-given-1">id port-range-start-and-end-not-specified</sch:assert>
         
         <sch:assert test="exists(@start)" id="as-given-2">id port-range-start-specified-with-no-end </sch:assert>
         
         
         <!-\-<sch:assert id="is-false" test="false()">Can't possibly be true</sch:assert>-\->
         <sch:assert test="not(exists(@start)) and exists(@end)" id="as-given-3">id port-range-end-specified-with-no-start </sch:assert>
         <sch:assert test="@start &lt;= @end" id="as-given-4">id port-range-end-date-is-before-start-date</sch:assert>
      </sch:rule>         
   </sch:pattern>-->
   
   <sch:pattern id="proposed">      
      <!-- Schema constrains to non-negative integer so we do not do that here. -->
      <sch:rule context="o:port-range">
         <sch:assert test="exists(@start)" id="proposed-2"
            >id port-range-has-start</sch:assert>
         <sch:assert test="exists(@end)" id="proposed-3">id port-range-has-end</sch:assert>
         <sch:assert test="not(@start > @end)" id="proposed-4">start appears after end</sch:assert>
         <!--<sch:assert test="not(@end > 65353)" id="proposed-4">start appears after end</sch:assert>-->
         
      </sch:rule>         
   </sch:pattern>
   
  <!-- <sch:pattern id="gg-port-range">
      <!-\- sanity check port-range -\->
      <sch:rule context="o:port-range">
         <!-\- Note that port-range attributes are not namespaced and thus do not require namespace qualification -\->
         <sch:assert id="port-range-start-exists" diagnostics="port-range-start-exists-diagnostic" role="fatal" test="exists(@start)" xml:lang="en"
            >A port-range must have a @start attribute.</sch:assert>
         <sch:assert id="port-range-end-exists" diagnostics="port-range-end-exists-diagnostic" role="fatal" test="exists(@end)" xml:lang="en">A
            port-range must have a @end attribute.</sch:assert>
         <sch:assert id="port-range-start-is-positive-integer" diagnostics="port-range-start-is-positive-integer-diagnostic" role="fatal"
            test="@start castable as xs:positiveInteger" xml:lang="en">port-range @start is a positive integer.</sch:assert>
         <sch:assert id="port-range-end-is-positive-integer" diagnostics="port-range-end-is-positive-integer-diagnostic" role="fatal"
            test="@end castable as xs:positiveInteger" xml:lang="en">port-range @end is a positive integer.</sch:assert>
         <sch:assert id="port-range-start-does-not-exceed-65535" diagnostics="port-range-start-does-not-exceed-65535-diagnostic" role="fatal"
            test="@start &lt;= 65535" xml:lang="en">port-range @start does not exceed 65535.</sch:assert>
         <sch:assert id="port-range-end-does-not-exceed-65535" diagnostics="port-range-start-does-not-exceed-65535-diagnostic" role="fatal"
            test="@end &lt;= 65535" xml:lang="en">port-range @end does not exceed 65535.</sch:assert>
         <sch:assert id="port-range-start-is-less-than-or-equal-to-port-range-end" role="error" test="@start le @end" xml:lang="en">port-range
            @start is less than or equal to @end.</sch:assert>
      </sch:rule>
   </sch:pattern>
   
   <sch:diagnostics>
      <!-\- Schematron diagnostic message prose should be a negation of the related assertion prose -\->
      <sch:diagnostic id="port-range-start-exists-diagnostic" xml:lang="en">port-range @start is absent.</sch:diagnostic>
      <sch:diagnostic id="port-range-end-exists-diagnostic" xml:lang="en">port-range @end is absent.</sch:diagnostic>
      <sch:diagnostic id="port-range-start-is-positive-integer-diagnostic" xml:lang="en">port-range @start «<sch:value-of select="@start" /> » is
         not a positive integer.</sch:diagnostic>
      <sch:diagnostic id="port-range-end-is-positive-integer-diagnostic" xml:lang="en">port-range @end «<sch:value-of select="@end" /> » is not a
         positive integer.</sch:diagnostic>
      <sch:diagnostic id="port-range-start-does-not-exceed-65535-diagnostic" xml:lang="en">port-range @start exceeds the maximum
         65535.</sch:diagnostic>
      <sch:diagnostic id="port-range-end-does-not-exceed-65535-diagnostic" xml:lang="en">port-range @end exceeds the maximum 65535.</sch:diagnostic>
      <sch:diagnostic id="port-range-start-is-less-than-or-equal-to-port-range-end-diagnostic" xml:lang="en">port-range start is not less than or
         equal to port-range end.</sch:diagnostic>
   </sch:diagnostics>
   -->
   
</sch:schema>