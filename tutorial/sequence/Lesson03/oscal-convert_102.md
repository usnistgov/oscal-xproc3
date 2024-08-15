> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [/tutorial/source/oscal-convert/oscal-convert_102_src.html](../../../tutorial/source/oscal-convert/oscal-convert_102_src.html).
> 
> To create a persistent copy (for example, for purposes of annotation) save this file out elsewhere, and edit the copy.

# 102: Hands on data conversions

## Goals

Learn how OSCAL data can be converted between JSON and XML formats, using XProc.

Learn something about potential problems and limitations when doing this, and about how to detect, avoid, prevent or mitigate them.

Work with XProc features designed for handling JSON data (XDM **map** objects that can be cast to XML).

## Prerequisites

Run the pipelines described in [the 101
               Lesson](https://github.com/usnistgov/oscal-xproc3/discussions/18)

## Resources

Same as the [101 lesson](oscal-convert_101_src.html).

## Probing error space - data conversions

Broadly speaking, problems encountered running these conversions fall into two categories, the distinction being simple, namely whether a bad outcome is due to an error in the processor and its logic, or in the data inputs provided. The term &ldquo;error&rdquo; here hides a great deal. So does &ldquo;bad outcome&rdquo;. One type of bad outcome takes the form of failures at runtime - the term &ldquo;failure&rdquo; again leaving questions open. Other bad outcomes are not detectable at runtime. If inputs are bad (inconsistent with stated contracts such as data validation), processes can run *correctly* and deliver incorrect results: correctly representing inputs, in their incorrectness. Again, the term *correct* here is underspecified and underdefined, except in the case.

### Converting broken XML or JSON

### Converting broken OSCAL

### Converting not-OSCAL

## XProc diagnostic how-to

### Emitting runtime messages

### Saving out interim results

`p:store`

## Validate early and often

## for 599: XProc for JSON

map objects; steps for working with them; interim p:store as debug method

## for 599: YAML TODO

map objects; steps for working with them

## for 599: XProc port bindings

This is actually a .bat or .sh exercise - write a script that invokes XProc with a binding to a runtime argument

Thus, a script `convert-oscal-catalog-xml.sh mycatalog.xml` could produce `mycatalog.json` from `mycatalog.xml` etc.

Such a script could live in the project directory - do we want an Issue for this work item? 

## for 599: URIs and URI schemes

see [](https://spec.xproc.org/master/head/xproc/#err.inline.D0012) it is up to implementations to define supported URI schemes - also XML catalogs

## for 599: round tripping as process test
