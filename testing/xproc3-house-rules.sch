<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:sqf="http://www.schematron-quickfix.com/validator/process">

   <!-- Purpose:: Schematron rule set for XProc 3 authors to provide write-time support for pesky rules
        including help with local rules -->

   <!-- *Not* for checking XProc correctness - to do that, run it -->

<!-- Don't rely on comments that are likely to go out of date. Rely instead on code.
   
   
     Among the house rules tested here:
     
     There must be a namespace 'http://csrc.nist.gov/ns/oscal-xproc3' prefixed 'ox'
     
     The name of the step, /*/@name, matches the base name of the file.
     The type of the step, /*/@type also matches the base name except is prefixed 'ox' for the repo namespace.
     The stated XProc version must be 3.0
   
     No PIs are permitted.

     @message
       Should be prepended with the step name, in brackets e.g. message="[STEP-NAME] message ..."
       A variable may be also used to start the message, which offers a workaround.
       Should appear on any p:load or p:store step (others tbd)
     
     Resources
       the Schematron looks for resources at the end of @href (with no variable callouts), reporting failures
   -->

   <sch:ns prefix="ox" uri="http://csrc.nist.gov/ns/oscal-xproc3"/>
   <sch:ns prefix="p" uri="http://www.w3.org/ns/xproc"/>
   <sch:ns prefix="c" uri="http://www.w3.org/ns/xproc-step"/>
   <sch:ns prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform"/>
   
   <sch:let name="filename" value="(/*/base-uri() => tokenize('/'))[last()]"/>
   <sch:let name="basename" value="replace($filename, '\..*$', '')"/>
   <sch:let name="tag" value="'[' || $basename || ']'"/>
   
   <sch:let name="type-prefix" value="substring-before(/*/@type, ':')"/>
   <sch:let name="type-uri" value="/*/namespace-uri-for-prefix($type-prefix, .)"/>

   <sch:let name="typename-given" value="/*/@type/tokenize(., ':')[last()]"/>
   
   <!--<xsl:variable name="ox:leads-with-variable-reference" as="function(*)"  
      xmlns:xs="http://www.w3.org/2001/XMLSchema"
      select="function($v as item()) as xs:boolean { string($v) => matches('^\s*\{\s*\$\i\c*\s*\}') }"/>-->
   
   <xsl:function name="ox:leads-with-variable-reference" as="xs:boolean">
      <xsl:param name="v" as="item()"/>
      <xsl:sequence select="string($v) => matches('^\s*\{\s*\$\i\c*\s*\}')"/>
   </xsl:function>
   
<!-- Rules being enforced:

      The XProc is version 3.0
      The assigned type /*/@type should match the file name, in the http://csrc.nist.gov/ns/oscal-xproc3 namespace (prefix 'ox')
      The name /*/@name should also match the file name
      
      No PIs appear anywhere
      
      Messages are tagged - leading with either a literal [STEP-NAME], or a variable reference
      
      p:load and p:store events provide messages
      
      Anything referenced with href resolves
        - to turn this off for the pipeline, list the XProc by name among processes named in $unlinked-xprod 

   -->
   <sch:pattern>
      <sch:rule context="/*">
         <sch:let name="unexpected-prefixes" value="in-scope-prefixes(.)[not(.=('p','c','ox','xml'))]"/>
         <sch:report test="$unexpected-prefixes => exists()">We want to see only 'p', 'c' and 'ox' namespace prefixes assigned at the top of an XProc (so far, for this repository): this file has <xsl:value-of select="$unexpected-prefixes" separator=", "/></sch:report>
         <sch:assert sqf:fix="sqf-make-version-3"   test="@version = '3.0'">Expecting XProc 3.0, not <sch:value-of select="@version"/></sch:assert>
         <sch:assert sqf:fix="sqf-repair-step-type" test="$typename-given = $basename">Unexpected declared type <sch:value-of select="$typename-given"/> for the file named <sch:value-of select="$filename"/></sch:assert>
         <sch:assert sqf:fix="sqf-repair-step-type" test="$type-uri = 'http://csrc.nist.gov/ns/oscal-xproc3'">XProc step @type is not given in namespace 'http://csrc.nist.gov/ns/oscal-xproc3'</sch:assert>
         <sch:assert sqf:fix="sqf-repair-step-name" test="@name = $basename">XProc step @name does not match the file name '<sch:value-of select="$filename"/>'</sch:assert>
      </sch:rule>
      
      <sch:rule context="processing-instruction()">
         <sch:report test="true()">Unexpected PI found.</sch:report>
      </sch:rule>

      <sch:rule context="*[exists(@message)]">
         <sch:assert sqf:fix="sqf-prepend-message-tag"
            test="starts-with(@message,$tag) or ox:leads-with-variable-reference(@message)">Message should start with tag <sch:value-of select="$tag"/></sch:assert>
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
        <sch:assert sqf:fix="sqf-add-message" test="matches(@message,'\S')" role="warning">XProc <sch:name/> should emit a message</sch:assert>
        <sqf:fix id="sqf-add-message">
           <sqf:description>
              <sqf:title>Add a message</sqf:title>
           </sqf:description>
           <sqf:add node-type="attribute" select="$tag || ' ' || name() || ': ' || @href || ' ...'" target="message"/>
        </sqf:fix>         
     </sch:rule>
   </sch:pattern>
   
   <!-- Any files to be reprieved from linking rules should be listed here, by /*/@name  -->
   <sch:let name="unlinked-xproc" value="('CONVERT-XML-REFERENCE-SET')"/>
   
   <sch:pattern>
      <!-- Not matching elements with href that contain { or } -->
      <sch:rule context="*[matches(@href, '^[^\}\{]+$')]">
         <sch:let name="exception" value="/*/@name = $unlinked-xproc"/>
         <sch:assert test="$exception or resolve-uri(@href, base-uri(.)) => unparsed-text-available()">No resource found at <sch:value-of
            select="@href"/></sch:assert>
      </sch:rule>
   </sch:pattern>
   
   <sqf:fixes>
      <sqf:fix id="sqf-make-version-3">
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
