

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [](../../..).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 101: Converting OSCAL – XML to JSON and JSON to XML

## Goals

Learn how OSCAL data can be converted between JSON and XML formats, using XProc.

Learn something about potential problems and limitations when doing this, and about how they can be detected and avoided, prevented or mitigated.

Become familiar with the idea of generic conversions between syntaxes such as XML and JSON, versus conversions capable of handling a single class or type of documents, such as OSCAL – a limitation that can also provide, in a case such as OSCAL, for a fully defined mapping supporting lossless, error-free translation across syntaxes.

## Prerequisites

Having succeeded in prior exercises, including tools installation and setup, you are ready to run pipelines.

## Resources

This unit relies on the [oscal-convert project](../../../projects/oscal-convert/readme.md) in this repository, with its files. Like all projects in the repo, it aims to be reasonably self-contained and self-explanatory. The pipelines there (described below) provide rudimentary support for data conversions, demonstrating simplicity and scalability.

As always, use your search engine and XProc resources to learn background and terminology.

## Pipeline rundown

The XProc pipelines don't do much, as they are wired up to work with minimalistic demonstration data sets. This keeps them plain, simple and obvious in exposition, while at the same time it should be apparent how they can be readily reconfigured or customized to work on any suitable inputs that may be provided.

The idea here is simple: run the pipeline and observe its behaviors, including not only the messages it emits to the console window, but also the file outputs it generates. Each pipeline should be provided with inline comments describing its workings. Also see the [next lesson unit](oscal-convert_102.md) for more details.

### [GRAB-RESOURCES](../../../projects/oscal-convert/GRAB-RESOURCES.xpl)

Like other pipelines with this name, run this to acquire resources. In this case, XSLTs used by other XProc steps are downloaded from the OSCAL release page.

### [BATCH-JSON-TO-XML](../../../projects/oscal-convert/BATCH_JSON-TO-XML.xpl)

