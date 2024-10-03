# oscal-validation TESTING

To validate OSCAL as demonstrated in this project is effectively to test it, albeit not by application (that is, using OSCAL as designed) but rather in a laboratory setting, subjecting it to a set of tests that are used together as a proxy for quality in other contexts.

These tests can in general span a great range, while within the context of XML, *validation* is also a technical term referring to specific testing criteria offered by specific technologies including (but not limited to) XML Schema Definition Language (XSD), XML DTDs (Document Type Definitions) as defined by XML 1.0, and other technologies.

This repository focuses initially on two validation methods applicable to OSCAL XML:

- XSD schema validatio using an officially released OSCAL XSD (schema)
- Query-based validation using Schematron, an XML validation stack based on XPath/XSLT

## Testing validation capability

The pipeline XSD-VALIDATE-EXAMPLE.xpl attempts to validate a single controlled and stable) XML instance, against the provided OSCAL schema, to confirm validation functionality.

With this valid instance, the [samples](./samples/) directory contains an invalid instance. Alter and test [XSD-VALIDATE-EXAMPLE.xpl](./XSD-VALIDATE-EXAMPLE.xpl) by pointing to this document instead of the document given, and compare the results.

Of special interest here is that "good" outcomes (valid data) deliver *silence* while bad outcomes deliver noise (or rather, error messages - terrible music), because to be valid means ipso facto to be found "without error", so nothing is to be reported.

In order to test Schematron capability in your XProc engine, run the ["Schematron smoke test" pipeline](../../smoketest/TEST-SCHEMATRON.xpl) (not in this project). It should complete successfully when run.

Tests may include XSpec testing over XSLTs or Schematrons.

XML documents (of any flavor) may be tested by means of validation, Schematron or other analysis.

There may be ad-hoc testing or interactive testing to be documented.

