# OSCAL XML to OSCAL JSON and back

Following is work in progress! Be cautioned accordingly.

Pipelines for converting XML to JSON and back again

A mapping between XML and JSON forms of OSCAL is defined by OSCAL's underlying specification in its [set of metaschemas](https://github.com/usnistgov/OSCAL/tree/main/src/metaschema). For OSCAL (at least through v1.1.2) These source files have been used to produce XSLT transformations using the [metaschema-xslt](https://github.com/usnistgov/metaschema-xslt) processing framework.

See the GRAB-RESOURCES.xpl pipeline for paths to these resources.

Run the pipeline to acquire these stylesheets. They should be copied into your `lib` folder.

## Converting between JSON and XML

[XPath 3.0 defines a mapping](https://www.w3.org/TR/xpath-functions-31/#json-to-xml-mapping) between an XML-based syntax for JSON (JavaScript) object structures, and JSON syntax. This mapping is supported by functions in XPath, namely [json-to-xml()](https://www.w3.org/TR/xpath-functions-31/#func-json-to-xml) and [xml-to-json()](https://www.w3.org/TR/xpath-functions-31/#func-xml-to-json)

XProc 3.0 offers the same functionality by means of the `p:cast-content-type` step.

Pipelines in this directory support both generic conversions (JSON to XML is possible generically, while XML to JSON is not) and OSCAL-specific conversions as supported by transformations offered by OSCAL.

See and try the pipelines to determine what they do and how well they work.

At time of writing, building out this functionality to a stable state is a project priority - but not the first! Write us if more support in this area would be welcome.


---


