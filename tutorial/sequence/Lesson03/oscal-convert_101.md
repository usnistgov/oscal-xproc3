
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

This unit relies on the [oscal-convert project](../../../oscal-convert/readme.md) in this repository. Like all projects in the repo, it is designed to be self-explanatory, at least to experienced users.

Also like other projects, there are preliminaries for acquiring resources, along with pipelines to run.

## Step one: convert some OSCAL XML into OSCAL JSON

## Step two: return trip

## What could possibly go wrong?

When coping with errors, syntax errors are relatively easy. But anomalous inputs especially invalid inputs can result in lost data. The most important concern is to help detect data quality issues and see to it that no new data quality problems are introduced by a pipeline. While in comparison to syntax or configuration problems, these can be subtle, there is also good news: the very same tools we use to process inputs into outputs, can also be used to test and validate them.

Generally speaking, OSCAL maintains 'validation parity' between its XML and JSON formats with respect to their schemas. That is to say, the XSD (XML schema) covers essentially the same set of rules for XML data as the JSON Schema does for JSON data, while accounting for differences between the two notations and data models. A consequence of this is that valid OSCAL data, either XML or JSON, can reliably be converted to valid data in the other notation, while invalid data may not be converted at all, resulting in gaps or empty results.

For this and related reasons on open systems, the working principle in XML is often to formalize a model as early as possible - or adopt a model already built - in support of schema validation as a **prerequisite** and **primary requirement** for working with any data set. Validation against schemas is covered in a subsequent lesson unit (coming soon near you).

## for 102/599: XProc for JSON

map objects; steps for working with them; interim p:store as debug method

## for 102/599: YAML TODO

map objects; steps for working with them

## for 102/599: round tripping as process test
