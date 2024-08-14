<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0"
   xmlns:cx="http://xmlcalabash.com/ns/extensions" xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:convert-xml-catalog-to-json" name="convert-xml-catalog-to-json">

   <p:xslt>
      <p:with-input port="stylesheet" href="../lib/oscal-converters/oscal_catalog_xml-to-json-converter.xsl"/>
      <p:with-option name="parameters" select="map{'indent': 'yes'}"/>
   </p:xslt>

</p:declare-step>