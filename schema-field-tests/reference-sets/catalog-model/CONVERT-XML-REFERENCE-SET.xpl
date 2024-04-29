<?xml version="1.0" encoding="UTF-8"?>
<?xml-model href="../../../testing/xspec-assurance.sch" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:cx="http://xmlcalabash.com/ns/extensions"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xslt"
   type="ox:CONVERT-XML-REFERENCE-SET"
   name="CONVERT-XML-REFERENCE-SET">
   
   <p:input port="samples" sequence="true">
      <p:document href="xml/fully-valid/okay-catalog.xml"/>
      <p:document href="xml/fully-valid/minimal.xml"/>
      <p:document href="xml/fully-valid/some-backmatter.xml"/>
      <p:document href="xml/fully-valid/some-parameters.xml"/>
      
      <p:document href="xml/schema-invalid/broken-date.xml"/>
      <p:document href="xml/schema-invalid/control-group-mixing.xml"/>
   </p:input>
   
   <p:for-each>
      <p:variable name="base" select="base-uri(.)"/>
      <p:variable name="json-file" select="replace($base,'xml','json')"/>

      <p:xslt>
         <p:with-input port="stylesheet" href="../../lib/oscal-converters/oscal_catalog_xml-to-json-converter.xsl"/>
         <p:with-option name="parameters" select="map{'json-indent': 'yes'}"/>
      </p:xslt>
      
      <p:store href="{$json-file}" message="Writing JSON file {$json-file} --"/>      
   </p:for-each>
   
</p:declare-step>