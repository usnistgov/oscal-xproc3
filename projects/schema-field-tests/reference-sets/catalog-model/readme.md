# OSCAL Catalog Model Reference Set

Composed to detect variances among OSCAL Catalog validators

## Document sets

- **fully-valid** - is what we call "valid" (see discussion in [application readme](../../readme.md))
- **schema-invalid** (aka "defective") doesn't even pass schema validation
- **constraints-invalid** (not "defective", but "disordered") - nb, empty for now pending work on constraints testing / InspectorXSLT
- For testing an XSD or JSON Schema, we detect **schema-invalid** and consider the others valid
- For testing an implementation of Metaschema constraints, we detect all three categories

## Updating and alignment
     
[CONVERT-XML-REFERENCE-SET.xpl](ONVERT-XML-REFERENCE-SET.xpl) converts a set of XML files into their OSCAL JSON equivalents.

To perform the conversion, it uses [an OSCAL catalog converter XSLT](../../lib/oscal-converters/oscal_catalog_xml-to-json-converter.xsl) downloaded by the XProc [`../../GRAB-OSCAL.xpl`](../../GRAB-OSCAL.xpl) (q.v.) and placed in the [application lib folder](../../lib/).

## Further work / TBD

How to align broken instances, not only correct ones?

Depending on the kind of brokenness, some broken instances are still convertible. So auto-converting to refresh (when we have confidence in conversion), or to compare (if we do not) is a viable path.

Easily confirming that we have converted correctly would require a diff that can deal.

Alternatively, a two-way conversion (there and back again) would tell us if an instance made it through unchanged, with a diff on the conversion.

Since this is all XSLT, it could be done in XSpec.

An XProc could run a conversion and back again, then invoke an XSpec to do the comparison, by document.

I.e. a "convertibility" test (short of a "validation") can be contrived easily, by

- converting, then back
- comparing before and after
- if the same, *this instance* is shown to be convertible
- if not, the delta is revealing of the lapse (to be aligned with a validation category)

Note that the trustworthiness of a *converter* might be assessed in another project TBD, presumably conversion-tests. It would align sets of documents, subject them to conversion, then examine results. Also could be done in XSpec.
