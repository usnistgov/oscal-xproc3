
> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [/tutorial/source/oscal-convert/oscal-convert_101_src.html](../..//tutorial/source/oscal-convert/oscal-convert_101_src.html).

> 
To create a persistent copy (for example, for purposes of annotation) save this file out elsewhere, and edit the copy.

# 101: OSCAL from XML to JSON and back

## Goals

Learn how OSCAL data can be converted between JSON and XML formats, using XProc.

Learn something about potential problems and limitations when doing this, and about how to detect, avoid, prevent or mitigate them.

Work with XProc features designed for handling JSON data (XDM **map** objects that can be cast to XML).

## Prerequisites

You have succeeded in prior exercises, including tools installation and setup.

## Resources

This unit relies on the [oscal-convert project](../../../oscal-convert/readme.md) in this repository. Like all projects in the repo, it is designed to be self-contained and self-explanatory to the extent practical. Use your search engine and XProc resources to learn background and terminology.

Also like other projects, there are preliminaries for acquiring resources, along with pipelines to run.

## Step one: convert some OSCAL XML into OSCAL JSON

[An acquisition pipeline](../../../oscal-convert/GRAB-RESOURCES.xpl) in the project folder collects some OSCAL onto the local system, where it can be managed, easily inspected, controlled, and edited if necessary.

But sources and results from a conversion process do not always have to work with local resources. XProc sees the Internet itself - whatever protocols are supported by the processor (the `file` and `http` protocols are required for conformance) work as they do on the Worldwide Web. Of course, permissions must be in place to read and write files from and into file system locations. But when authentication is configured or resources are openly available, using `http` to reach resources or sources can be a very convenient option.

TBD - TODO - question - how many and of what sort of source data files - so far there is only the cat catalog

* Converting local XML to JSON with a local XSLT
* Converting local data using a remote XSLT
* Remote data with a local XSLT, writing locally - [](https://github.com/GSA/fedramp-automation/blob/master/dist/content/rev5/baselines/xml/FedRAMP_rev5_LOW-baseline-resolved-profile_catalog.xml)


## Step two: return trip

Two ways: separate pipeline; and single pipeline; also a 'switcher' pipeline?

## What is this XSLT?

If your criticism of XProc so far is that it makes it look easy when it isn't, you have a point. Conversion from XML to JSON isn't free, assuming it works at all. In this case, the heavy lifting is done by the XSLT component - the Saxon engine invoked by the `p:xslt` step, applying logic defined in an XSLT stylesheet (aka transformation) stored elsewhere. It happens that a converter for OSCAL data is available in XSLT, so rather than having to confront this considerable problem ourselves, we drop that in.

In later units we will see how using the XProc steps described, rudimentary data manipulations can be done using XProc by itself, without entailing the use of either XSLT or XQuery (another capability invoked with a different step). At the same time, while pipelines are based on the idea of passing data through a series of processes, there are many cases where logic is sufficiently complex that it becomes essential to maintain ??? and test ??? that logic externally from the XProc. At what point it becomes more efficient to encapsulate logic separately (whether by XSLT, XQuery or other means), depends very much on the case.

The `p:xslt` pipeline step in particular is so important for real-world uses of XProc that it is introduced early, to show such black-box application. XProc also makes a fine environment for testing XSLT developed or acquired to handle specific tasks, a topic covered in more depth later. Indeed XSLT and XQuery being, like XProc itself, declarative languages, it makes sense to factor them out while maintaining easy access and transparency for analysis and auditing purposes.

## What could possibly go wrong?

When coping with errors, syntax errors are relatively easy. But anomalous inputs, especially invalid inputs, can result in lost data. (A common reason data is not valid even when it appears to be is that it has foreign unknown contents, or contents out of place - the kinds of things that might fail to be converted.) The most important concern when engineering a pipeline is to see to it that no data quality problems are introduced inadvertantly. While in comparison to syntax or configuration problems, data quality issues can be subtle, there is also good news: the very same tools we use to process inputs into outputs, can also be used to test and validate data to both applicable standards and local rules.

Generally speaking, OSCAL maintains &ldquo;validation parity&rdquo; between its XML and JSON formats with respect to their schemas. That is to say, the XSD (XML schema) covers essentially the same set of rules for OSCAL XML data as the JSON Schema does for OSCAL JSON data, accounting for differences between the two notations, the data models and how information is mapped into them. A consequence of this is that valid OSCAL data, either XML or JSON, can reliably be converted to valid data in the other notation, while invalid data may not be converted at all, resulting in gaps or empty results.

For this and related reasons on open systems, the working principle in XML is often to formalize a model (to write and deploy a schema) as early as possible - or adopt a model already built - as a way to institute and enforce schema validation as a **prerequisite** and **primary requirement** for working with any data set. Validation against schemas is covered in a subsequent lesson unit (coming soon near you).

### Intercepting errors

One way to manage the problem of ensuring input quality is to validate on the way in, either as a dependent (prerequisite) process, or built into a pipeline. Whatever you want to do with invalid inputs, including ignoring them and producing warnings or runtime exceptions, can be defined in a pipeline much like anything else.

In the [publishing demonstration project
                  folder](../../../oscal-publish/publish-oscal-catalog.xpl) is an XProc that valides XML against an OSCAL schema, before formatting it. The same could be done for an XProc that converts the data into JSON - either or both before or after conversion.

## for 102/599: XProc for JSON

map objects; steps for working with them; interim p:store as debug method

## for 102/599: YAML TODO

map objects; steps for working with them

## for 102/599: XProc port bindings

This is actually a .bat or .sh exercise - write a script that invokes XProc with a binding to a runtime argument

Thus, a script `convert-oscal-catalog-xml.sh mycatalog.xml` could produce `mycatalog.json` from `mycatalog.xml` etc.

Such a script could live in the project directory - do we want an Issue for this work item? 

## for 102/599: URIs and URI schemes

see [](https://spec.xproc.org/master/head/xproc/#err.inline.D0012) it is up to implementations to define supported URI schemes - also XML catalogs

## for 102/599: round tripping as process test
