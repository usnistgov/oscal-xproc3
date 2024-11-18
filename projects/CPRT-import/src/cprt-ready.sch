<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
   xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
   
   <sch:ns prefix="cprt" uri="http://csrc.nist.gov/ns/cprt"/>
   
   <!--- Schematron checks:

 x select_from is the only element or text node child of its parent

assigment | selection nodes all link to odps

@ids are nested properly

No [Assign or [Select substrings remain


   -->
   
   <sch:pattern id="tidyness-checking">
      <sch:rule context="cprt:select_from">
         <sch:assert test="empty(../* except .)">Expecting <sch:name/> here to be a singleton.</sch:assert>
      </sch:rule>
      <sch:rule context="cprt:text | cprt:title | cprt:external_reference | cprt:a | cprt:assignment | cprt:selection | cprt:odp-ref | cprt:choice | cprt:incorporated_into">
         <sch:report test="matches(.,'\[Assign','i')">Parameter assignment appears in plain text.</sch:report>
         <sch:report test="matches(.,'\[Select','i')">Parameter value selection appears in plain text.</sch:report>
      </sch:rule>
      <sch:rule context="*">
            <sch:report test="exists(text()[normalize-space(.)])">Text appears unexpectedly in <sch:name/>.</sch:report>
      </sch:rule>      
   </sch:pattern>
   
   <sch:pattern id="link-checking">
      <sch:rule context="cprt:assignment">
         <sch:let name="rid" value="@odp-ref-id"/>
         <sch:let name="odp" value="ancestor::cprt:requirement//cprt:odp[@id = $rid]"/>
         <sch:assert test="exists($odp)">Not finding an ODP for <sch:name/>.</sch:assert>
         <sch:assert test="string(.) = $odp/cprt:odp_statement/cprt:text">Assignment text looks wrong.</sch:assert>
      </sch:rule>
      <sch:rule context="cprt:selection">
         <sch:let name="rid" value="@odp-ref-id"/>
         <sch:let name="odp" value="ancestor::cprt:requirement//cprt:odp[@id = $rid]"/>
         <sch:assert test="exists($odp)">Not finding an ODP for <sch:name/>.</sch:assert>
         <sch:assert test="$odp/cprt:odp_type/@id='multi_select' or not(@how-many='one-or-more')">Selection link looks wrong.</sch:assert>
      </sch:rule>
      <sch:rule context="cprt:odp-ref[.='SELECTED PARAMETER VALUES']">
         <sch:let name="rid" value="@ref-id"/>
         <sch:let name="odp" value="ancestor::cprt:requirement//cprt:odp[@id = $rid]"/>
         <sch:assert test="exists($odp)">Not finding an ODP for <sch:name/>.</sch:assert>
         <sch:assert test="$odp/cprt:odp_type/@id='multi_select'">Selection link looks wrong.</sch:assert>
      </sch:rule>
      <sch:rule context="cprt:odp-ref">
         <sch:let name="rid" value="@ref-id"/>
         <sch:let name="odp" value="ancestor::cprt:requirement//cprt:odp[@id = $rid]"/>
         <sch:assert test="exists($odp)">Not finding an ODP for <sch:name/>.</sch:assert>
         <sch:assert test="(string(.) = $odp/cprt:title) or contains($odp/cprt:text,string())">Assignment text looks wrong.</sch:assert>        
      </sch:rule>
   </sch:pattern>

   <sch:pattern id="id-checking">
      <sch:rule context="cprt:reference"/>
      <sch:rule context="cprt:odp_type">
         <sch:assert test="@id = ('single_entry','multi_select')">ID '<sch:value-of select="@id"/>' is not recognized here.</sch:assert>
      </sch:rule>
      
      <sch:rule context="cprt:odp_statement">
         <sch:let name="adj-id" value="substring-after(@id,('OS-a.')) => substring-before('.odp')"/>
         <sch:let name="control-id" value="substring-after(ancestor::cprt:requirement/@id,('DS-A.'))"/>
         <sch:assert test="starts-with($adj-id, $control-id)">ID appears out of order.</sch:assert>
      </sch:rule>
      <sch:rule context="cprt:odp">
         <sch:let name="adj-id" value="substring-after(@id,('A.')) => substring-before('.ODP')"/>
         <sch:let name="control-id" value="substring-after(ancestor::cprt:requirement/@id,('DS-A.'))"/>
         <sch:assert test="starts-with($adj-id, $control-id)">ID appears out of order.</sch:assert>
      </sch:rule>
      <sch:rule context="cprt:security_requirement/cprt:security_requirement">
         <sch:let name="adj-id" value="substring-after(@id,('SR-'))"/>
         <sch:let name="parent-adj-id" value="substring-after(parent::*/@id,('SR-'))"/>
         <sch:assert test="starts-with($adj-id, $parent-adj-id)">ID appears out of order.</sch:assert>
      </sch:rule>
      <sch:rule context="cprt:security_requirement">
         <sch:let name="adj-id" value="substring-after(@id,('SR-'))"/>
         <sch:assert test="starts-with($adj-id, parent::*/@id)">ID appears out of order.</sch:assert>
      </sch:rule>
      <sch:rule context="cprt:withdraw_reason">
         <sch:let name="adj-id" value="substring-after(@id,('WR-'))"/>
         <sch:assert test="starts-with($adj-id, parent::*/@id)">ID appears out of order.</sch:assert>
      </sch:rule>
      <sch:rule context="cprt:determination">
         <sch:let name="adj-id" value="substring-after(@id,('DS-A.'))"/>
         <sch:let name="parent-adj-id" value="substring-after(parent::*/@id,('SR-'))"/>
         <sch:assert test="starts-with($adj-id, $parent-adj-id)">ID appears out of order.</sch:assert>
      </sch:rule>
      <sch:rule context="cprt:discussion | cprt:examine | cprt:interview | cprt:test">
         <sch:let name="initial" value="local-name() => substring(1,1) => upper-case()"/>
         <sch:let name="adj-id" value="substring-after(@id,($initial || '-'))"/>
         <sch:assert test="starts-with($adj-id, parent::*/@id)">ID appears out of order.</sch:assert>
      </sch:rule>
      <sch:rule context="*[exists(@id)]">
         <sch:assert test="starts-with(@id, parent::*/@id)">ID appears out of order.</sch:assert>
      </sch:rule>
   </sch:pattern>
   
   <sch:pattern id="id-distinctiveness">
      <sch:rule context="cprt:reference | cprt:odp_type"/>
      <sch:rule context="*[exists(@id)]">
         <sch:let name="me" value="."/>
         <sch:assert test="count(//*[@id = $me/@id]) eq 1">Overloaded ID, please check.</sch:assert>
      </sch:rule>
   </sch:pattern>
   
</sch:schema>