

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [](../../..).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 101: Converting OSCAL – XML to JSON and JSON to XML

## Goals

Learn how OSCAL data can be converted between JSON and XML formats, using XProc.

Learn something about potential problems and limitations when doing this, and about how they can be detected, avoided, prevented or mitigated.

Become familiar with the idea of generic conversions between syntaxes such as XML and JSON (not always possible), versus conversions capable of handling a single class or type of documents, such as OSCAL format conversions.

## Prerequisites

You have succeeded in prior exercises, including tools installation and setup, and ready to run pipelines.

## Resources

This unit relies on the [oscal-convert project](../../../projects/oscal-convert/readme.md) in this repository, with its files. Like all projects in the repo, it aims to be reasonably self-contained and self-explanatory. The pipelines there (described below) provide rudimentary support for data conversions &ldquo;in miniature&rdquo; – infrastructures that might scale up.

As always, use your search engine and XProc resources to learn background and terminology.

## Pipeline rundown

The XProc pipelines don't do much, as they are wired up to work with minimalistic demonstration data sets. This keeps them plain, simple and obvious in exposition, while at the same time it should be apparent how they can be readily reconfigured or customized to work on any suitable inputs that may be provided.

The idea here is simple: run the pipeline and observe its behaviors, including not only the messages it emits to the console window, but also the file outputs it generates. Each pipeline should be provided with inline comments describing its workings. Also see the [next lesson unit](oscal-convert_102.md) for more details.

### [GRAB-RESOURCES](../../../projects/oscal-convert/GRAB-RESOURCES.xpl)

Like other pipelines with this name, run this to acquire resources. In this case, XSLTs used by other XProc steps are downloaded from their release page.

### [BATCH-JSON-TO-XML](../../../projects/oscal-convert/BATCH_JSON-TO-XML.xpl)

