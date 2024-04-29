<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sqf="http://www.schematron-quickfix.com/validator/process">

   <!-- Purpose:: Schematron rule set for XProc 3 authors to provide write-time support for pesky rules
        including help with local rules -->

   <!-- *Not* for checking XProc correctness - to do that, run it -->

   <sch:ns prefix="p" uri="http://www.w3.org/ns/xproc"/>
   <sch:ns prefix="c" uri="http://www.w3.org/ns/xproc-step"/>
   <!--<sch:ns prefix="ox" uri="http://csrc.nist.gov/ns/oscal-xproc3"/>-->
   
   <sch:let name="filename" value="(/*/base-uri() => tokenize('/'))[last()]"/>
   <sch:let name="basename" value="replace($filename, '\..*$', '')"/>

   <!-- we could go through namespace ceremonials for the XProc step type name
        instead of just reading off @type -->
   <sch:let name="type-prefix" value="substring-before(/*/@type, ':')"/>
   <sch:let name="type-uri" value="/*/namespace-uri-for-prefix($type-prefix, .)"/>
   <!--<xsl:variable name="type-proxy" as="element()">
      <xsl:element name="{/*/@type}" namespace="{ $type-uri }"/>
   </xsl:variable>
   <sch:let name="nominal-type" value="local-name($type-proxy)"/>-->

   <!-- instead we trust the semantics of the language to ensure the
        namespace-ness of everything, and simply read it off -->
   <sch:let name="nominal-type" value="/*/@type/tokenize(., ':')[last()]"/>

   <sch:pattern>
      <sch:rule context="/*">
         <sch:assert test="$nominal-type = $basename" sqf:fix="sqf-repair-step-type">Unexpected declared type
               <sch:value-of select="$nominal-type"/> for the file named <sch:value-of select="$filename"/></sch:assert>
         <sch:assert test="$type-uri = 'http://csrc.nist.gov/ns/oscal-xproc3'" sqf:fix="sqf-repair-step-type">XProc step
            @type is not given in namespace 'http://csrc.nist.gov/ns/oscal-xproc3'</sch:assert>
         <!--<sch:report test="true()"><sch:value-of select="$type-proxy/local-name()"/> ... : <sch:value-of select="$type-uri"/></sch:report>-->
         <sch:assert test="@name = $basename" sqf:fix="sqf-repair-step-name">XProc step
            @name does not match the file name '<sch:value-of select="$filename"/>'</sch:assert>
      </sch:rule>
      <sch:rule context="processing-instruction()">
         <sch:report test="true()">Unexpected PI found.</sch:report>
      </sch:rule>

   </sch:pattern>

   <sch:pattern>
      <!-- Not matching elements with href that contain { or } -->
      <sch:rule context="*[matches(@href, '^[^\}\{]+$')]">
         <sch:assert test="resolve-uri(@href, base-uri(.)) => unparsed-text-available()">No document found at <sch:value-of
               select="@href"/></sch:assert>
      </sch:rule>
   </sch:pattern>

   <sqf:fixes>
      <sqf:fix id="sqf-repair-step-type">
         <sqf:description>
            <sqf:title>Assign the file base name '<sch:value-of select="$basename"/>' as the nominal type, in
               namespace 'http://csrc.nist.gov/ns/oscal-xproc3'</sqf:title>
         </sqf:description>
         <sqf:add match="/*" node-type="attribute" select="'ox:' || $basename" target="type"/>
         <sqf:add match="/*" node-type="attribute" select="'http://csrc.nist.gov/ns/oscal-xproc3'" target="xmlns:ox"/>
      </sqf:fix>
      <sqf:fix id="sqf-repair-step-name">
         <sqf:description>
            <sqf:title>Assign the file base name '<sch:value-of select="$basename"/>' as the step name</sqf:title>
         </sqf:description>
         <sqf:add match="/*" node-type="attribute" select="$basename" target="name"/>
      </sqf:fix>
   </sqf:fixes>
</sch:schema>
