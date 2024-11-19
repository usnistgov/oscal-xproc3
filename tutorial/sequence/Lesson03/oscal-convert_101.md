

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [](../../..).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 101: OSCAL from XML to JSON and back

## Goals

Learn how OSCAL data can be converted between JSON and XML formats, using XProc.

Learn something about potential problems and limitations when doing this, and about how to detect, avoid, prevent or mitigate them.

Become familiar with the idea of generic conversions between syntaxes such as XML and JSON (not always possible), versus conversions designed to handle a single class or type of documents, such as OSCAL format conversions.

## Prerequisites

You have succeeded in prior exercises, including tools installation and setup.

## Resources

This unit relies on the [oscal-convert project](../../../projects/oscal-convert/readme.md) in this repository, with its files. Like all projects in the repo, it aims to be reasonably self-contained and self-explanatory. Use your search engine and XProc resources to learn background and terminology.

Also like other projects, there are preliminaries for acquiring resources, along with pipelines to run.

## Step zero: an identity pipeline

To verify syntactic correctness (well-formedness) - does it parse?

To transcode a file from one encoding to another

## Step zero-point-five: XML to JSON and back

XML and JSON are both *data serializations*, a term that designates how each of them is to be considered and treated – irrespective of any questions of information storage – as a *sequence of characters*. This is a very important commonality, which makes it possible to bring them together in a single processing environment such as XProc.

Along with *plain text*, perhaps the most important data serialization or &ldquo;format&rdquo; as we call them, of the three.

A simple XProc pipeline can be used to demonstrate this. While doing so, it shows also while this is not as simple a process as it seems. Merely to convert from format to format is not enough.

## Step one: convert some OSCAL XML into OSCAL JSON

[An acquisition pipeline](../../../projects/oscal-convert/GRAB-RESOURCES.xpl) in the project folder collects some OSCAL onto the local system, where it can be managed, easily inspected, controlled, and edited if necessary.

TBD / this all incoherent so far

### The playing field is the internet

Keep in mind that XProc in theory, and your XProc engine in practice, may read its inputs using whatever protocols it supports, while the `file` and `http` protocols are required for conformance, and work as they do on the Worldwide Web.

Of course, permissions must be in place to read files from system locations, or save files to them.

But when authentication is configured or resources are openly available, using `http` to reach resources or sources can be a very convenient option.

### Consider the options

TBD - TODO - question - how many and of what sort of source data files - so far there is only the cat catalog

* Converting local XML to JSON with a local XSLT
* Converting local data using a remote XSLT
* Remote data with a local XSLT, writing locally - you could try [https://github.com/GSA/fedramp-automation/blob/master/dist/content/rev5/baselines/xml/FedRAMP_rev5_LOW-baseline-resolved-profile_catalog.xml](https://github.com/GSA/fedramp-automation/blob/master/dist/content/rev5/baselines/xml/FedRAMP_rev5_LOW-baseline-resolved-profile_catalog.xml)

## Step two: return trip

Two ways: separate pipeline; and single pipeline; also a 'switcher' pipeline?

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

When coping with errors, syntax errors are relatively easy. But anomalous inputs, especially invalid inputs, can result in lost data. (A common reason data is not valid even when it appears to be is that it has foreign unknown contents, or contents out of place - the kinds of things that might fail to be converted.) The most important concern when engineering a pipeline is to see to it that no data quality problems are introduced inadvertantly. While in comparison to syntax or configuration problems, data quality issues can be subtle, there is also good news: the very same tools we use to process inputs into outputs, can also be used to test and validate data to both applicable standards and local rules.

Generally speaking, OSCAL maintains &ldquo;validation parity&rdquo; between its XML and JSON formats with respect to their schemas. That is to say, the XSD (XML schema) covers essentially the same set of rules for OSCAL XML data as the JSON Schema does for OSCAL JSON data, accounting for differences between the two notations, the data models and how information is mapped into them. A consequence of this is that valid OSCAL data, either XML or JSON, can reliably be converted to valid data in the other notation, while invalid data may not be converted at all, resulting in gaps or empty results.

For this and related reasons on open systems, the working principle in XML is often to formalize a model (typically by writing and deploying a schema) as early as possible - or adopt a model already built - as a way to institute and enforce schema validation as a **prerequisite** and **primary requirement** for working with any data set. Validation against schemas is covered in a subsequent lesson unit (coming soon near you).

### Intercepting errors

One way to manage the problem of ensuring input quality is to validate on the way in, either as a dependent (prerequisite) process, or built into a pipeline. Whatever you want to do with invalid inputs, including ignoring them and producing warnings or runtime exceptions, can be defined in a pipeline much like anything else.

In the [publishing demonstration                   project folder](../../../projects/oscal-publish/publish-oscal-catalog.xpl) is an XProc that valides XML against an OSCAL schema, before formatting it. The same could be done for an XProc that converts the data into JSON - either or both before or after conversion.

Learn more about recognizing and dealing with errors in [Lesson 102](oscal-convert_102.md), or continue on to the next project, oscal-validate, for more on validation of documents and sets of documents.