This pipeline uses an input port to include a set of JSON documents, which it translates into XML using [generic semantics defined in                   XPath](https://www.w3.org/TR/xpath-functions-31/#json-to-xml-mapping). For each JSON file input, an equivalent XML file with the same filename base is produced, in the same place.

As posted, the pipeline reads some minimalistic fictional data, which can be found in the system at the designated paths.

It then uses a pipeline step defined in an imported pipeline, which casts the data and stores the result for each JSON file input. In the XProc source, the imported step can be easily identified by its namespace prefix, different from the prefix given to XProc elements – and what is more important, under the nominal control of its developer or sponsor.

Follow the `p:import` link (via its `href` file reference) to find the step that is imported. Recognize a step by its `type` given at the top of the XML (as is described in more depth [in a subsequent lesson unit](oscal-convert_201.md))

### [BATCH-XML-TO-JSON](../../../projects/oscal-convert/BATCH_XML-TO-JSON.xpl)

This pipeline performs the inverse of the JSON-to-XML batch pipeline. It loads XML files and converts them into JSON.

Note however how in this case, no guarantees can be made that any XML inputs will result in valid JSON. Many XML inputs will result in errors instead since only the XML vocabulary supporting JSON is considered well enough described for a comprehensive, rules-bound cast. Exception handling logic in the form of an XProc `p:try/p:catch` can be found in the imported pipeline step (which performs the casting).

Additionally, this variant has a fail-safe (looks for `p:choose`) that prevents the production of JSON from files not named `*.xml` – strictly speaking, this is only a naming convention, but respecting it prevents unseen and unwanted name collisions. It does *not* defend against overwriting any other files that happen to be in place with the target name.

### [CONVERT-OSCAL-XML-DATA](../../../projects/oscal-convert/CONVERT-OSCAL-XML-DATA.xpl)

The requirement that any XML to be converted must already be JSON-ready by virtue of conforming to a JSON-descriptive vocabulary, is obviously an onerous one. To achieve a clean, complete and appropriate recasting and relabeling of data, depending on its intended semantics, is .

OSCAL solves this problem by defining its XML and JSON formats in parity, such that a complete bidirectional conversion can be guaranteed over data sets already schema-valid. The bidirectional conversions themselves can be performed implicitly or overtly by tools that read and write OSCAL, or they can be deployed as XSLT transformations, providing for the conversion to be performed by any XSLT engine, in principle (that supports the required version of the language).

XProc has Saxon for its XSLT, so it falls into the latter category. The XSLTs in question can be acquired from an OSCAL release, as shown in the [GRAB-RESOURCES](../../../projects/oscal-convert/GRAB-RESOURCES.xpl) pipeline.

This pipeline applies one of these XSLTS to a set of given OSCAL XML files, valid to the catalog model, to produce JSON.

It works on any XML file that has `catalog` as its root element, in the OSCAL namespace. It does *not* provide for validation of the input against the schema, which is might, as a defense. Instead, the garbage-in/garbage-out (GIGO) principle is respected. If the process breaks, currently this must be discovered in the result.

The reverse pipeline is left as an exercise. Bring valid OSCAL JSON back into XML. Let us know if you have prototyped this and wish for someone to check your work!

### [CONVERT-OSCAL-XML-FOLDER](../../../projects/oscal-convert/CONVERT-OSCAL-XML-FOLDER.xpl)

This pipeline performs the same conversion as [CONVERT-OSCAL-XML-DATA](../../../projects/oscal-convert/CONVERT-OSCAL-XML-DATA.xpl) with an important distinction: instead of designating its sources, it processes all XML files in a designated directory. 

## The playing field is the internet

Keep in mind that XProc in theory, and your XProc engine in practice, may read its inputs using whatever protocols it supports, while the `file` and `http` protocols are required for conformance, and work as they do on the Worldwide Web.

Of course, permissions must be in place to read files from system locations, or save files to them.

But when authentication is configured or resources are openly available, using `http` to reach resources or sources can be a very convenient option.

## More catalogs needed!

As we go to press we have only one example OSCAL catalog to use for this exercise.

Other valid OSCAL catalogs are produced from other projects in this repo, specifically [CPRT import](../../../projects/CPRT-import/) and [FM6-22-IMPORT](../../../projects/FM6-22-import/). Run the pipelines in those projects to produce more catalogs (in XML) useful as inputs here.

## Working concept: return trip

Here's an idea: a single pipeline that would accept either XML or JSON inputs, and produce both as outputs. Would that be useful?

Note in this context that comparing the inputs and results of a round-trip conversion is an excellent way of determining, to some base level, the correctness and validity of your data set – as an encoded representation of *something* (expressed in OSCAL), even if not a truthful representation of *anything* (whether expressible in OSCAL or not).

## What is this XSLT?

If your criticism of XProc so far is that it makes it look easy when it isn't, you have a point.

Conversion from XML to JSON isn't free, assuming it works at all.

In this case, the heavy lifting is done by the XSLT component - the Saxon engine invoked by the `p:xslt` step, applying logic defined in an XSLT stylesheet (aka transformation) stored elsewhere. It happens that a converter for OSCAL data is available in XSLT, so rather than having to confront this considerable problem ourselves, we drop in the solution we have at hand.

In later units we will see how using the XProc steps described, rudimentary data manipulations can be done using XProc by itself, without entailing the use of either XSLT or XQuery (another capability invoked with a different step).

At the same time, while pipelines are based on the idea of passing data through a series of processes, there are many cases where logic is sufficiently complex that it becomes essential to maintain – and test – that logic externally from the XProc. At what point it becomes more efficient to encapsulate logic separately (whether by XSLT, XQuery or other means), depends very much on the case.

The `p:xslt` pipeline step in particular is so important for real-world uses of XProc that it is introduced early, to show such a black-box application.

XProc also makes a fine environment for testing XSLT developed or acquired to handle specific tasks, a topic covered in more depth later.

Indeed XSLT and XQuery being, like XProc itself, declarative languages, it makes sense to factor them out while maintaining easy access and transparency for analysis and auditing purposes.

## What could possibly go wrong?

Among the range of possible errors, syntax errors are relatively easy to cope with. But anomalous inputs, especially invalid inputs, can result in lost data. (A common reason data sets fail validation is the presence of foreign unknown contents, or contents out of place - the kinds of things that might fail to be converted.) The most important concern when engineering a pipeline is to see to it that no data quality problems are introduced inadvertantly. While in comparison to syntax or configuration problems, data quality issues can be subtle, there is also good news: the very same tools we use to process inputs into outputs, can also be used to test and validate data to both applicable standards and local rules.

Generally speaking, OSCAL maintains &ldquo;validation parity&rdquo; between its XML and JSON formats with respect to their schemas. That is to say, the XSD (XML schema) covers essentially the same set of rules for OSCAL XML data as the JSON Schema does for OSCAL JSON data, accounting for differences between the two notations, the data models and how information is mapped into them. A consequence of this is that valid OSCAL data, either XML or JSON, can reliably be converted to valid data in the other notation, while invalid data may come through with significant gaps, or not be converted at all.

For this and related reasons on open systems, the working principle in XML is often to formalize a model (typically by writing and deploying a schema) as early as possible - or adopt a model already built - as a way to institute and enforce schema validation as a **prerequisite** and **primary requirement** for working with any data set. Validation against schemas is also supported by XProc, making it still easier to enforce this dependency.

### Intercepting errors

One way to manage the problem of ensuring input quality is to validate on the way in, either as a dependent (prerequisite) process, or built into a pipeline. Whatever you want to do with invalid inputs, including ignoring them and producing warnings or runtime exceptions, can be defined in a pipeline much like anything else.

In the [publishing demonstration                   project folder](../../../projects/oscal-publish/publish-oscal-catalog.xpl) is an XProc that valides XML against an OSCAL schema, before formatting it. The same could be done for an XProc that converts the data into JSON - either or both before or after conversion.

Learn more about recognizing and dealing with errors in [Lesson 102](oscal-convert_102.md), or continue on to the next project, oscal-validate, for more on validation of documents and sets of documents.
