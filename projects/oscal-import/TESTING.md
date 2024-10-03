# Testing OSCAL conversion from raw data

Testing this production pipeline is performed interactively and progressively by inspecting outputs, both directly ("raw code") and with tools. Commonly this means opening and reviewing HTML in a browser, or XML in an IDE, browser or diff tool.

Users of NISO STS XML may be pleased to know of [a browser-based STS viewer]( https://pages.nist.gov/xslt-blender/sts-viewer/)

For developers who know XSLT 1.0 [an OSCAL "fiddle" viewer](https://pages.nist.gov/xslt-blender/oscal-styler/) may also be interesting.

## Quality assurance in the process

External testing of process results in the form of schema and Schematron validation is included in the main pipeline, to provide runtime process assurance and regression testing. As this is built into the pipeline, it 'just happens' (assuming resources have been made available).

To test it, alter an XSLT in such a way that final outputs will be predictably invalid, and run the pipeline to observe behavior. (Then change the XSLT back.)

## Testing in development

However, precisely since the process being demonstrated is so "hands on", testing is embedded in the runtime and the workflow rather than being codified in external tests or test suites.

Unit testing of XSLT may still be useful (and may still be offered), if only to validate and demonstrate functionality of XSLT filtering logic deployed in the pipelines - logic which is sometimes quite abstruse and 'non-obvious', i.e. as peculiar as the incoming data it is designed to recognize and correct or enhance.

Since one of the best uses of XSpec is to illuminate the functionality of arcane, opaque code designed to address unusual, sometimes complex requirements, an XSpec library for testing XSLT here remains a TBD.

## `temp` directory files

Because they are intended as temporary artifacts, *all* results are written into this folder, including final results. These can be saved out or copied elsewhere when persistent copies are needed.

Short of unit-testing the XSLTs, the best testing for the pipeline processes independently is to compare their respective sources and results in the form of interim files written to the system.

To do this, set option `$writing-all` is set to `true` in [the pipeline](PRODUCE_FM6-22-chapter4.xpl)) and compare files written into the `temp` directory (as instructed by `p:store`).




