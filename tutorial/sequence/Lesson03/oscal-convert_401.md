

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [../../../source/oscal-convert/oscal-convert_401_src.html](../../../source/oscal-convert/oscal-convert_401_src.html).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 401: XProc, XML, JSON and content types

## Goals

Understand a little more about JSON and other data formats in an XML processing environment.

## Resources

A [content-types worksheet XProc](../../worksheets/CONTENT-TYPE_worksheet.xpl) is offered for trying out content-type options on XProc inputs and outputs.

The pipeline [READ-JSON-TESTING.xpl](../../worksheets/READ-JSON-TESTING.xpl) provides an experimental surface for working functionality specifically related to JSON and XDM map objects.

## Exercise some options

The worksheets just cited provide an opportunity to try out `content-type` configuration options. Note how you can specify a content type that will serve as a constraint on inputs and outputs, analogous in some ways to the type signature on a function. And the step `p:content-type` serves to cast one content type to another, according to [rules                given in the Specification](https://spec.xproc.org/3.0/steps/#c.cast-content-type). Note that for this step to work, both inputs and outputs must conform to certain requirements: not everything can be cast!

* Try specifying a `content-type` on input or outputs to constrain the inputs or outputs, producing errors for mismatches
* Try using a [p:cast-content-type](https://spec.xproc.org/3.0/steps/#c.cast-content-type) step to convert between content types.
* Use the function `p:document-properties(.,'content-type')` to bring back the content type of a document on a port or in a pipeline. In XPath, `.` refers to an designated as the (dynamic) processing context: so `p:document-properties($doc,'content-type')` works for any $doc considered by XProc to be or serve as a *document*.
* Interestingly, this means we can expect to find `content-type="application/json"` whenever an XProc document is nothing more than an object or map – as can happen, by design.

[READ-JSON-TESTING.xpl](../../worksheets/READ-JSON-TESTING.xpl) is a sandbox for playing with JSON objects as XDM maps. The [content-types                worksheet](../../worksheets/CONTENT-TYPE_worksheet.xpl) is set up for trying content-type options on inputs and outputs.
