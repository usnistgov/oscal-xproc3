<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
    
    <!-- Add cross-checks:
        
        warn for unreferenced ref-list/ref
        error if xref/string(.) does not correspond to its target label
        error if ref has no label
        
        -->
    <!-- Supplements RNG or any validator with xref/@rid link checker -->
    
    <!-- Requirements reflect both a need for 'tightness' and also downstream requirements e.g. PDF production   -->
    
    <sch:let name="anyID" value="descendant::*/@id"/>
    
    <sch:let name="okay-ref-types" value="('sec','bibr','table','app','fig','fn','list')"/>
    <!--https://niso-sts.org/TagLibrary/niso-sts-TL-1-1d1-html/attribute/ref-type.html-->
    
    <sch:let name="okay-list-types" value="('order','bullet','alpha-lower','alpha-upper','arabic','roman-lower','roman-upper','simple')"/>
    <!--https://niso-sts.org/TagLibrary/niso-sts-TL-1-1d1-html/attribute/list-type.html-->
    
    <!-- TODO: add cross-check on @ref-type corresponding to target element type  -->
    <sch:pattern>
        <sch:rule context="xref">
            <sch:let name="refs"    value="tokenize(@rid,'\s+')"/>
            <sch:let name="orphans" value="$refs[not(.=$anyID)]"/>
            <sch:assert test="empty($orphans)">Not finding target for <sch:value-of select="string-join($orphans,', ')"/> on xref '<sch:value-of select="."/>' inside <sch:value-of select="ancestor::*[@id]/@id => string-join('/')"/></sch:assert>
            <sch:assert test="exists(@ref-type)">Missing @ref-type</sch:assert>
            <sch:assert test="empty(@ref-type) or @ref-type=$okay-ref-types">Unrecognized xref/@ref-type '<sch:value-of select="@ref-type"/>'</sch:assert>
        </sch:rule>

        <sch:rule context="list">
            <sch:assert test="exists(@list-type)">Missing @list-type</sch:assert>
            <sch:assert test="empty(@list-type) or @list-type=$okay-list-types">Unrecognized list/@list-type '<sch:value-of select="@list-type"/>'</sch:assert>
        </sch:rule>
       
        <sch:rule context="title">
            <sch:assert test="matches(.,'\S')">Blank title</sch:assert>
        </sch:rule>
     </sch:pattern>

</sch:schema>