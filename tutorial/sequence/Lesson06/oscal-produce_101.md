> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [/tutorial/source/oscal-produce/oscal-produce_101_src.html](../../../tutorial/source/oscal-produce/oscal-produce_101_src.html).
> 
> To create a persistent copy (for example, for purposes of annotation) save this file out elsewhere, and edit the copy.

# 101: Producing OSCAL from a publication format

## Goals

Learn how high-quality XML can be produced from uncontrolled source data, in this case an HTML file (web page) produced by a commodity tool (Adobe Acrobat) from a publicly-available PDF document. The example document is US Army Field Manual (FM) 6-22, edition of 2022: **Developing Leaders**. Its Chapter 4 in particular offers a well-structured data set rich in what is called &ldquo;semantics&rdquo; - while that term is not here defined - or at least arguably shows a vivid instance of how electronic forms of expression (XML, markup) can make it possible to translate semantics, however defined, into applications.

Observe how a deterministic data processing framework can be tuned or programmed to resolve anomalies in &ldquo;bad inputs&rdquo; (but not so bad), producing a well-formatted, cleanly encoded edition at a higher level of quality and capability, using a traceable and verifiable process.

Along the way, learn something about XProc, XSLT transformations, XML, NISO STS format (a standard encoding for supporting publication in electronic formats), OSCAL, US Army field manuals and documentation, and the focus of FM 6-22: Leadership and leadership development.

## Prerequisites

You have succeeded in prior exercises, including tools installation and setup.

You are familiar with NIST SP 800-53, rev. 5, the publication that provides the model and requirements set for this application, in its [final PDF
            revision](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf).

## Resources

This unit relies on the [oscal-publish project](../../../projects/oscal-publish/readme.md) in this repository, with its files. Like other projects this one may have installation or setup pipelines to run.

Additionally if you have your own OSCAL to bring, especially OSCAL catalogs, bring them along.

[SP  800-53 rev 5
               (PDF)](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf) is an essential reference.

## Step one: acquire resources

As usual, the project contains pipelines to be used to acquire copies of resources, placing them in the project lib directory . These may include dependencies for steps in the pipeline (read details in the [102 lesson](oscal-produce_102_src.html)) so it is a good idea to run them all.

These include a pipeline that copies the PDF original from which the HTML input (next step) was derived, using a COTS (commercial off-the-shelf) tool. Inspect and read this PDF to see what the upstream data looks like - and get a sense of what the data set looks like when the structures are &ldquo;painted&rdquo; on the page.

The extraction and mapping focuses on Chapter 4 only of this document. Learn more about FM 6-22, *Developing Leaders* in [the project
            readme](../../../projects/oscal-from-pdf/readme.md).

## Step two (to skip): produce HTML

For this exercise, we have already produced HTML from the PDF source: find it cached as an [input file in the project folder](../../../projects/oscal-from-pdf/source/export/fm6_22.html). Next to it is [a copy with whitespace
               added for legibility](../../../projects/oscal-from-pdf/source/export/fm6_22_e.html), which may be easier to inspect.

*Do not delete, replace, rename or alter this file*, as all the subsequent processing is tuned specifically to it, its internal organization and regularities and anomalies. Another process input - even an HTML file showing the &ldquo;same text&rdquo; - is highly unlikely to deliver acceptable results from the pipeline. This is an important factor to keep in mind when considering the scalability of the exercise here. It does not require less expertise than producing the original document (in some respects it requires more).

For some data sets, however, and especially if the exercise can also be used advantageously in other ways - that is, beyond its considerabl eimpacts on the availability and utility of the information - even a bespoke transformation pipeline such as this can be useful. This occurs mainly when the source document is of such high quality and consisteny instrinsically, that exposing its semantics via a rational and explicable text encoding - a standards-based, platform- and application-independent encoding - such as OSCAL - becomes attractive for the *leverage* it gives over the information. In FM 6-22 Chapter 4, we have exactly such a document, which fits well into standards-based documentary formats such as NISO STS and, eventually, OSCAL.

Because PDF is relatively opaque, extracting data from a PDF file with format intact is not a trivial exercise. Even tools designed, sold and supported by the proprietors of PDF format (Adobe, Inc.) are able at best to create outputs that *appear* to present the document with its organization and information intact, if rendered on screen with an appropriate tool (in the case of HTML, a web browser). In so doing it may meet a low baseline of functional requirement - the document is legible - while failing to meet others, and in particular the requirements we have for clean and well-structured data fit for reuse in a broad range of scenarios and applications, not only page production.

Indeed this HTML file makes an excellent example of the kind of rather-poor encoding produced by a market-leading HTML export utility. Experts in data conversion might find other ways to make better encoding from the PDF - a task out of scope for us. (As we are not trying to optimize but only to demonstrate the methods applied.) This HTML is good enough, and that is what is often available.

The pipeline to be run in the next step starts by loading [source/export/fm6_22.html](../../../projects/oscal-from-pdf/source/export/fm6_22.html) - do not rename, move or alter this file, or expect errors!

## Step three: run the pipeline

## Step four (optional): run the pipeline in diagnostic mode
