

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [../../source/oscal-convert/oscal-convert_400_src.html](../../source/oscal-convert/oscal-convert_400_src.html).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 400: Documents in XProc

## Goals

Learn how XProc's conception of a *document* can accommodate just about any kind of digital information.

This is especially important with respect to XProc's handling of formats beyond XML, including HTML, JSON, plain text, text-based syntaxes and binaries.

## Resources

A [content-types worksheet XProc](../../worksheets/CONTENT-TYPE_worksheet.xpl) is offered for trying out *content-type* options on XProc inputs and outputs.

XProc content types are closely tied to its definition of a *document*, an object for which a string property `content-type` indicates the expected or nominal content type. See links given in the remarks below. This is a topic you can also learn by through trial and error.

For those who want the authoritative word on this topic, [the XProc Specification](https://spec.xproc.org/3.0/xproc/#documents) is open and available. This coverage also dovetails with what has already been presented on [the XML Data Model (XDM) and XProc             ](../walkthrough/walkthrough_219.md).

## What is an XProc document

XProc has a concept of a document that permits just about any digital object or encoded entity to be considered and handled as such. XProc manages this by dividing its world into precincts (more on this below), which may be relatively well-known and well-specified, or the opposite. Well-known things can be handled in well known ways. Things not so well known might still be handled by an extension – making them tractable without a standardized approach). Because the boundaries are not fixed, more kinds of things can be rendered as documents over time, assuming we can find ways to represent them using the data model at hand. The model, as noted, is provided by XDM.

For an XProc engine to read XML, JSON, HTML and plain text is expected; for it to read (for example) metadata from inside image formats is a feature your XProc engine *may* offer. What XProc &ldquo;sees&rdquo; in either case is a **document**. There is a certain circularity here, if a document is &ldquo;what XProc reads&rdquo;, and what XProc reads are documents, but XProc is able to avoid this by saying, in effect:

* Any XDM value can be a document in XProc, even values that are not *document nodes* in XDM. So an XProc document might contain an XML element tree or it might be a simple string such as &ldquo;Hello World&rdquo;
* But anything else can also be a document in XProc, if a processor knows how to handle it in some way. For example, a step might know how to open an image format and extract metadata from it.

Accordingly, XML or HTML files make documents &ldquo;naturally&rdquo; – reflecting the fact that XDM was designed for the purpose of representing them. But the tree-shaped element structure and data typing system of XDM can also be generalized.

So any JSON file can also be a document, with the stipulation that like other inputs, it will be rendered (internally) by the XProc engine as an XDM object corresponding to this JSON. XDM - not a language or a syntax, but a data model – becomes the shared assumption across formats. Passed between steps in a pipeline, an XDM map is a document. At the end of the pipeline or at any interim point, an XDM map object can readily be saved out as JSON. An XDM element tree can be saved out as XML.

