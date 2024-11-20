

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [](../../..).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 402: XProc, XML, JSON and content types

## Goals

Understand a little more about JSON and other data formats in an XML processing environment

## Resources

A [content-types worksheet XProc](../../worksheets/CONTENT-TYPE_worksheet.xpl) is offered for trying out content-type options on XProc inputs and outputs. If you only have thirty minutes, consider looking at it before reading further.

XProc content types are closely tied to its definition of a *document*, an object for which a string property `content-type` indicates the expected or nominal content type.See links given in the remarks below. This is a topic you can also learn by through trial and error.

## XProc documents and content types

XProc needs a contract or working agreement with the world at large regarding how to refer to the various kinds of things XProc consumes and produces. The XProc concept and deployment of `content-type` properties is one of the main ways it does this. Read about XProc's content types[ in the specification, which normatively defines all                the terms](https://spec.xproc.org/3.0/xproc/#documents).

The short and easier story is that XProc's content types are aligned closely with media types or &ldquo;file types&rdquo; as they are defined broadly across Internet standards and protocols. Web developers will have a head start if they know how tools already distinguish between file and application formats in web technologies using identifiers such as `text/html` or `application/svg+xml`.

The longer story is that by relying on content types, XProc can effectively divide the world, like Gaul, into three parts, thereby making it possible to divide and conquer – or at least to recognize and negotiate with.

### XML and XML-like content

Always our first choice for working with in XProc, this category include these content types:

* `text/html` and `application/xhtml+xml` are the [HTML media types](https://spec.xproc.org/3.0/xproc/#html-documents)
* `application/xml`, `text/xml`, and all types matching `*something*/*something*+xml` except `application/xhtml+xml` constitute the [XML media types](https://spec.xproc.org/3.0/xproc/#xml-documents)

Since XProc has XPath, XML is entirely transparent and natural to work with. XSLT and XQuery give us optimized methods for transformations and queries at scale, as soon as the source is recognizable as some kind of XML.

Since it is either XML or has well-defined mappings into XML, HTML can count as a specialized form of XML for XProc purposes. This is a joy: it means HTML is no different except in how it is read and written, and sometimes not even then. In particular, within XProc, XPath and other XML tools (such as XSLT and Schematron) both work with HTML the same as they do with XML.

### JSON and other text-based formats

* `text/*something*` including `text/plain`, except for `text/xml` and `text/html` are the [text media types](https://spec.xproc.org/3.0/xproc/#text-documents)
* `application/json` and any `application/*something*+json` are the [JSON media types](https://spec.xproc.org/3.0/xproc/#json-documents)

Both these types are accommodated straightforwardly as XDM objects: in the case of plain text, we have what amounts to a string, while JSON becomes an appropriate XDM type, most often a map, which is isomorphic to a JSON object with properties.

The [XProc step p:ixml](https://spec.xproc.org/lastcall-2024-08/head/ixml/) is provided to processors supporting [Invisible XML](https://invisiblexml.org/). It enables parsing of text strings according to a grammar and delivering the resulting parse tree in an XML representation.

As for JSON, it can conveniently be cast into an XML vocabulary defined by XPath, using the same semantics as XPath 3.1 `fn:json-to-xml($json-string)`, which produces XML using a vocabulary for map objects defined by XPath. One way to do this is with the `p:cast-content-type` step, designed for the purpose, indicating an XML content type [or the shortcut xml](https://spec.xproc.org/3.0/xproc/#specified-content-types). 

Yet it is also important and useful to keep in mind how an [XProc document](https://spec.xproc.org/3.0/xproc/#documents) does not have to be XML, or indeed any XDM document (node) or element. The XProc concept is general enough to allow for any XDM data object can be provided with properties in XProc (base URI, content-type and when applicable serialization settings) that enable it to be passed through an XProc pipeline, operated on by steps and made available on their ports. At all times, a serialization for such a document – even a value or fragment of XDM such as a map, as distinct from an XML element tree we can easily serialize as XML – is nevertheless available as long as it is regarded as JSON, because XDM objects, with some limitations, are readily expressible as JSON, and conversely JSON objects of whatever identified (primitive) type (object, array, string, number, boolean etc.) can be considered &ldquo;at home&rdquo; within the XProc context if only they have an XDM analog, as they mainly do. Significantly, as XPath map objects, arbitrary JSON objects of whatever size and extent can now be queried using XPath – a feature that XProc can take advantage of.

See also: [XPath 3.1 on maps,                   arrays and JSON](https://www.w3.org/TR/xpath-functions-31/#json-to-maps-and-arrays).

#### XPath maps, with operators and functions

Readers who have no prior experience with XPath 3.1 (or later) may never have seen the XPath *map* and *array* objects or the functions and operations associated with them. Some syntax might look like (and it is no mistake if this is familiar to JSON users):

| XPath expression | Explanation |
| map { "a": "A", "b": "B" } | A map with two entries, with keys "a" and "b"  |
| map { "a": "A", "b": "B" }?a | The value "a" returned from a map, using lookup operator |
| map { "a": "A", "b": "B" } return $m('b') | The value "b" returned using function call syntax |

In XPath, a map's keys (keywords for its entries) can be any atomic value, and an entry's value can be anything, including nodes (roots of trees) or arbitrary sequences. The subset of XPath maps whose keys are strings and whose values, roughly, are amenable to serialization (so strings and numbers and arrays and maps, but not node trees), aligns with JSON.

For the word on XPath maps, see the [XPath 3.1                      Recommendation on the topic](https://www.w3.org/TR/xpath-31/#id-maps).

### Binaries and &ldquo;other&rdquo;

Support for any content types not named above (and thus in a recognizable category for purposes of parsing strategy) must necessarily fall on implementors. Certain standard steps such as `p:unarchive` and its relatives are useful to define for certain at-large binary file types, with effective standardization for certain content types (compressed files i.e. zips and the like); handling for arbitrary or unknown files and file types is a different matter.

Depending on your processor some binary formats such as raster image formats might be effectively opaque, with only some metadata readable; other formats such as compression formats are simply wrappers for other resources. The semantics will vary according to the processor and file type(s) implicated.

This does not mean that such content types cannot be effectively standardized and supported as such. One important member of this category is a file representing a zipped or compressed file set, as defined for the three steps `p:archive`, `p:archive-manifest`, and `p:unarchive`. Due to felicitous choices by early engineers, common word processor and spreadsheet formats including `docx`, `xlsx`, `odt` and `ods` can all be uncompressed to reveal sets of files including legible XML files – making these formats at least relatively accessible for XProc.

`content-type="*/*` is a match for &ldquo;any content type&rdquo;, very useful for handling arbitrary inputs, to the extent the processor supports them (for example moving and copying even if not reading).