This pipeline uses an XProc input port to include a set of JSON documents, which it translates into XML using [generic semantics defined                   in XPath](https://www.w3.org/TR/xpath-functions-31/#json-to-xml-mapping). For each JSON file input, an equivalent XML file with the same filename base is produced, in the same place.

As posted, the pipeline reads some minimalistic fictional data, which can be found in the system at the designated paths.

It then uses a pipeline step defined in an imported pipeline, which casts the data and stores the result for each JSON file input. In the XProc source, the imported step can be easily identified by its namespace prefix, different from the prefix given to XProc elements, as designated by the pipeline's developer or sponsor.

Follow the `p:import` link (via its `href` file reference) to find the step that is imported. An imported step is invoked by using its `type` name, given at the top of the XML (as is described in more depth [in a subsequent                   lesson unit](oscal-convert_201.md)).

### [BATCH-XML-TO-JSON](../../../projects/oscal-convert/BATCH_XML-TO-JSON.xpl)

This pipeline performs the inverse of the JSON-to-XML batch pipeline. It loads XML files and converts them into JSON.

Note however how in this case, no guarantees can be made that any XML inputs will result in valid JSON. Unless using the correct vocabulary, XML inputs will result in errors, as no comprehensive, rules-bound cast can be defined across its variations. To alleviate this problem, exception handling logic in the form of an XProc `p:try/p:catch` can be found in the imported pipeline step (which performs the casting).

Additionally, this variant has a fail-safe (look for `p:choose`) that prevents the production of JSON from files not named `*.xml` – strictly speaking, this is only a naming convention, but respecting it prevents unseen and unwanted name collisions. It does *not* defend against overwriting any other files that happen to be in place with the target name.

### [CONVERT-OSCAL-XML-DATA](../../../projects/oscal-convert/CONVERT-OSCAL-XML-DATA.xpl)

The requirement that any XML to be converted must already be JSON-ready by virtue of conforming to a JSON-descriptive vocabulary, is obviously an onerous one. To achieve a clean, complete and appropriate recasting and relabeling of data, depending on its intended semantics, depends on those semantics being defined in a way capable of a JSON expression.

OSCAL solves this problem by defining its XML and JSON formats in parity, such that a complete bidirectional conversion can be guaranteed over data sets already schema-valid. The bidirectional conversions themselves can be performed implicitly or overtly by tools that read and write OSCAL, or they can be deployed as XSLT transformations, providing for the conversion to be performed by any XSLT 3.0 engine.

For XSLT 3.0, XProc has Saxon. The XSLTs in question can be acquired from an OSCAL release, as shown in the [GRAB-RESOURCES](../../../projects/oscal-convert/GRAB-RESOURCES.xpl) pipeline.

[CONVERT-OSCAL-XML-DATA](../../../projects/oscal-convert/CONVERT-OSCAL-XML-DATA.xpl) applies one of these XSLTS to a set of given OSCAL XML files, valid to the catalog model, to produce JSON. It works on any XML file that has `catalog` as its root element, in the OSCAL namespace. It does *not* provide for validation of the input against the schema: Instead, the garbage-in/garbage-out (GIGO) principle is respected. This means that some pipelines will run successfully while producing defective outputs, which must be discovered in the result (via formal validation and other checks). An XProc pipeline with a validation step preceding the conversion would present such errors earlier.

The reverse pipeline is left as an exercise. Bring valid OSCAL JSON back into XML. Let us know if you have prototyped this and wish for someone to check your work!

### [CONVERT-OSCAL-XML-FOLDER](../../../projects/oscal-convert/CONVERT-OSCAL-XML-FOLDER.xpl)

This pipeline performs the same conversion as [CONVERT-OSCAL-XML-DATA](../../../projects/oscal-convert/CONVERT-OSCAL-XML-DATA.xpl) with an important distinction: instead of designating its sources, it processes all XML files in a designated directory.

## Working concept: return trip

Note in this context that comparing the inputs and results of a round-trip conversion is an excellent way of determining, to some base level, the correctness and validity of your data set. While converting it twice cannot guarantee that anything in your data is &ldquo;true&rdquo;, if having converted XML to JSON and back again to XML, the result looks the same as the original, you can be sure that your information is &ldquo;correctly represented&rdquo; in both formats.

Here's an idea: a single pipeline that would accept either XML or JSON inputs, and produce either, or both, as outputs. Would that be useful?

## What is this XSLT?

If your criticism of XProc so far is that it makes it look easy when it isn't, you have a point.

Conversion from XML to JSON isn't free, assuming it works at all. The runtime might be effectively free, but developing it isn't.

Here, the heavy lifting is done by the XSLT component - the Saxon engine invoked by the `p:xslt` step, applying logic defined in an XSLT stylesheet (aka **transformation**) stored elsewhere. It happens that a converter for OSCAL data is available in XSLT, so rather than having to confront this considerable problem ourselves, we drop in the solution we have at hand.

In later units we will see how using the XProc steps described, rudimentary data manipulations can be done using XProc by itself, without entailing the use of either XSLT or XQuery.

At the same time, while pipelines are based on the idea of passing data through a series of processes, there are many cases where logic is sufficiently complex that it becomes essential to maintain – and test – that logic externally from the XProc. At what point it becomes more efficient to encapsulate logic separately (whether by XSLT, XQuery or other means), depends very much on the case.

The `p:xslt` pipeline step in particular is so important for real-world uses of XProc that it is introduced early, to show such a black-box application. There is also an [XQuery](https://spec.xproc.org/3.0/steps/#c.xquery) step – for many purposes, functionally equivalent.

XProc also makes a fine environment for testing XSLT developed or acquired to handle specific tasks – and it can support automated testing and test-driven development using [XSpec](https://github.com/xspec/xspec/wiki).

Indeed XSLT and XQuery being, like XProc itself, declarative languages, it makes sense to factor them out while maintaining easy access and transparency for analysis and auditing purposes.

## What could possibly go wrong?

Three things can happen when we run a pipeline:

* The pipeline can fail to run, typically terminating with an error message (or, unusually, failing to terminate)
* The pipeline can run successfully, but result in incorrect outputs given the inputs
* The pipeline can run successfully and correctly

Among the range of possible errors, those that show up in your console with error messages are the easy ones. This will typically be a syntax error or error in usage (providing the wrong kind of input, etc.), remediable by a developer. Sometimes it is an input resource, not the pipeline, that must be corrected, or a different pipeline developed for the different input. If XML is expected but not provided, a conforming processor must emit an error. Correct it or plan on processing plain text.

The second category is much harder. The most important concern when engineering a pipeline is to see to it that no data quality problems are introduced inadvertantly. Anomalous inputs might process &ldquo;correctly&rdquo; (for the input provided) but result in lost data or disordered results. Often this is obvious in testing, but not always. The key is defining and working within a scope of application (range of inputs) within which &ldquo;correctness&rdquo; can be specified, unambiguously and demonstrably, both with respect to the source data, and the processing requirement. Given such a specification, testing is possible. While in comparison to syntax or configuration problems, data quality issues can be subtle, there is also good news: the very same tools we use to process inputs into outputs, can also be used to test and validate data to both applicable standards and local rules.

Generally speaking, OSCAL maintains &ldquo;validation parity&rdquo; between its XML and JSON formats with respect to their schemas. That is to say, the XSD (XML schema) covers essentially the same set of rules for OSCAL XML data as the JSON Schema does for OSCAL JSON data, accounting for differences between the two notations, the data models and how information is mapped into them. A consequence of this is that valid OSCAL data, either XML or JSON, can reliably be converted to valid data in the other notation, while invalid data may come through with significant gaps, or not be converted at all.

For this reason (as it applies to OSCAL) and related reasons on open systems (applying across the board, and not only to data conversions), the working principle in XML is often to define and formalize a model as early as possible – or identify and adopt a model already built – as a way to institute and enforce schema validation as a *prerequisite* and *primary requirement* for working with any data set. We do this by acquiring or writing and deploying schemas. To this end, XProc supports several kinds of schema validation including [XML DTD (Document Type Definition)](https://spec.xproc.org/lastcall-2024-08/head/validation/#c.validate-with-dtd), [XSD (W3C                Schema Definition language)](https://spec.xproc.org/lastcall-2024-08/head/validation/#c.validate-with-xml-schema), [RelaxNG (ISO                ISO/IEC 19757-2)](https://spec.xproc.org/lastcall-2024-08/head/validation/#c.validate-with-relax-ng), [Schematron](https://spec.xproc.org/lastcall-2024-08/head/validation/#c.validate-with-schematron) and [JSON                Schema](https://spec.xproc.org/lastcall-2024-08/head/validation/#c.validate-with-json-schema), making it straightforward to enforce this dependency at any point in a pipeline, whether applied to inputs or to pipeline results including interim results and pipeline outputs. Resource validation is described further in subsequent coverage including the next [Maker lesson unit](oscal-convert_102.md).

### The playing field is the Internet

File resources in XProc are designated and distinguished by URIs. Keep in mind that XProc in theory, and your XProc engine in practice, may read its inputs using whatever [URI schemes](https://www.iana.org/assignments/uri-schemes/uri-schemes.xhtml) it supports, while the schemes `file` and `http` (or `https`) are required for conformance, and work as they do on the Worldwide Web.

Of course, permissions must be in place to read files from system locations, or save files to them. When authentication is configured or resources are openly available, using `http` to reach resources or sources can be a very convenient option.

While this is important and powerful, it comes with complications. Internet access is not always a given, making such runtime dependencies fragile. XML systems that rely on URIs frequently also support one or another kind of URI indirection, such as [OASIS XML Catalogs](https://www.oasis-open.org/committees/entity/spec-2001-08-06.html), to enable resource management, redirection and local caching of standard resources. For the XProc developer, this can be a silent source of bugs, hard to find and hard to duplicate and analyze. The [next lesson unit](oscal-convert_102.md) describes some functions that can be used to provide the transparency needed.

## More catalogs needed!

As we go to press we have only one example OSCAL catalog to use for this exercise.

Other valid OSCAL catalogs are produced from other projects in this repo, specifically [CPRT import](../../../projects/CPRT-import/) and [FM6-22-IMPORT](../../../projects/FM6-22-import/). Run the pipelines in those projects to produce more catalogs (in XML) useful as inputs here.
