
> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [/tutorial/source/unpack/unpack_599_src.html](../../../tutorial/source/unpack/unpack_599_src.html).

> 
To create a persistent copy (for example, for purposes of annotation) save this file out elsewhere, and edit the copy.

# 599: More context

More in depth.

## Goals

* Consider XProc in its operational context including available **standards** and applicable **requirements**, both generalized and local
* Learn or relearn some deep XML history including alternative approaches
* Inform your capability to assess the utility and appropriateness of XProc in particular and XML in general, for a given problem or domain


## Resources

The same pipelines you ran in setup: [Setup 101](../setup/setup_101.md).

Also, [XProc.org dashboard page](https://xproc.org)

Also, XProc index materials produced in this repository: [XProc
               docs](../../../projects/xproc-doc/readme.md)

## Prerequisites

Same as [Setup 101](../setup/setup_101.md). Prior exercises, or the practical equivalent, are assumed.

## XProc schema

A schema for the XProc language, considered as core steps (compound and atomic) plus optional community-defined steps, is referenced from the [XProc Specification](https://spec.xproc.org/3.0/xproc/#ancillary-files). [This RNG schema](https://spec.xproc.org/3.0/xproc/xproc30.rng) is very useful.

It may often be considered gratuitous to validate XProc files against a schema, when the application (for us, Morgana)must in any case take responsibility for conformance issues, as it sees fit. The reference schema becomes useful if we find or suspect bugs in Morgana, but until then it need not have any direct role in any runtime operation.

Nevertheless the RNG schema still serves as a reference and an object for querying -- queries whose results tell us about XProc. [A pipeline](../../GRAB-XPROC-RESOURCES.xpl) for acquiring both RNG schema and its RNC (compact syntax) variant is provided for interest and possible later use.

## XPath

Like other XDM-based technologies, XProc embeds and incorporates XPath, an expression language for XML. XPath 3.0 is a functional language in its own right, although not designed for end-to-end processing of encoded source data into encoded results, but only for certain critical operations that ordinarily need to be performed within such end-to-end processing. Since it is partial in this way, XPath is defined not in terms of any data notation (such as XML syntax or any other) but rather against an *abstract data object*, namely an [XDM](https://www.w3.org/TR/xpath-datamodel/) instance (XML data model), a putative information object that may be provided to the system by parsing an XML (syntax) instance, or by other means. As the query language for [XDM](https://www.w3.org/TR/xpath-datamodel/) and the basis for XQuery, [XPath](https://www.w3.org/TR/xpath-31/) is the &ldquo;other half&rdquo; of the data model, which any architect of a system using this technology must know. Learning XPath equips you mentally for dealing with the XDM in XQuery, XSLT, XProc or anywhere you find it.

For those not already familiar with XPath, on line resources can be helpful. Keep in mind that [XPath 3.1](https://www.w3.org/TR/xpath-31/) outstrips XPath 1.0 in many important respects.

### Documents and data

One of the more important features of XPath and the XDM is that they are designed not only to meet needs for the representation and transmission of structured data. A specialized class of data formats has evolved that represent information in ways that are not &ldquo;unstructured&rdquo;, but that contrast with more common or usual structures of data formats, whether they be tabular data, serialization formats for object models, or some other regular and fore-ordained arrangement. One might say &ldquo;common&rdquo; or &ldquo;usual&rdquo; with reservation, since of course documents are not uncommon where they are common.

We see a great deal of structured data these days if only because it is so easy to make structured data with machines, and we now have the machines. What remains difficult is to translate what has not been created by a machine, into a form that a machine can &ldquo;recognize&rdquo;, or rather into a form we can recognize in and with the machine, without destroying it.

So documents are called &ldquo;unstructured&rdquo; but they might better be called &ldquo;relatively irregular&rdquo;, meaning not that they have no structure, but that each one is structured in itself, and moreover, likely to be incompatible or not fully compatible with encodings designed to capture other structures.

And to the extent this is the case, any encoding capable of describing documents must have the capability of supporting each document's own distinctive structure and organization, whether that be due to its family (what is called a **document type**) or an expression of its own intrinsic logic. The format must be not only structured, but *structurable*, and its structures must to some extent be capable of self-description ??? combining data with metadata.

And this is to give no consideration to the fact that these structures can be described at *multiple levels* of generality or specificity with regard to either their supposed semantics, or their configuration in operation.

Documentary data formats especially markup formats are designed to work in this in-between space.

And so we get XPath - a query syntax which permits working with an organized structure of a particular kind (an *XDM document tree*), which in turn is designed for handling the combination of *highly regular* and *quite irregular* data structures that characterize information sets we (loosely) call **documentary**.

A definition for what is a document is out of scope for this tutorial ??? an interesting topic but not only a technical one.

## XML time line

[TODO: complete this, or move it, or both]

| Year | Publication | Capabilities | Processing frameworks | Platforms |
| --- | --- | --- | --- | --- |
| 1987 | SGML (ISO-IEC 8879-1) | parsing logic; schema validation; configurable syntax; tree of elements and attributes | Proprietary stacks | Mainframes, workstations |
| 1998 | XML 1.0 | standard syntax | Batch processing, shell scripts, `make` | Mainframes, workstations, PCs (x86 generation) |
| 1996 | Unicode 2.0 | standard character sets | Support for Unicode is slow to come |  |
| 1999 | XPath 1.0, XSLT 1.0 | basic tree querying and transformations (down hill); functional support for namespaces | Web browsers? (some, sort of) |  |
| 2000 |  |  | Apache Ant | Java |
|  | XQuery 1.0 |  | Perl, Python, Java APIs / integration |  |
|  | XPath 2.0 |  | Server frameworks (Apache Cocoon) |  |
| 2001 | XML Schema Definition language (XDM) | Standardizes atomic data types (foundations of XSD); namespace-based validation (RNG also offers this, 2001-2002) |  |  |
| 2003-2004 | W3C Document Object Model (DOM) | API for HTML and XML documents |  |  |
| 2005 | &ldquo;The XML data model&rdquo; (W3C) | An essay |  |  |
|  |  |  |  |  |
| 2007 | XSLT 2.0 | transformations (up hill) | XProc 1.0 |  |
|  | XDM (XPath/XQuery data model) | unification |  | Client- and server-side XML processing stacks |
|  |  |  | XQuery+XSLT in eXist-db or BaseX (XQuery engines) |  |
|  | XPath 3.0 |  |  |  |
|  | XPath 3.1 | higher-order functions, map and array objects |  |  |
|  | XProc 1.0 |  |  |  |
| 2017 | XSLT 3.0/3.1 | JSON harmonization, functions as arguments |  |  |
|  | XProc 3.0 |  |  |  |
| 2022 | Unicode 15.0 |  |  |  |

The technologies have been in constant use over this period.

Historically, the requirements of processing frameworks have often been met by software developers' build utilities (for example, GNU `make` or Apache Ant). This is not an accident: in certain respects, a publishing framework can be considered as a &ldquo;documentary build&rdquo; at a higher level.

## XPath illustrative examples

This is not the place to learn XPath, but a selection of XPath expressions can offer a hint of its capabilities.

| XPath | Returns | XPath long (explicit) notation |
| --- | --- | --- |
| `/html` | An XML document root (top-level) element named `html` (subject to namespace resolution) | `/child::html` |
| `//p` | All the elements named `p` in the document | `/descendant-or-self::element()/child::p` |
| `//seg[@type='null']` | All the elements named `seg` with an attribute `type` with value `null` | `/descendant-or-self::element()/child::seg[attribute::type='null']` |
| `/*` | Any document (rather, any element at the top of a document) - `*` is a wildcard character | `/child::element()` |
| `/section[exists(.//table)]` | An element inside the top-level element, named `section`, that contains a `table` element anywhere inside it | `/child::section[exists(self::node()/descendant-or-self::element()/child::table)]` |
| `/descendant::p[10]` | The tenth `p` element in the document | `/descendant::p[position() eq 10]` |
| `//p[10]` | All `p` elements, that are the tenth `p` inside their respective parents | `/descendant-or-self::element()/child::p[position() eq 10]` |
| `//section[count(.//p) gt 10]` | All `section` elements that contain more than 10 `p` elements, at any depth | `/child::section[count(self::node()/descendant-or-self::element()/child::p) gt 10]` |

## XML and XDM: context and rationale

* Standard, non-proprietary and freely available without restriction
* Consistently and repeatedly shown to be capable at scale (size/complexity)
* Supported by commodity tools, easing problem of proprietary product endorsement


The technologies we rely on share a common foundation in XML and XDM, technologies developed under the auspices of the World Wide Web Consortium. 

They are commodity tools in the sense that they are freely available to use without restriction, an important qualification for this distribution, which has a prior commitment *not to endorse particular technological solutions to any problem*, however posed or circumscribed. Accordingly, solutions here are not offered as recommendations, but rather as stipulations of (minimum) viable functionality in tools or capabilities, and not only using tools as &ldquo;black boxes&rdquo;, but under control and conformant to external specifications ??? i.e., standards.

Users of these tools should keep in mind the model whereby we imagine the viability of a tools market and ecosystem that enables both large and small software developers including independent developers, academic researchers, and students, to participate meaningfully, finding an appropriate value or service proposition to provide their long-term goals. Translated, this means the tools must be capable enough for industrial use at scale, while also &ldquo;scale down&rdquo; to demonstration or classroom use.

In web standards including HTML and Javascript (ECMAScript) we arguably have the beginnings of such an ecosystem, while it is also contested and turbulent. Within the publishing sector more broadly and intersecting with the web, the XML family of standards arguably provides the best demonstration of complete or near-complete capabilities at least with respect to the harder problems of document processing.

* XSLT up to [XSLT 3.0](https://www.w3.org/TR/xslt-30/) (in [Saxon](https://www.saxonica.com/welcome/welcome.xml))
* [XQuery](https://www.w3.org/TR/xquery-31/) (in Saxon)
* [Schematron](https://github.com/Schematron) (in [SchXSLT](https://github.com/schxslt/schxslt), an open-source implementation in XSLT of [Schematron](https://schematron.com/) including the [ISO/IEC 19757-3](https://www.iso.org/obp/ui/#iso:std:iso-iec:19757:-3:ed-3:v1:en) specification
* [XSpec](https://github.com/xspec/xspec), a community-maintained XSLT-based framework for test-driven development, supporting testing XSLT, XQuery and Schematron


Since they are known to be highly conformant to their respective specifications as well as well tested, these tools provide a useful functional baseline for evaluating other tooling that addresses the same functional requirements.

They are also, relatively speaking, *mature* technologies, at least in comparison to similar offerings.

And when XProc works, we also have the functional underpinnings we need for comparing - for example - different XSLT implementations.

Initiated in 1996, XML continues to be generative in 2024.

## Exercise: Discussion board

Create or contribute to a Github discussion board offering perspective or (especially!) relevant information or experience on any of the larger questions.
