<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    expand-text="true" version="3.0">

<!-- For enhancement and correction of the NISO STS derived from upstream OSCAL / CSRC SP 800-53
     Not suitable for generic use as it provides for restructuring according to the needs of that data set.
    -->
    
    <xsl:mode on-no-match="shallow-copy"/>
    
   <!-- Key definition permits retrieving elements by means of their ID values. -->
    <xsl:key name="by-id" match="*[@id]" use="@id"/>
    
    <!-- text in here is trimmed, since source has extra whitespace (for whatever reason) -->
    <xsl:template match="std-ident//text()">
        <xsl:value-of select="normalize-space()"/>
    </xsl:template>


    <xsl:variable name="canonical-reflists" select="document('../csrc-merge/data/unified-bibliography-STS.xml')"/>
    
    <!--<xsl:variable name="all-bibrefs" select="//xref/key('by-id',@rid)/self::ref"/>-->
    
    <xsl:variable name="sts-in" select="/"/>
    
    <xsl:template match="back">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="* except ref-list"/>
            <ref-list>
                <title>References</title>
                <!-- pulling in all the references in the new canonical list plus all references from that list that are cross-referenced
                     (whether new or old), thereby ensuring that canonical versions of all references used appear along with all new references. -->
                
                <xsl:apply-templates select="$canonical-reflists/*/back/ref-list[@originator='5.2_update']/ref |
                    //xref[ empty(
                        key('old-references-map', @rid, $mapping-table)[exists(key('by-id',@NEW-ID,$sts-in))] ) ]
                      /key('by-id',@rid,$canonical-reflists)">
                    <xsl:sort select="label"/>
                </xsl:apply-templates>            
            </ref-list>
            <!--<xsl:copy-of select="$mapping-table"/>-->
        </xsl:copy>
    </xsl:template>

    <!-- should never match, see above -->
    <xsl:template match="back/ref-list">
        <xsl:message>matching ref-list { path(.) } ... </xsl:message>
    </xsl:template>
    
    <!-- within the body, sections inside the main section are promoted to their correct position
         this does not disturb order as long as there is only a single body/sec -->
    <xsl:template match="body">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
            <xsl:apply-templates select="child::sec/child::sec"/>
            
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="body/sec">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <!-- sec children of the body/sec are promoted into body -->
            <xsl:apply-templates select="* except sec"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- eXtyles tags a table width, not entirely useful - we could keep or modify -->
    <xsl:template match="table/@width"/>
    
    <!-- For table rows that come through without data (editors having left them as placeholders) --> 
    <xsl:template match="table//tr[not(matches(.,'\S'))]"/>
    
    <!-- knowing the IDs of the families will be useful when it comes to tagging them -->
    <xsl:variable name="family-ids" select="//sec[@sec-type='family']/@id"/>
    
    <!--we have a table whose first column lists the families by code - this provides
    the content with links here -->
    <xsl:template match="tr/td[1]//text()[lower-case(.) = $family-ids]">
        <xref rid="{lower-case(.)}" ref-type="sec">
            <xsl:value-of select="."/>
        </xref>
    </xsl:template>
    
    <!-- Detour to set up stuff for mapping references to old bibls over to new bibls -->
    
    <xsl:variable name="mapping-table">
        <xsl:apply-templates mode="produce-ref-map" select="document('reference-mapping-table.xml')/html/body/table"/>
    </xsl:variable>
    
    <xsl:template mode="produce-ref-map" match="table">
        <reference-map>
            <xsl:apply-templates select="tbody/tr" mode="#current"/>
        </reference-map>
    </xsl:template>
    
    <xsl:template mode="produce-ref-map" match="tr" expand-text="true">
        <entry OSCAL-ID="{ td[2] }" NEW-ID="{ td[3] }">
            <oldform>{ td[1] }</oldform>
            <newform>{ td[4] }</newform>
            <xsl:apply-templates select="tr" mode="#current"/>
        </entry>
    </xsl:template>
    
    <!-- Replacing the untitled section wrapper in the metadata with a 'disclaimer' notes -->
    <xsl:template match="front/sec[title[not(matches(.,'\S'))]]" expand-text="true">
        <notes notes-type="disclaimer">
            <xsl:apply-templates select="* except title"/>
        </notes>
    </xsl:template>
    
    <!-- eXtyles gives untitled sec elements (with dummy titles) within app elements, which this
         removes. --> 
    <xsl:template match="app/sec[title[not(matches(.,'\S'))]]" expand-text="true">
        <xsl:apply-templates select="* except title"/>
    </xsl:template>

    <!-- extra whitespace cleanup inside p elements -->
    <xsl:template match="p//text()[not(matches(.,'\S'))][empty(preceding-sibling::*) or empty(following-sibling::*)]"/>
    
    <xsl:key name="old-references-map" match="reference-map/entry" use="@OSCAL-ID"/>
    
    
    <!-- Okay now we get to it ... -->
    <!-- In aggregation we sometimes get a few 'loose' cross-references for example
    linking to contents not included in this pub. On the assumption these have
    been resolved where possible, this template removes them. -->
    <!--<xsl:template match="xref[empty(key('by-id',@rid))]">
        <xsl:message expand-text="true">Dropping xref[@rid='{ @rid }']</xsl:message>
        <xsl:apply-templates/>
    </xsl:template>-->
    
    <xsl:template match="xref[exists(key('old-references-map', @rid, $mapping-table))]">
        <xsl:variable name="map-entry" select="key('old-references-map', @rid, $mapping-table)"/>
        <xsl:choose>
            <!-- rewriting link only if the target can actually be found -->
            <xsl:when test="$map-entry/@NEW-ID = //@id">
                <xref>
                    <xsl:copy-of select="@*"/>
                    <xsl:attribute name="rid" select="$map-entry/@NEW-ID"/>
                    <xsl:value-of select="$map-entry/newform"/>
                </xref>
                <!--<xsl:message>Link to { @rid } now to { $map-entry/@NEW-ID} ...</xsl:message>-->
            </xsl:when>
            <xsl:otherwise>
                <xsl:next-match/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="xref[@rid='cm-7_obj.a']">
        <xsl:message>rewriting link to CM-07a (assessment objective) to CM-7a (statement line item)</xsl:message>
        <xref rid="cp-7_smt.a" ref-type="sec">CM-7a</xref>            
    </xsl:template>
    
    <xsl:template priority="0.4" match="xref[exists(key('by-id',@rid)/self::ref)][matches(.,'\s')] | ref/label[matches(.,'\s')]">
        <xsl:variable name="n" select="replace(string(.), '\s+', '')"/>
        <!--<xsl:message expand-text="true">rewriting { local-name() } '{ string(.) } ' as '{ $n }'</xsl:message>-->
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:value-of select="$n"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Rewriting this reference to be picked up in next phase and linked -->
    <xsl:template match="underline[.='NIST SP 800-53B']">
        <xsl:text>NIST </xsl:text>
        <underline>SP800-53B</underline>
    </xsl:template>
    
    <xsl:template match="underline[.='HSPD-7']">
        <underline>HSPD7</underline>
    </xsl:template>
    
    <xsl:template match="underline[.=' to “2022']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="underline[.='”']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- shows an example of what the dynamically produced mapping table should look like -->
    <xsl:variable name="LIKEME" as="element()">
        <reference-map>
            <entry OSCAL-ID="resource-6_91f" NEW-ID="ref_1">
                <oldform>32 CFR 2002</oldform>
                <newform>32CFR2002</newform>
            </entry>
            <entry OSCAL-ID="resource-7_0f9" NEW-ID="ref_2">
                <oldform>41 CFR 201</oldform>
                <newform>41CFR201</newform>
            </entry>
            <entry OSCAL-ID="resource-8_a5e" NEW-ID="ref_3">
                <oldform>5 CFR 731</oldform>
                <newform>5CFR731</newform>
            </entry>
            <entry OSCAL-ID="resource-9_94c" NEW-ID="ref_5">
                <oldform>CMPPA</oldform>
                <newform>CMPPA</newform>
            </entry>
            <entry OSCAL-ID="resource-10_031" NEW-ID="ref_6">
                <oldform>CNSSD 505</oldform>
                <newform>CNSSD505</newform>
            </entry>
            <entry OSCAL-ID="resource-11_4e4" NEW-ID="ref_7">
                <oldform>CNSSI 1253</oldform>
                <newform>CNSSI1253</newform>
            </entry>
            <entry OSCAL-ID="resource-12_b99" NEW-ID="ref_10">
                <oldform>DHS NIPP</oldform>
                <newform>DHS-NIPP</newform>
            </entry>
            <entry OSCAL-ID="resource-13_4f4" NEW-ID="ref_11">
                <oldform>DHS TIC</oldform>
                <newform>DHS-TIC</newform>
            </entry>
            <entry OSCAL-ID="resource-14_aa6" NEW-ID="ref_12">
                <oldform>DOD STIG</oldform>
                <newform>DOD-STIG</newform>
            </entry>
            <entry OSCAL-ID="resource-15_7b0" NEW-ID="ref_15">
                <oldform>EGOV</oldform>
                <newform>EGOV</newform>
            </entry>
            <entry OSCAL-ID="resource-16_55b" NEW-ID="ref_16">
                <oldform>EO 13526</oldform>
                <newform>EO13526</newform>
            </entry>
            <entry OSCAL-ID="resource-17_34a" NEW-ID="ref_17">
                <oldform>EO 13556</oldform>
                <newform>EO13556</newform>
            </entry>
            <entry OSCAL-ID="resource-18_0af" NEW-ID="ref_18">
                <oldform>EO 13587</oldform>
                <newform>EO13587</newform>
            </entry>
            <entry OSCAL-ID="resource-19_340" NEW-ID="ref_19">
                <oldform>EO 13636</oldform>
                <newform>EO13636</newform>
            </entry>
            <entry OSCAL-ID="resource-20_21c" NEW-ID="ref_21">
                <oldform>EO 13873</oldform>
                <newform>EO13873</newform>
            </entry>
            <entry OSCAL-ID="resource-22_4ff" NEW-ID="ref_22">
                <oldform>FASC18</oldform>
                <newform>FASC18</newform>
            </entry>
            <entry OSCAL-ID="resource-23_a15" NEW-ID="ref_23">
                <oldform>FED PKI</oldform>
                <newform>FED-PKI</newform>
            </entry>
            <entry OSCAL-ID="resource-24_678" NEW-ID="ref_24">
                <oldform>FIPS 140-3</oldform>
                <newform>FIPS140-3</newform>
            </entry>
            <entry OSCAL-ID="resource-25_eea" NEW-ID="ref_25">
                <oldform>FIPS 180-4</oldform>
                <newform>FIPS180-4</newform>
            </entry>
            <entry OSCAL-ID="resource-26_7c3" NEW-ID="ref_26">
                <oldform>FIPS 186-4</oldform>
                <newform>FIPS186-4</newform>
            </entry>
            <entry OSCAL-ID="resource-27_736" NEW-ID="ref_27">
                <oldform>FIPS 197</oldform>
                <newform>FIPS197</newform>
            </entry>
            <entry OSCAL-ID="resource-28_628" NEW-ID="ref_28">
                <oldform>FIPS 199</oldform>
                <newform>FIPS199</newform>
            </entry>
            <entry OSCAL-ID="resource-29_599" NEW-ID="ref_29">
                <oldform>FIPS 200</oldform>
                <newform>FIPS200</newform>
            </entry>
            <entry OSCAL-ID="resource-31_a29" NEW-ID="ref_31">
                <oldform>FIPS 202</oldform>
                <newform>FIPS202</newform>
            </entry>
            <entry OSCAL-ID="resource-32_0c6" NEW-ID="ref_32">
                <oldform>FISMA</oldform>
                <newform>FISMA</newform>
            </entry>
            <entry OSCAL-ID="resource-33_488" NEW-ID="ref_35">
                <oldform>HSPD 7</oldform>
                <newform>HSPD7</newform>
            </entry>
            <entry OSCAL-ID="resource-34_e4d" NEW-ID="ref_37">
                <oldform>IETF 5905</oldform>
                <newform>IETF5905</newform>
            </entry>
            <entry OSCAL-ID="resource-35_15d" NEW-ID="ref_38">
                <oldform>IR 7539</oldform>
                <newform>IR7539</newform>
            </entry>
            <entry OSCAL-ID="resource-36_2be" NEW-ID="ref_39">
                <oldform>IR 7559</oldform>
                <newform>IR7559</newform>
            </entry>
            <entry OSCAL-ID="resource-37_e24" NEW-ID="ref_40">
                <oldform>IR 7622</oldform>
                <newform>IR7622</newform>
            </entry>
            <entry OSCAL-ID="resource-38_4b3" NEW-ID="ref_41">
                <oldform>IR 7676</oldform>
                <newform>IR7676</newform>
            </entry>
            <entry OSCAL-ID="resource-39_aa5" NEW-ID="ref_42">
                <oldform>IR 7788</oldform>
                <newform>IR7788</newform>
            </entry>
            <entry OSCAL-ID="resource-40_917" NEW-ID="ref_43">
                <oldform>IR 7817</oldform>
                <newform>IR7817</newform>
            </entry>
            <entry OSCAL-ID="resource-41_4f5" NEW-ID="ref_44">
                <oldform>IR 7849</oldform>
                <newform>IR7849</newform>
            </entry>
            <entry OSCAL-ID="resource-42_604" NEW-ID="ref_45">
                <oldform>IR 7870</oldform>
                <newform>IR7870</newform>
            </entry>
            <entry OSCAL-ID="resource-43_7f4" NEW-ID="ref_46">
                <oldform>IR 7874</oldform>
                <newform>IR7874</newform>
            </entry>
            <entry OSCAL-ID="resource-44_849" NEW-ID="ref_47">
                <oldform>IR 7956</oldform>
                <newform>IR7956</newform>
            </entry>
            <entry OSCAL-ID="resource-45_391" NEW-ID="ref_48">
                <oldform>IR 7966</oldform>
                <newform>IR7966</newform>
            </entry>
            <entry OSCAL-ID="resource-46_bba" NEW-ID="ref_49">
                <oldform>IR 8011-1</oldform>
                <newform>IR8011-1</newform>
            </entry>
            <entry OSCAL-ID="resource-47_704" NEW-ID="ref_50">
                <oldform>IR 8011-2</oldform>
                <newform>IR8011-2</newform>
            </entry>
            <entry OSCAL-ID="resource-48_996" NEW-ID="ref_51">
                <oldform>IR 8011-3</oldform>
                <newform>IR8011-3</newform>
            </entry>
            <entry OSCAL-ID="resource-49_d2e" NEW-ID="ref_52">
                <oldform>IR 8011-4</oldform>
                <newform>IR8011-4</newform>
            </entry>
            <entry OSCAL-ID="resource-50_4c5" NEW-ID="ref_53">
                <oldform>IR 8023</oldform>
                <newform>IR8023</newform>
            </entry>
            <entry OSCAL-ID="resource-51_81a" NEW-ID="ref_54">
                <oldform>IR 8040</oldform>
                <newform>IR8040</newform>
            </entry>
            <entry OSCAL-ID="resource-52_98d" NEW-ID="ref_55">
                <oldform>IR 8062</oldform>
                <newform>IR8062</newform>
            </entry>
            <entry OSCAL-ID="resource-53_a25" NEW-ID="ref_56">
                <oldform>IR 8112</oldform>
                <newform>IR8112</newform>
            </entry>
            <entry OSCAL-ID="resource-54_d42" NEW-ID="ref_57">
                <oldform>IR 8179</oldform>
                <newform>IR8179</newform>
            </entry>
            <entry OSCAL-ID="resource-55_38f" NEW-ID="ref_58">
                <oldform>IR 8272</oldform>
                <newform>IR8272</newform>
            </entry>
            <entry OSCAL-ID="resource-56_6af" NEW-ID="ref_61">
                <oldform>ISO 15408-1</oldform>
                <newform>ISO15408-1</newform>
            </entry>
            <entry OSCAL-ID="resource-57_870" NEW-ID="ref_62">
                <oldform>ISO 15408-2</oldform>
                <newform>ISO15408-2</newform>
            </entry>
            <entry OSCAL-ID="resource-58_445" NEW-ID="ref_63">
                <oldform>ISO 15408-3</oldform>
                <newform>ISO15408-3</newform>
            </entry>
            <entry OSCAL-ID="resource-59_15a" NEW-ID="ref_64">
                <oldform>ISO 20243</oldform>
                <newform>ISO20243</newform>
            </entry>
            <entry OSCAL-ID="resource-60_863" NEW-ID="ref_66">
                <oldform>ISO 27036</oldform>
                <newform>ISO27036</newform>
            </entry>
            <entry OSCAL-ID="resource-61_8df" NEW-ID="ref_68">
                <oldform>ISO 29147</oldform>
                <newform>ISO29147</newform>
            </entry>
            <entry OSCAL-ID="resource-62_06c" NEW-ID="ref_69">
                <oldform>ISO 29148</oldform>
                <newform>ISO29148</newform>
            </entry>
            <entry OSCAL-ID="resource-63_c28" NEW-ID="ref_71">
                <oldform>NARA CUI</oldform>
                <newform>NARA-CUI</newform>
            </entry>
            <entry OSCAL-ID="resource-64_d74" NEW-ID="ref_72">
                <oldform>NCPR</oldform>
                <newform>NCPR</newform>
            </entry>
            <entry OSCAL-ID="resource-65_795" NEW-ID="ref_74">
                <oldform>NIAP CCEVS</oldform>
                <newform>NIAP-CCEVS</newform>
            </entry>
            <entry OSCAL-ID="resource-66_528" NEW-ID="ref_79">
                <oldform>NITP12</oldform>
                <newform>NITP12</newform>
            </entry>
            <entry OSCAL-ID="resource-120_8cb" NEW-ID="Not in Word ref list">
                <oldform>SP 800-32</oldform>
                <newform>Not in Word ref list</newform>
            </entry>
            <entry OSCAL-ID="resource-126_a7f" NEW-ID="Not in Word ref list">
                <oldform>SP 800-41</oldform>
                <newform>Not in Word ref list</newform>
            </entry>
            <entry OSCAL-ID="resource-21_511" NEW-ID="Not in Word ref list">
                <oldform>EVIDACT</oldform>
                <newform>Not in Word ref list</newform>
            </entry>
            <entry OSCAL-ID="resource-30_7ba" NEW-ID="Not in Word ref list">
                <oldform>FIPS 201-2</oldform>
                <newform>Not in Word ref list</newform>
            </entry>
            <entry OSCAL-ID="resource-67_3d5" NEW-ID="ref_80">
                <oldform>NSA CSFC</oldform>
                <newform>NSA-CSFC</newform>
            </entry>
            <entry OSCAL-ID="resource-68_df9" NEW-ID="ref_81">
                <oldform>NSA MEDIA</oldform>
                <newform>NSA-MEDIA</newform>
            </entry>
            <entry OSCAL-ID="resource-69_89f" NEW-ID="ref_82">
                <oldform>ODNI CTF</oldform>
                <newform>ODNI-CTF</newform>
            </entry>
            <entry OSCAL-ID="resource-70_06d" NEW-ID="ref_83">
                <oldform>ODNI NITP</oldform>
                <newform>ODNI-NITP</newform>
            </entry>
            <entry OSCAL-ID="resource-71_367" NEW-ID="ref_84">
                <oldform>OMB A-108</oldform>
                <newform>OMB-A-108</newform>
            </entry>
            <entry OSCAL-ID="resource-72_278" NEW-ID="ref_85">
                <oldform>OMB A-130</oldform>
                <newform>OMB-A-130</newform>
            </entry>
            <entry OSCAL-ID="resource-73_d22" NEW-ID="ref_86">
                <oldform>OMB M-03-22</oldform>
                <newform>OMB-M-03-22</newform>
            </entry>
            <entry OSCAL-ID="resource-74_047" NEW-ID="ref_87">
                <oldform>OMB M-08-05</oldform>
                <newform>OMB-M-08-05</newform>
            </entry>
            <entry OSCAL-ID="resource-75_206" NEW-ID="ref_88">
                <oldform>OMB M-17-06</oldform>
                <newform>OMB-M-17-06</newform>
            </entry>
            <entry OSCAL-ID="resource-76_5f4" NEW-ID="ref_89">
                <oldform>OMB M-17-12</oldform>
                <newform>OMB-M-17-12</newform>
            </entry>
            <entry OSCAL-ID="resource-77_81c" NEW-ID="ref_90">
                <oldform>OMB M-17-25</oldform>
                <newform>OMB-M-17-25</newform>
            </entry>
            <entry OSCAL-ID="resource-78_227" NEW-ID="ref_92">
                <oldform>OMB M-19-15</oldform>
                <newform>OMB-M-19-15</newform>
            </entry>
            <entry OSCAL-ID="resource-79_d88" NEW-ID="ref_93">
                <oldform>OMB M-19-23</oldform>
                <newform>OMB-M-19-23</newform>
            </entry>
            <entry OSCAL-ID="resource-2_794" NEW-ID="ref_94">
                <oldform>POPEK74</oldform>
                <newform>POPEK74</newform>
            </entry>
            <entry OSCAL-ID="resource-80_18e" NEW-ID="ref_95">
                <oldform>PRIVACT</oldform>
                <newform>PRIVACT</newform>
            </entry>
            <entry OSCAL-ID="resource-3_c94" NEW-ID="ref_96">
                <oldform>SALTZER75</oldform>
                <newform>SALTZER75</newform>
            </entry>
            <entry OSCAL-ID="resource-81_4c0" NEW-ID="ref_142">
                <oldform>SP 800-100</oldform>
                <newform>SP800-100</newform>
            </entry>
            <entry OSCAL-ID="resource-82_10c" NEW-ID="ref_143">
                <oldform>SP 800-101</oldform>
                <newform>SP800-101</newform>
            </entry>
            <entry OSCAL-ID="resource-83_22f" NEW-ID="ref_144">
                <oldform>SP 800-111</oldform>
                <newform>SP800-111</newform>
            </entry>
            <entry OSCAL-ID="resource-84_6bc" NEW-ID="ref_145">
                <oldform>SP 800-113</oldform>
                <newform>SP800-113</newform>
            </entry>
            <entry OSCAL-ID="resource-85_42e" NEW-ID="ref_146">
                <oldform>SP 800-114</oldform>
                <newform>SP800-114</newform>
            </entry>
            <entry OSCAL-ID="resource-86_122" NEW-ID="ref_147">
                <oldform>SP 800-115</oldform>
                <newform>SP800-115</newform>
            </entry>
            <entry OSCAL-ID="resource-87_210" NEW-ID="ref_148">
                <oldform>SP 800-116</oldform>
                <newform>SP800-116</newform>
            </entry>
            <entry OSCAL-ID="resource-88_c7a" NEW-ID="ref_97">
                <oldform>SP 800-12</oldform>
                <newform>SP800-12</newform>
            </entry>
            <entry OSCAL-ID="resource-89_d17" NEW-ID="ref_149">
                <oldform>SP 800-121</oldform>
                <newform>SP800-121</newform>
            </entry>
            <entry OSCAL-ID="resource-90_0f6" NEW-ID="ref_150">
                <oldform>SP 800-124</oldform>
                <newform>SP800-124</newform>
            </entry>
            <entry OSCAL-ID="resource-91_886" NEW-ID="ref_151">
                <oldform>SP 800-125B</oldform>
                <newform>SP800-125B</newform>
            </entry>
            <entry OSCAL-ID="resource-92_801" NEW-ID="ref_152">
                <oldform>SP 800-126</oldform>
                <newform>SP800-126</newform>
            </entry>
            <entry OSCAL-ID="resource-93_20d" NEW-ID="ref_153">
                <oldform>SP 800-128</oldform>
                <newform>SP800-128</newform>
            </entry>
            <entry OSCAL-ID="resource-94_365" NEW-ID="ref_154">
                <oldform>SP 800-130</oldform>
                <newform>SP800-130</newform>
            </entry>
            <entry OSCAL-ID="resource-95_067" NEW-ID="ref_155">
                <oldform>SP 800-137</oldform>
                <newform>SP800-137</newform>
            </entry>
            <entry OSCAL-ID="resource-96_62e" NEW-ID="ref_156">
                <oldform>SP 800-137A</oldform>
                <newform>SP800-137A</newform>
            </entry>
            <entry OSCAL-ID="resource-97_e47" NEW-ID="ref_157">
                <oldform>SP 800-147</oldform>
                <newform>SP800-147</newform>
            </entry>
            <entry OSCAL-ID="resource-98_9ef" NEW-ID="ref_158">
                <oldform>SP 800-150</oldform>
                <newform>SP800-150</newform>
            </entry>
            <entry OSCAL-ID="resource-99_249" NEW-ID="ref_159">
                <oldform>SP 800-152</oldform>
                <newform>SP800-152</newform>
            </entry>
            <entry OSCAL-ID="resource-100_708" NEW-ID="ref_160">
                <oldform>SP 800-154</oldform>
                <newform>SP800-154</newform>
            </entry>
            <entry OSCAL-ID="resource-101_d9e" NEW-ID="ref_161">
                <oldform>SP 800-156</oldform>
                <newform>SP800-156</newform>
            </entry>
            <entry OSCAL-ID="resource-102_e3c" NEW-ID="ref_162">
                <oldform>SP 800-160-1</oldform>
                <newform>SP800-160-1</newform>
            </entry>
            <entry OSCAL-ID="resource-103_61c" NEW-ID="ref_163">
                <oldform>SP 800-160-2</oldform>
                <newform>SP800-160-2</newform>
            </entry>
            <entry OSCAL-ID="resource-104_e8e" NEW-ID="ref_164">
                <oldform>SP 800-161</oldform>
                <newform>SP800-161</newform>
            </entry>
            <entry OSCAL-ID="resource-105_295" NEW-ID="ref_165">
                <oldform>SP 800-162</oldform>
                <newform>SP800-162</newform>
            </entry>
            <entry OSCAL-ID="resource-106_e85" NEW-ID="ref_166">
                <oldform>SP 800-166</oldform>
                <newform>SP800-166</newform>
            </entry>
            <entry OSCAL-ID="resource-107_38f" NEW-ID="ref_167">
                <oldform>SP 800-167</oldform>
                <newform>SP800-167</newform>
            </entry>
            <entry OSCAL-ID="resource-108_7db" NEW-ID="ref_168">
                <oldform>SP 800-171</oldform>
                <newform>SP800-171</newform>
            </entry>
            <entry OSCAL-ID="resource-109_f26" NEW-ID="ref_169">
                <oldform>SP 800-172</oldform>
                <newform>SP800-172</newform>
            </entry>
            <entry OSCAL-ID="resource-110_1c7" NEW-ID="ref_170">
                <oldform>SP 800-177</oldform>
                <newform>SP800-177</newform>
            </entry>
            <entry OSCAL-ID="resource-111_388" NEW-ID="ref_171">
                <oldform>SP 800-178</oldform>
                <newform>SP800-178</newform>
            </entry>
            <entry OSCAL-ID="resource-112_30e" NEW-ID="ref_98">
                <oldform>SP 800-18</oldform>
                <newform>SP800-18</newform>
            </entry>
            <entry OSCAL-ID="resource-113_276" NEW-ID="ref_172">
                <oldform>SP 800-181</oldform>
                <newform>SP800-181</newform>
            </entry>
            <entry OSCAL-ID="resource-114_31a" NEW-ID="ref_173">
                <oldform>SP 800-184</oldform>
                <newform>SP800-184</newform>
            </entry>
            <entry OSCAL-ID="resource-115_c15" NEW-ID="ref_174">
                <oldform>SP 800-188</oldform>
                <newform>SP800-188</newform>
            </entry>
            <entry OSCAL-ID="resource-116_f5e" NEW-ID="ref_175">
                <oldform>SP 800-189</oldform>
                <newform>SP800-189</newform>
            </entry>
            <entry OSCAL-ID="resource-117_53d" NEW-ID="ref_176">
                <oldform>SP 800-192</oldform>
                <newform>SP800-192</newform>
            </entry>
            <entry OSCAL-ID="resource-118_f64" NEW-ID="ref_99">
                <oldform>SP 800-28</oldform>
                <newform>SP800-28</newform>
            </entry>
            <entry OSCAL-ID="resource-119_08b" NEW-ID="ref_100">
                <oldform>SP 800-30</oldform>
                <newform>SP800-30</newform>
            </entry>
            <entry OSCAL-ID="resource-121_bc3" NEW-ID="ref_101">
                <oldform>SP 800-34</oldform>
                <newform>SP800-34</newform>
            </entry>
            <entry OSCAL-ID="resource-122_77f" NEW-ID="ref_102">
                <oldform>SP 800-35</oldform>
                <newform>SP800-35</newform>
            </entry>
            <entry OSCAL-ID="resource-123_482" NEW-ID="ref_103">
                <oldform>SP 800-37</oldform>
                <newform>SP800-37</newform>
            </entry>
            <entry OSCAL-ID="resource-124_cec" NEW-ID="ref_104">
                <oldform>SP 800-39</oldform>
                <newform>SP800-39</newform>
            </entry>
            <entry OSCAL-ID="resource-125_155" NEW-ID="ref_105">
                <oldform>SP 800-40</oldform>
                <newform>SP800-40</newform>
            </entry>
            <entry OSCAL-ID="resource-127_314" NEW-ID="ref_106">
                <oldform>SP 800-45</oldform>
                <newform>SP800-45</newform>
            </entry>
            <entry OSCAL-ID="resource-128_83b" NEW-ID="ref_107">
                <oldform>SP 800-46</oldform>
                <newform>SP800-46</newform>
            </entry>
            <entry OSCAL-ID="resource-129_c3a" NEW-ID="ref_108">
                <oldform>SP 800-47</oldform>
                <newform>SP800-47</newform>
            </entry>
            <entry OSCAL-ID="resource-130_511" NEW-ID="ref_109">
                <oldform>SP 800-50</oldform>
                <newform>SP800-50</newform>
            </entry>
            <entry OSCAL-ID="resource-131_753" NEW-ID="ref_110">
                <oldform>SP 800-52</oldform>
                <newform>SP800-52</newform>
            </entry>
            <entry OSCAL-ID="resource-132_a21" NEW-ID="ref_111">
                <oldform>SP 800-53A</oldform>
                <newform>SP800-53A</newform>
            </entry>
            <entry OSCAL-ID="resource-133_46d" NEW-ID="ref_112">
                <oldform>SP 800-53B</oldform>
                <newform>SP800-53B</newform>
            </entry>
            <entry OSCAL-ID="resource-134_779" NEW-ID="ref_113">
                <oldform>SP 800-55</oldform>
                <newform>SP800-55</newform>
            </entry>
            <entry OSCAL-ID="resource-135_209" NEW-ID="ref_114">
                <oldform>SP 800-56A</oldform>
                <newform>SP800-56A</newform>
            </entry>
            <entry OSCAL-ID="resource-136_0d0" NEW-ID="ref_115">
                <oldform>SP 800-56B</oldform>
                <newform>SP800-56B</newform>
            </entry>
            <entry OSCAL-ID="resource-137_eef" NEW-ID="ref_116">
                <oldform>SP 800-56C</oldform>
                <newform>SP800-56C</newform>
            </entry>
            <entry OSCAL-ID="resource-138_110" NEW-ID="ref_117">
                <oldform>SP 800-57-1</oldform>
                <newform>SP800-57-1</newform>
            </entry>
            <entry OSCAL-ID="resource-139_e79" NEW-ID="ref_118">
                <oldform>SP 800-57-2</oldform>
                <newform>SP800-57-2</newform>
            </entry>
            <entry OSCAL-ID="resource-140_830" NEW-ID="ref_119">
                <oldform>SP 800-57-3</oldform>
                <newform>SP800-57-3</newform>
            </entry>
            <entry OSCAL-ID="resource-141_e72" NEW-ID="ref_120">
                <oldform>SP 800-60-1</oldform>
                <newform>SP800-60-1</newform>
            </entry>
            <entry OSCAL-ID="resource-142_9be" NEW-ID="ref_121">
                <oldform>SP 800-60-2</oldform>
                <newform>SP800-60-2</newform>
            </entry>
            <entry OSCAL-ID="resource-143_49b" NEW-ID="ref_122">
                <oldform>SP 800-61</oldform>
                <newform>SP800-61</newform>
            </entry>
            <entry OSCAL-ID="resource-144_737" NEW-ID="ref_123">
                <oldform>SP 800-63-3</oldform>
                <newform>SP800-63-3</newform>
            </entry>
            <entry OSCAL-ID="resource-145_909" NEW-ID="ref_124">
                <oldform>SP 800-63A</oldform>
                <newform>SP800-63A</newform>
            </entry>
            <entry OSCAL-ID="resource-146_489" NEW-ID="ref_126">
                <oldform>SP 800-70</oldform>
                <newform>SP800-70</newform>
            </entry>
            <entry OSCAL-ID="resource-147_858" NEW-ID="ref_127">
                <oldform>SP 800-73-4</oldform>
                <newform>SP800-73-4</newform>
            </entry>
            <entry OSCAL-ID="resource-148_7af" NEW-ID="ref_128">
                <oldform>SP 800-76-2</oldform>
                <newform>SP800-76-2</newform>
            </entry>
            <entry OSCAL-ID="resource-149_d4d" NEW-ID="ref_129">
                <oldform>SP 800-77</oldform>
                <newform>SP800-77</newform>
            </entry>
            <entry OSCAL-ID="resource-150_828" NEW-ID="ref_130">
                <oldform>SP 800-78-4</oldform>
                <newform>SP800-78-4</newform>
            </entry>
            <entry OSCAL-ID="resource-151_109" NEW-ID="ref_131">
                <oldform>SP 800-79-2</oldform>
                <newform>SP800-79-2</newform>
            </entry>
            <entry OSCAL-ID="resource-152_fe2" NEW-ID="ref_132">
                <oldform>SP 800-81-2</oldform>
                <newform>SP800-81-2</newform>
            </entry>
            <entry OSCAL-ID="resource-153_3dd" NEW-ID="ref_134">
                <oldform>SP 800-83</oldform>
                <newform>SP800-83</newform>
            </entry>
            <entry OSCAL-ID="resource-154_53b" NEW-ID="ref_135">
                <oldform>SP 800-84</oldform>
                <newform>SP800-84</newform>
            </entry>
            <entry OSCAL-ID="resource-155_cfd" NEW-ID="ref_136">
                <oldform>SP 800-86</oldform>
                <newform>SP800-86</newform>
            </entry>
            <entry OSCAL-ID="resource-156_a5b" NEW-ID="ref_137">
                <oldform>SP 800-88</oldform>
                <newform>SP800-88</newform>
            </entry>
            <entry OSCAL-ID="resource-157_5ee" NEW-ID="ref_138">
                <oldform>SP 800-92</oldform>
                <newform>SP800-92</newform>
            </entry>
            <entry OSCAL-ID="resource-158_25e" NEW-ID="ref_139">
                <oldform>SP 800-94</oldform>
                <newform>SP800-94</newform>
            </entry>
            <entry OSCAL-ID="resource-159_a6b" NEW-ID="ref_140">
                <oldform>SP 800-95</oldform>
                <newform>SP800-95</newform>
            </entry>
            <entry OSCAL-ID="resource-160_03f" NEW-ID="ref_141">
                <oldform>SP 800-97</oldform>
                <newform>SP800-97</newform>
            </entry>
            <entry OSCAL-ID="resource-161_e92" NEW-ID="ref_179">
                <oldform>USC 2901</oldform>
                <newform>USC2901</newform>
            </entry>
            <entry OSCAL-ID="resource-162_40b" NEW-ID="ref_182">
                <oldform>USCERT IR</oldform>
                <newform>USCERT-IR</newform>
            </entry>
            <entry OSCAL-ID="resource-163_984" NEW-ID="ref_183">
                <oldform>USGCB</oldform>
                <newform>USGCB</newform>
            </entry>
        </reference-map>
    </xsl:variable>
    
</xsl:stylesheet>