

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [/tutorial/source/oscal-convert/oscal-convert_401_src.html](../../../tutorial/source/oscal-convert/oscal-convert_401_src.html).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 401: XProc, XML, JSON and content types

## Goals

Understand a little more about JSON and other data formats in an XML processing environment

## Resources

See links given in the remarks below. This is a topic you can also learn by through trial and error.

## File formats and XProc content type

Media types or what XProc calls *content types* is a concept XProc inherits from Internet standards such as RFC 2045 (1996) and subsequent specifications for file and attachment types on the Internet. Naturally, since a file's nominal format is scoped to its extent (while we have nominally multi-part formats such as `multipart/x-zip`, each media type descriptor is assigned to a file, giving us a single media type per file), this becomes the most useful and transparent way to manage file format distinctions. Names may *mostly* indicate file types, as we conventionally suffix both XML and JSON (`xml` and `json` respectively) if only to keep ourselves sane. But when the system reports a file as `application/xml` we should be inclined to believe it, unless we have better information to the contrary.

Because an XProc processor comes ready to recognize a range of content types, this becomes an indispensable point of control for managing our information across the variety of formats in which we find it. XML is a meta-language, and describes a syntax while not prescribing any semantics beyond the structural semantics implied in element and attribute naming and containment – this proves to be a very useful in the XProc context, since it means that semantics can be abstracted out – the further the better – into externalized transformations and processes (often, XSLTs) that become black boxes and resources to manage, rather than more code in the code base. But the world deals in much more than XML, and XProc makes the same layering and separation of concerns possible with JSON and other standardized or codified serialization formats.

## Content type 'application/json'

XProc follows the lead of XPath in offering two distinct but complementary ways of handling JSON.

### JSON as XPath `map` object

With XPath 3.1 the language now supports arrays and maps as first-class objects. These are an interesting addition to XPath, among other reasons because JSON object types now all have natural equivalents within XDM. Strings, numeric types, Boolean values, and now arrays and maps can be represented and processed natively in XPath. These objects are supported with operations appropriate to them - such that, for example, `$map('field')` or more succinctly `$map?field` will return the value of the `field` field on the map object. Since map keys do not duplicate, they essentially correspond exactly with JSON objects.

XPath maps are [described in full in the XPath                   specification](https://www.w3.org/TR/xpath-31/#id-maps). Acquire a map object (or array object, if appropriate) by interpreting a string using the XPath function [parse-json()](https://www.w3.org/TR/xpath-functions-31/#func-parse-json), or alternatively reading a JSON file using the [json-doc()](https://www.w3.org/TR/xpath-functions-31/#func-json-doc). The pipeline [oscal-convert/src/read-json-map.xpl](../../../projects/oscal-convert/src/read-json-map.xpl) provides an experimental surface for working this functionality.

Much more natural than using an XPath function to acquire a map object, XProc will simply read a JSON file for you, using the same `p:document` or `p:load` as used everywhere else. The processor is able to do the right thing in this case as well, namely read the file input and cast the data into an XDM map structure.

A pipeline with a simple binding to a JSON file, using `p:load` or `p:document`, is enough to demonstrate this.

### Your JSON, as XML

Map objects have the advantage of efficiency but some disadvantages for transparency. They are great for querying, but not necessarily as easy as node trees to see, write in and out (as XML), transform and debug. Because the JSON object structure reduces into a few rudiments, an XML representation of any JSON input is straightforward to produce, as long as names in XML are suitably generic as to type (like `number` and `string`, for example), and correspond to types known in JSON. A vocabulary for doing so is also well defined, quite concise and even reasonably efficient (for processing if not storage). [ This                   vocabulary](https://www.w3.org/TR/xpath-functions-31/#json-to-xml-mapping) is defined in XPath 3.0.

This XML is easy to see: all it requires is the XProc `p:cast-content-type` step with `content-type="application/xml"`, applied to your map object (JSON) input.

If your system already has such XML, you can cast it back to JSON (map or array) using the same step, with `content-type="application/json"`.

## Other content types

Important content types besides XML and JSON include `plain/text` for plain text and two types for HTML: `text/html` (for less rigorous flavors of HTML) and `application/xhtml+xml`. 

These are most important on the input side, because they provide XProc with information it needs to parse the data reliably. They are also useful to specify on outputs. Making them explicit on either input or output ports is a good practice for both documentation and error detection. The XProc Specification gives some information about [how                content type settings can be abbreviated](https://spec.xproc.org/master/head/xproc/#specified-content-types) in some circumstances.

In XProc it is useful to distinguish between content types and serializations – inasmuch as it is only the latter being, for example, that constitute something like strings of text. Content types, in contrast, are more like species of data object, albeit within or accommodated to XDM, as for example HTML content types must be. On the serialization side: XSLT or XQuery users familiar with the output methods `text`, `xml` and `html` should be able to make these work; and serialization settings when XProc writes out its content types to files are indeed guided by [applicable standards](https://www.w3.org/TR/xslt-xquery-serialization-31/)
