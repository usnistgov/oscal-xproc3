# Army Field Manual on Leadership Development, in OSCAL, via NISO STS format

The success of OSCAL is largely due to its excellent demonstration in the form of the OSCAL SP 800-53 - but other catalogs are wanting. (Possibly they exist, but are not shared.) We also want for good examples.

Army Field Manual on Leadership Development FM 6-22, a descendant of FM 22-100 and kindred documents, makes a good example - while also making a good illustration of a means and method to create well-structured XML (OSCAL) data from an uncontrolled source.

(The source in question being, of course, controlled by its authors, just uncontrolled by us. We can discern meaning but we cannot dictate it.)


FM 6-22 downloaded from
https://rdl.train.army.mil/catalog/#/search?search_terms=FM%206-22


Also see Leader Attributes from https://www.moore.army.mil/mcoe/sja/content/pdf/Leader%20Attributes.pdf


# FM6-22 to OSCAL

Project goal: demonstrate OSCAL capabilities by capturing some structured parts of US Army Field Manual 6-22, *Developing Leaders*.

Even a quick survey of this document shows a great richness and variety of structured data, currently tabulated for view but not yet queryable.

This is a pity since evidently authors went to great trouble and expense to design and enforce regular patterns, which after being used to "paint" the information, are inaccessible.

Tagging in OSCAL or any of a number of other suitable formats would be an easy way to liberate this data.

## Initial planning and survey

Thanks to MF for pointing me to this data set.

Pasted from the document:

> This publication is available at the Army Publishing Directorate (APD) site (https://armypubs.army.mil), and the Central Army Registry site (https://atiam.train.army.mil/catalog/dashboard).

An initial survey of the entire document shows high degrees of "regularity within irregularity within regularity" that characterize highly valued documents in the print era.

Rendering all this into adequately tagged XML would be a big job mainly because the mapping problem is so rich.

However large, however, this exercise would probably start at the same place, namely whatever portions of the document would most easily provide easy leverage for demonstration and data reuse, being (a) reasonably extensive (not 'toy'), (b) very regular, (c) 'semantic' (categories and relations are 'meaningful' and relatable).

A survey/scan of the entire document suggests that Chapter 4, Learning and Developmental Activities, with its extensive tables (Tables 4-6 through 4-80), meets these criteria.

It also shows that Chapter 5 is extremely interesting and challenging as well, inasmuch as it constitutes a manual for how to compose instructions in a structured form. This includes illustrations that amount to screen shots of structured text. Updating such guidelines for the present day (when orders are no longer only printed but may take other forms) is well beyond the scope of this project.
 
 
## Data sources

The PDF data source [can be downloaded from its platform](https://rdl.train.army.mil/catalog-ws/view/100.ATSC/3110F413-E915-47C1-85AA-DD4065C654C3-1274570636396/fm6_22.pdf). It is not being committed to repository.

Using Adobe Acrobat (version 24.2.21005.0), an [HTML rendition of the document]() was exported. It serves as the initial (primary) data source for extraction and mapping pipeline.

Given HTML, XProc pipelines can do the rest.

For these purposes, any commodity conversion is adequate as long as there is no data loss and all relevant document features (with respect to formatting, layout or otherwise) are captured in some form in the HTML.

Validation is achieved by comparing outputs to presumed inputs, and by replication of the pipeline logic by other means (producing the same results from the same source).


## How to run

Run the pipeline(s) named in all caps.

## What to expect

Output files will be written to your file system.

These will be HTML, Markdown or (possible even) PDF depending on the pipeline.

