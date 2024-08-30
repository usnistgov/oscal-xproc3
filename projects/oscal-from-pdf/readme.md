

# OSCAL from PDF

In this project we acquire PDF documents and cast them into OSCAL.

Note that most such documents might be as efficiently tagged by hand as corrected by any other means. The goal here is not, however, only to produce an OSCAL version of a given document or information set, but to show how the information may be cast using a method, and producing results, that are *traceable*, *replicable* and *validable*.

## Army Field Manual FM 6-22 on Leadership Development, in OSCAL, via NISO STS format

Project goal: demonstrate OSCAL capabilities by capturing a well-structured and well-described representation of US Army Field Manual 6-22, *Developing Leaders*.

Possibly, the success of OSCAL is partly due to its excellent demonstration in the form of the OSCAL SP 800-53. But if only for demonstration and to test design in deployment, other catalogs are wanting. (Possibly they exist, but are not shared.) We also want for good examples.

Army Field Manual on Leadership Development FM 6-22, a descendant of FM 22-100 and kindred documents, makes such an example - while also making a good illustration of a means and method to create well-structured XML (OSCAL) data from an uncontrolled source.

*The source in question being, of course, controlled by its authors, just uncontrolled by us. We can discern meaning but we cannot dictate it.*

FM 6-22 can be downloaded from
https://rdl.train.army.mil/catalog/#/search?search_terms=FM%206-22

Also see Leader Attributes from https://www.moore.army.mil/mcoe/sja/content/pdf/Leader%20Attributes.pdf

Even a quick survey of this document shows a great richness and variety of structured data, currently enumerated and tabulated for view (mostly) but not yet queryable.

This is a pity since evidently authors went to great trouble and expense to design and enforce regular patterns, which after being used to "paint" the information, are inaccessible and ineffectual.

Tagging in OSCAL or any of a number of other suitable formats would be an easy way to liberate this data.

Thanks to MF for pointing me to this data set.

Pasted from the document:

> This publication is available at the Army Publishing Directorate (APD) site (https://armypubs.army.mil), and the Central Army Registry site (https://atiam.train.army.mil/catalog/dashboard).

### Why OSCAL

The Field Manual, while a distinctive work with many special and bespoke characteristics, is also *aspiring* to be OSCAL.

The surest sign of this is the series of patterns and structural regularities throughout the document and especially in Chapter 4 - sure indications (as noted explicitly) of "intent" in their organization and composition. What this document describes as *leader requirements*, *attributes* and *capabilities* become controls in OSCAL.

However, if Chapter 4 is a control catalog, the next question is, what is a profile.

As a selection of controls, a profile of FM 6-22 is indeed the "self-cultivation" checklist it describes in paragraph 4-1 and elsewhere, which describes how it is intended "to help individuals identify and prioritize which leader requirements to target for growth" - i.e. a leader requirements *selection* is to be made.

In other words - read the docs. Constructing an OSCAL profile to leverage this catalog remains a tbd.

### From PDF to HTML - to NISO STS - to OSCAL

Not all PDF is created equal. And multiple ways to produce HTML or other legible forms from PDF sources exist, with varying results.

Since these tools will change, we don't recommend any, but suggest trying a range and choosing, or choosing based on some other criterion.

For FM 6-22 we converted the PDF published from US Army sites into HTML using Adobe Acrobat (as noted below), mainly because it serves as a de facto reference implementation for PDF handling, and hence can be expected to produce results without data loss.

Two steps follow:

1. Porting the HTML to NISO STS format, while ameliorating its errors, inefficiencies and obfuscations.
1. Porting high-quality STS to OSCAL for consumption by OSCAL tools

Both these steps can be done using XProc 3.0.

#### HTML to NISO STS

A sequence of transformations reproduces the data set with NISO STS (Standards Tag Suite) markup, with markup errors corrected.

- (Re)structuring where the HTML is flat or broken
- Improving fidelity and consisteny of representation by:
  - Repairing broken callout boxes
  - Consolidating partial/broken tables into tables
  - Grouping bulleted items into lists

Etc. Details can be traced in the [XProc pipeline file extract-FM6_22-chapter4.xpl](extract-FM6_22-chapter4.xpl).

The result is Chapter 4 *only* in a correct and harmonious STS encoding.

As currently configured (still in development) this pipeline writes results - intermediate as well as final - to the [temp](temp) directory.

In particular, the file [temp/t05_sts-corrected.xml](temp/t05_sts-corrected.xml) in that directory (produced by the pipeline) is valid NIST STS XML.

View this file using NISO STS Tools such as the [NISO STS Viewer](https://pages.nist.gov/xslt-blender/sts-viewer/).

NISO STS makes a good intermediate model for this enhancement, as it

- Presents a comprehensive, retrospective encoding of the document as received, stabilizing a semantic representation, without entanglement in the next task, namely mapping this (or any) semantically adequate representation into OSCAL
- Can be inspected, tested and validated on the way through, including with bespoke validation, STS display tools and other methods
- Produces a useful spin-off artifact (the STS instance itself)

With a clean STS representation of the document in hand, casting into OSCAL will be straightforward.

The main advantages of this stepwise process are in transparencey and traceability, duplicability, and debuggability.


#### NISO STS to OSCAL

TODO: this is where we pause ...

OSCAL will be free-form text (with links) followed by a control sequence

The XProc to perform this conversion is *TBD*

keep section sequence replacing tables with links to control structures - competency/attribute/component
          
drill all the way to part[@class='item'] with line items
        create control structures for tables 4-6 - 4-80
        
Retain tables 1-5 as plain-old tables
          break numbered sections out into parts
          separate out a formal part for capabilities / indicators

### Initial planning and survey

An initial survey of the entire document shows high degrees of "regularity within irregularity within regularity" that characterize highly valued documents in the print era.

Rendering all this into adequately tagged XML would be a big job mainly because the mapping problem is so rich.

However large, however, this exercise would probably start at the same place, namely whatever portions of the document would most easily provide easy leverage for demonstration and data reuse, being (a) non-trivial in extensiveness (so not easily taggable by hand), (b) very regular, and (c) 'semantic' (categories and relations are 'meaningful' and relatable).

A survey/scan of the entire document suggests that Chapter 4, *Learning and Developmental Activities*, with its extensive tables (especially Tables 4-6 through 4-80), meets these criteria.

It also shows that Chapters 3 and 5 are extremely interesting and challenging as well, inasmuch as they constitute a manuals for how to compose instructions in a structured (written) form. This includes illustrations that amount to screen shots of structured text. Updating such guidelines for the present day (when orders are no longer only printed but may take other forms) is well beyond the scope of this project.

## Data sources

The PDF data source [can be downloaded from its platform](https://rdl.train.army.mil/catalog-ws/view/100.ATSC/3110F413-E915-47C1-85AA-DD4065C654C3-1274570636396/fm6_22.pdf). It is not being committed to repository.

Using Adobe Acrobat (version 24.2.21005.0), an [HTML rendition of the document](source/export/fm6_22.html) was exported. It serves as the initial (primary) data source for extraction and mapping pipeline.

Given HTML, XProc pipelines can do the rest.

For these purposes, any commodity conversion is adequate as long as there is no data loss and all relevant document features (with respect to formatting, layout or otherwise) are captured in some form in the HTML.

Validation is achieved by comparing outputs to presumed inputs, and by replication of the pipeline logic by other means (producing the same results from the same source).


## How to run

Run the pipeline(s) named in all caps.

## What to expect

Output files will be written to your file system.

These will be HTML, Markdown or (possible even) PDF depending on the pipeline.

