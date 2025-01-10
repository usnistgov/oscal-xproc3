

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [../../source/oscal-convert/oscal-convert_401_src.html](../../source/oscal-convert/oscal-convert_401_src.html).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 401: XProc, XML, JSON and content types

## Goals

Understand a little more about JSON and other data formats in an XML processing environment.

## Resources

A [content-types worksheet XProc](../../worksheets/CONTENT-TYPE_worksheet.xpl) is offered for trying out content-type options on XProc inputs and outputs.

The pipeline [READ-JSON-TESTING.xpl](../../worksheets/READ-JSON-TESTING.xpl) provides an experimental surface for working functionality specifically related to JSON and XDM map objects.

## Content types and document properties

XProc considers its *documents* to be objects, with properties. One of these properties is the nominal `content-type`. We say &ldquo;nominal&rdquo; here because it is always possible to misname something. Whether a document is actually the content type described, or can be made into it according to a well defined and unambiguous rendering, is another problem. Fortunately for XProc users, this is a problem for their engines to solve, since XProc provides rules regarding when and how such errors can be detected – or how they can be defined such that instead of errors, we get sensible fallback behaviors that we can treat as rules or at least rules of thumb.

Partly this is a problem since of course a content type is actually a feature or property of a binary object of some kind, which is to say in the XProc view, a *resource* – something it can read or write. Documents are and have *representations* of this binary data - when one is easily obtainable (via a standard parse). A tree of nodes, for example is what XProc sees in an XML or HTML document, not a file containing text with tags.

Accordingly, along with XProc's idea of a *content type* is its idea of a *serialization specification*. Indeed, decoupling these two properties offers tremendous flexibility to users of pipelines, since some serialization formats &ldquo;belong&rdquo; (implicitly) to certain document or content types, while this is also a one-to-many relation. For example, many different XML-based formats can all be treated with the same content-type and the same choice of serialization options for XML.

Both these properties are given on documents throughout a pipeline, but they can change along the way, either because they are reset explicitly (a `p:set-properties` step is offered for this) or because an operation or step has changed the document such that one or both of these settings have also been changed. Consequently their handling can, for the most part, be left to processors, trusting that errors will be returned if a processor is asked to do things that exceed capabilities.

Among other things, this permits specific steps and embedded pipelines to declare content types for inputs and outputs, and throw errors when contracts (as declared in step definitions) are violated. Not only does this make it possible to define and build better, more robust pipeline steps with better exception handling; but also it means that content types and serialization options can be explicitly stated and controlled when necessary, without the details of syntax ever becoming a focus.

## Exercise some options

The worksheets just cited provide an opportunity to try out `content-type` configuration options. Note how you can specify a content type that will serve as a constraint on inputs and outputs, analogous in some ways to the type signature on a function. And the step `p:content-type` serves to cast one content type to another, according to [rules                given in the Specification](https://spec.xproc.org/3.0/steps/#c.cast-content-type). Note that for this step to work, both inputs and outputs must conform to certain requirements: not everything can be cast!

* Try specifying a `content-type` on input or outputs to constrain the inputs or outputs, producing errors for mismatches
* Try using a [p:cast-content-type](https://spec.xproc.org/3.0/steps/#c.cast-content-type) step to convert between content types.
* Use the function `p:document-properties(.,'content-type')` to bring back the content type of a document on a port or in a pipeline. In XPath, `.` refers to an designated as the (dynamic) processing context: so `p:document-properties($doc,'content-type')` works for any $doc considered by XProc to be or serve as a *document*.
* Interestingly, this means we can expect to find `content-type="application/json"` whenever an XProc document is nothing more than an object or map – as can happen, by design.

[READ-JSON-TESTING.xpl](../../worksheets/READ-JSON-TESTING.xpl) is a sandbox for playing with JSON objects as XDM maps. The [content-types                worksheet](../../worksheets/CONTENT-TYPE_worksheet.xpl) is set up for trying content-type options on inputs and outputs.
