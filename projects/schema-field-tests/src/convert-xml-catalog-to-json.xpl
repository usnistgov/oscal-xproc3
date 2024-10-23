<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3" type="ox:convert-xml-catalog-to-json"
   name="convert-xml-catalog-to-json">

   <!-- UNTESTED - and not used yet ... take a look at project oscal-convert for data conversions -->
   
   <p:documentation>HOUSE RULES HALL PASS - add this file to ../../../testing/FILESET_XPROC3_HOUSE-RULES.xpl and remove this element</p:documentation>
   <p:documentation>
      <p:document href="../projects/schema-field-tests/src/convert-xml-catalog-to-json.xpl"/>
   </p:documentation>

   <p:xslt>
      <p:with-input port="stylesheet" href="../lib/oscal-converters/oscal_catalog_xml-to-json-converter.xsl"/>
      <p:with-option name="parameters" select="map{'indent': 'yes'}"/>
   </p:xslt>

</p:declare-step>