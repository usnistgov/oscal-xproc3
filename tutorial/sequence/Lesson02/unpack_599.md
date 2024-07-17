599: XProc ecosystem
# 599: XProc ecosystem

More in depth.

## Goals

 * More familiarity with XProc 3.0: more syntax
 * History, concepts and resources
 

## Resources

The same pipelines you ran in setup: [Setup 101](../setup/setup_101_src.html).

Also, [XProc.org dashboard page](https://xproc.org)

Also, XProc index materials produced in this repository: [XProc
               docs](../../../xproc-doc/readme.md)

## Prerequisites
Same as [Setup 101](setup_101_src.html).

## XProc schema

A schema for the XProc language, considered as core steps (compound and atomic) plus optional community-defined steps, is referenced from the XProc Specification. This RNG schema is very useful.

However, for the most part it is necessary only to validate in the application, i.e. to let Morgana (in this case) take responsibility for this operation as it sees fit. The reference schema becomes useful if we find or suspect bugs in Morgana, but until then it has no direct role in any runtime operation.

Nevertheless the RNG schema can still be very useful as a reference and an object for querying -- queries whose results tell us about XProc.

## XPath

Like other XDM-based technologies, XProc embeds and incorporates XPath, an expression language for XML. XPath 3.0 is a functional language in its own right, although not designed for end-to-end processing of encoded source data into encoded results, but only for certain critical operations that ordinarily need to be performed within such end-to-end processing. Since it is partial in this way, XPath is defined not in terms of any data notation (such as XML syntax or any other) but rather against an *abstract data object*, namely an [XDM](https://www.w3.org/TR/xpath-datamodel/) instance (XML data model), a putative information object that may be provided to the system by parsing an XML (syntax) instance, or by other means. As the query language for [XDM](https://www.w3.org/TR/xpath-datamodel/) and the basis for XQuery, [XPath](https://www.w3.org/TR/xpath-31/) is the "other half" of the data model, which any architect of a system using this technology must know. Learning XPath equips you mentally for dealing with the XDM in XQuery, XSLT, XProc or anywhere you find it.

For those not already familiar with XPath, on line resources can be helpful. Keep in mind that [XPath 3.1](https://www.w3.org/TR/xpath-31/) outstrips XPath 1.0 in many important respects.

### XML time line

[TODO: complete this]

      | Year | Publication | Capabilities | Processing frameworks |
| --- | --- | --- | --- |
  | 1998 | XML 1.0 | syntax | Batch processing, shell scripts, `make` |
| --- | --- | --- | --- |
 | 1999 | XPath 1.0, XSLT 1.0 | basic tree querying and transformations (down hill) | Web browsers? (some, sort of) |
 |  | XQuery 1.0 |  | Perl, Python, Java APIs / integration |
 |  | XPath 2.0 |  | Server frameworks (Apache Cocoon) |
 |  |  |  | Apache Ant |
 |  |  |  |  |
 | 2007 | XSLT 2.0 | transformations (up hill) | XProc 1.0 |
 |  | XDM (XML data model) | unification |  |
 |  | XPath 3.0 |  | Web browsers (all - but only XPath 1.0/HTML DOM Level 4) |
 |  | XPath 3.1 | higher-order functions, map and array objects |  |
 |  | XProc 1.0 |  |  |
 | 2017 | XSLT 3.0/3.1 | JSON harmonization, functions as arguments |  |
 |  | XProc 3.0 |  |  |
 
The technologies have been in constant use over this period.

Historically, the requirements of processing frameworks have often been met by software developers' build utilities (for example, GNU `make` or Apache Ant). This is not an accident: in certain respects, a publishing framework can be considered as a "documentary build" at a higher level.

### XPath illustrative examples

This is not the place to learn XPath, but a selection of XPaths can offer a hint of its capabilities.

    | XPath | Returns |
| --- | --- |
  | `/html` | An XML document root (top-level) element named `html` (subject to namespace resolution) |
| --- | --- |
 | `//p` | All the elements named `p` in the document |
 | `//seg[@type='null']` | All the elements named `seg` with an attribute `type` with value `null` |
 | `/*` | Any document (rather, any element at the top of a document) - `*` is a wildcard character |
 | `/section[exists(.//table)]` | An element inside the top-level element, named `section`, that contains a `table` element anywhere inside it |
 | `/descendant::p[10]` | The tenth `p` element in the document |
 | `//p[10]` | All `p` elements, that are the tenth `p` inside their respective parents |
 | `//section[count(.//p) gt 10]` | All `section` elements that contain more than 10 `p` elements, anywhere inside |
 
## XML and XDM: context and rationale

TODO: edit down

 * Freely available without restriction
 * Consistently and repeatedly shown to be capable at this scale (size/complexity)
 * Commodity and standards-based, easing problem of proprietary product endorsement
 
The technologies we rely on share a common foundation in XML and XDM, technologies developed under the auspices of the World Wide Web Consortium.They are commodity tools in the sense that they are freely available to use without restriction, an important qualification for this distribution, which *cannot endorse any particular technological solution to any problem*, however posed or circumscribed. Accordingly, solutions here are not offered as endorsements but as stipulations of (minimum) viable functionality in tools or capabilities, and not only using tools as "black boxes", but under control and conformant to external specifications (standards).
Users of these tools should keep in mind the model whereby we imagine the viability of a tools market and ecosystem that enables both large and small software developers including independent developers, academic researchers, and students, to participate meaningfully, finding an appropriate value or service proposition to provide their long-term goals. Translated, this means the tools must be capable enough for industrial use at scale, while also "scale down" to demonstration or classroom use.In web standards including HTML and Javascript (ECMAScript) we arguably have the beginnings of such an ecosystem, while it is also contested and turbulent. Within the publishing sector more broadly and intersecting with the web, the XML family of standards arguably provides the best demonstration of complete or near-complete capabilities at least with respect to the harder problems of document processing.

 * XSLT up to [XSLT 3.0](https://www.w3.org/TR/xslt-30/) (in [Saxon](https://www.saxonica.com/welcome/welcome.xml))
 * [XQuery](https://www.w3.org/TR/xquery-31/) (in Saxon)
 * [Schematron](https://github.com/Schematron) (in [SchXSLT](), an open-source implementation in XSLT of [Schematron](https://schematron.com/) including the [ISO/IEC 19757-3](https://www.iso.org/obp/ui/#iso:std:iso-iec:19757:-3:ed-3:v1:en) specification
 * [XSpec](https://github.com/xspec/xspec), a community-maintained XSLT-based framework for test-driven development, supporting testing XSLT, XQuery and Schematron
 
Since they are known to be highly conformant to their respective specifications as well as well tested, these tools provide a useful functional baseline for other tooling that addresses the same functional requirements.
They are also, relatively speaking, *mature* technologies, at least in comparison to similar offerings.
And when XProc works, we also have the functional underpinnings we need for comparing - for example - different XSLT implementations.

Initiated in 1996, XML continues to be generative in 2024.