Core to thinking about XProc is this notion that there are **documents**, and then there are **serializations** of documents - the way documents are encoded as character streams in editing applications or persistent storage – and these are not the same, albeit one may consdered as a representation of the other. An XML document stored in a system and an XML document as processed by XProc are related and isomorphic, but not necessary identical. An [XProc document as defined formally](https://spec.xproc.org/3.0/xproc/#documents) comprises an XDM (in this context called the **representation**) with certain properties for XProc's convenience such as a base URI (actual or nominal) and a content type (for disambiguation).

Anything that can be rendered into XDM can be a document for XProc. XML and JSON come for free; other formats take more effort, or specialized steps (such as [a step used to uncompress archive file formats](https://spec.xproc.org/3.0/steps/#c.unarchive), thus converting one &ldquo;document&rdquo; into many). An XProc step supporting [Invisible XML](https://spec.xproc.org/master/head/ixml/#c.invisible-xml), provided with a grammar, can be deployed to write specialized steps that are able to handle and render the format described by such a grammar.

## A universe of content types

XProc needs a contract or working agreement with the world at large regarding how to refer to the various kinds of things XProc consumes and produces. The XProc concept and deployment of `content-type` properties is one of the main ways it does this. Read about more about XProc's content types[ in the specification](https://spec.xproc.org/3.0/xproc/#documents).

The short and easier story is that XProc's content types are aligned closely with media types or &ldquo;file types&rdquo; as they are defined broadly across Internet standards and protocols. Web developers will have a head start if they know how tools already distinguish between file and application formats in web technologies using identifiers such as `text/html` or `application/svg+xml`.

The longer story is that by relying on content types, XProc can effectively divide the world, like Gaul, into three parts, thereby making it possible to divide and conquer – or at least to recognize and negotiate with.

### XML and XML-like content

Always our first choice for working in XProc, this category includes these content types:

* `text/html` and `application/xhtml+xml` are the [HTML media types](https://spec.xproc.org/3.0/xproc/#html-documents)
* `application/xml`, `text/xml`, and all types matching `*something*/*something*+xml` except `application/xhtml+xml` constitute the [XML media types](https://spec.xproc.org/3.0/xproc/#xml-documents)

Since XProc has XPath – and of course, by design – XML is entirely transparent and natural to work with. XSLT and XQuery give us powerful and optimable methods for transformations and queries at scale, as soon as the source is recognizable as some kind of XML.

Since it is either XML (whether as XHTML or as HTML that happens to be well-formed XML syntax) or has well-defined mappings into XML (for example, `<br>` is parsed as an empty element), HTML can count as a specialized form of XML for XProc purposes. This is a joy: it means HTML is no different except in how it is read and written, and sometimes not even then. In particular, within XProc, XPath and other XML tools (such as XSLT and Schematron) both work with HTML in the same way as they do with XML.

### JSON and other text-based formats

* `text/*something*` including `text/plain`, except for `text/xml` and `text/html` are the [text media types](https://spec.xproc.org/3.0/xproc/#text-documents)
* `application/json` and any `application/*something*+json` are the [JSON media types](https://spec.xproc.org/3.0/xproc/#json-documents)

Both these types are accommodated straightforwardly as XDM objects: in the case of plain text, we have what amounts to a string, while JSON becomes an appropriate XDM type, most often a map, which is isomorphic to a JSON object with properties.

Additionally, the [XProc step                      p:ixml](https://spec.xproc.org/lastcall-2024-08/head/ixml/) provides for parsing any text-based format, provided with a grammar, into an XML structure.

As noted above, however, an XProc document does not actually require an element structure: it can be any XDM object when provided with internal properties for handling it. As such, any XDM can be passed through an XProc pipeline, operated on by steps and made available on their ports.

Thus while a common way of handling any information in XProc is to present an XML representation for it, that is not always necessary. Readers who have no prior experience with XPath 3.1 (or later) may never have seen the XPath *map* and *array* objects or the functions and operations associated with them. Some syntax might look like (and it is no mistake if this is familiar to JSON users):

| XPath expression | Explanation |
| `map { "a": "A", "b": "B" }` | A map with two entries, with keys "a" and "b"  |
| `map { "a": "A", "b": "B" }?a` | The value "A" returned from a map, using `?`, the lookup operator |
| `let $m := map { "a": "A", "b": "B" } return $m('b')` | The value "B" returned, using function call syntax |

In XPath, a map's keys (keywords for its entries) can be any atomic value, and an entry's value can be anything, including nodes (roots of trees) or arbitrary sequences. Because this fully comprehends the JSON object types, any JSON can be read into an XDM map - while the reverse is not always the case. For example, using the &ldquo;JSON&rdquo; serialization rules, serializing an XDM map with a node tree on a property will write that tree out, using XML syntax, into the property.

See also: [XPath 3.1 on maps,                   arrays and JSON](https://www.w3.org/TR/xpath-functions-31/#json-to-maps-and-arrays).

### Binaries and what-have-you

Because they cannot have a uniform parsing strategy, support for any content types not named above necessarily depends on implementors providing XProc steps to handle them. Certain standard steps such as `p:unarchive` and its relatives are useful to define for certain at-large binary file types, with effective standardization for certain content types (compressed files, i.e. zips and the like). But handling for arbitrary or unknown files and file types is a different matter.

Apart from XML, HTML, and text formats that can be parsed into an XDM object – whether a string, a map (reading JSON syntax) or an XML structure defined by iXML – any other digital data will fall into this &ldquo;anything else&rdquo; bucket. Inevitably, mileage varies. Depending on your processor some binary formats such as raster image formats might be effectively opaque, with only some metadata readable; other formats such as compression formats are simply wrappers for other resources. The semantics will vary according to the processor and file type(s) implicated.

This does not mean that such content types cannot be effectively standardized and supported as such. One important member of this category (as just noted) is an archived (zipped) file set, as defined for the three steps `p:archive`, `p:archive-manifest`, and `p:unarchive`. Due to felicitous choices by early engineers, common word processor and spreadsheet formats including `docx`, `xlsx` (Microsoft's [Office Open XML](https://en.wikipedia.org/wiki/Office_Open_XML_file_formats), ECMA-376 / ISO/IEC 29500:2008), `odt` and `ods` ([Open Document Format](https://en.wikipedia.org/wiki/OpenDocument)) can be unzipped to reveal sets of files including legible XML files – making these formats at least relatively accessible for XProc. Along similar lines, the step `p:uncompress` can handle the GZIP compression format.

`content-type="*/*"` is a match for &ldquo;any content type&rdquo;, very useful for handling arbitrary inputs, to the extent the processor supports them. Often even if a processor cannot read a file's contents meaningfully into a pipeline for manipulation, it can nevertheless work on the file resource, for example to copy, move or delete it.
