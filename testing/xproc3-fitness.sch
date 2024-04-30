<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:sqf="http://www.schematron-quickfix.com/validator/process">

   <!-- Purpose:: Schematron rule set for XProc 3 authors to provide write-time support for pesky rules
        including help with local rules -->

   <!-- *Not* for checking XProc correctness - to do that, run it -->



   <sch:ns prefix="ox" uri="http://csrc.nist.gov/ns/oscal-xproc3"/>
   <sch:ns prefix="p" uri="http://www.w3.org/ns/xproc"/>
   <sch:ns prefix="c" uri="http://www.w3.org/ns/xproc-step"/>
   <!--<sch:ns prefix="ox" uri="http://csrc.nist.gov/ns/oscal-xproc3"/>-->
   
   <sch:let name="filename" value="(/*/base-uri() => tokenize('/'))[last()]"/>
   <sch:let name="basename" value="replace($filename, '\..*$', '')"/>
   <sch:let name="tag" value="'[' || $basename || ']'"/>
   
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
   
   <xsl:variable name="ox:leads-with-variable-reference" as="function(*)"  
      xmlns:xs="http://www.w3.org/2001/XMLSchema"
      select="function($v as item()) as xs:boolean { string($v) => matches('^\s*\{\s*\$\i\c*\s*\}') }"/>
   
   <sch:pattern>
      <sch:rule context="/*">
         <sch:assert sqf:fix="sqf-make30" test="@version = '3.0'">Expecting XProc 3.0, not <sch:value-of select="@version"/></sch:assert>
         <sch:assert sqf:fix="sqf-repair-step-type" test="$nominal-type = $basename">Unexpected declared type <sch:value-of select="$nominal-type"/> for the file named <sch:value-of select="$filename"/></sch:assert>
         <sch:assert test="$type-uri = 'http://csrc.nist.gov/ns/oscal-xproc3'" sqf:fix="sqf-repair-step-type">XProc step @type is not given in namespace 'http://csrc.nist.gov/ns/oscal-xproc3'</sch:assert>
         <sch:assert test="@name = $basename" sqf:fix="sqf-repair-step-name">XProc step @name does not match the file name '<sch:value-of select="$filename"/>'</sch:assert>
      </sch:rule>
      
      <sch:rule context="processing-instruction()">
         <sch:report test="true()">Unexpected PI found.</sch:report>
      </sch:rule>

      <sch:rule context="*[exists(@message)]">
         <sch:assert test="starts-with(@message,$tag) or $ox:leads-with-variable-reference(@message)" sqf:fix="sqf-prepend-message-tag">Message should start with tag <sch:value-of select="$tag"/></sch:assert>
         <sqf:fix id="sqf-prepend-message-tag">
            <sqf:description>
               <sqf:title>Prepend the message with '<sch:value-of select="$tag"/>'</sqf:title>
            </sqf:description>
            <sqf:add node-type="attribute" select="$tag || ' ' || @message" target="message"/>
         </sqf:fix>         
      </sch:rule>    
   </sch:pattern>

   <sch:pattern>
     <sch:rule context="p:load | p:store">
        <sch:assert test="matches(@message,'\S')" role="warning" sqf:fix="sqf-add-message">XProc <sch:name/> should emit a message</sch:assert>
        <sqf:fix id="sqf-add-message">
           <sqf:description>
              <sqf:title>Add a message</sqf:title>
           </sqf:description>
           <sqf:add node-type="attribute" select="$tag || ' ' || name() || ': ' || @href || ' ...'" target="message"/>
        </sqf:fix>         
     </sch:rule>
   </sch:pattern>
   
   <sch:pattern>
      <!-- Not matching elements with href that contain { or } -->
      <sch:rule context="*[matches(@href, '^[^\}\{]+$')]">
         <sch:assert test="resolve-uri(@href, base-uri(.)) => unparsed-text-available()">No resource found at <sch:value-of
            select="@href"/></sch:assert>
      </sch:rule>
   </sch:pattern>
   
   <sqf:fixes>
      <sqf:fix id="sqf-make30">
         <sqf:description>
            <sqf:title>Assign version 3.0</sqf:title>
         </sqf:description>
         <sqf:add node-type="attribute" select="'3.0'" target="version"/>
      </sqf:fix>
      
      <sqf:fix id="sqf-repair-step-type">
         <sqf:description>
            <sqf:title>Assign the file base name '<sch:value-of select="$basename"/>' as the nominal type, in namespace 'http://csrc.nist.gov/ns/oscal-xproc3'</sqf:title>
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
