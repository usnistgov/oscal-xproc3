

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [](../../..).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 101: Unpacking XProc 3.0

## Goals

* More familiarity with XProc 3.0, including some syntax
* Some awareness of XProc's capabilities, along with context including background history, concepts and resources

If you read only a single page from this tutorial, and you know nothing about XProc, this page could offer the most rapid introduction.

But a further goal is to stimulate a reader's curiosity along with their awareness.

## Prerequisites

**No prerequisites.** The commentary assumes, however:

* You have run the acquisition, setup and test pipelines [described in the first lesson set](../acquire/acquire_101.md), or you are willing to pretend you have done so for our purposes here
* You have some prior experience with either XML technologies, web publishing technologies, data modeling and data exchange, or (again) you are open to learning or at least thinking about it

If you fall into neither of these categories – welcome, and congratulations on your perseverence at least. These pages are certainly available to be read and referenced even if you are not running any of the software: as part of the resource provided (the repository as a whole), they are open to anyone who finds them to be useful, including for specialized purposes.

So you are also welcome to read what follows if this is your first look at XProc, or if you are not after the runtime, only the ideas, or if you have some other use in mind (such as perhaps testing an XProc engine?).

If you fall into this category, however, you should also (one last time!) consider running some of the code after all. You might be surprised at how easy and not-so-scary it really is.

## Resources

This lesson discusses, in more depth, the same pipelines you ran in setup: [Setup 101](../acquire/acquire_101.md), in particular [the smoke test pipelines](../../../smoketest/readme.md).

Also, this lesson discusses a pipeline used for producing this tutorial: [PRODUCE-PROJECTS-ELEMENTLIST.xpl](../../PRODUCE-PROJECTS-ELEMENTLIST.xpl) generates an [index to XProc in this repository](../../sequence/element-directory.md). It is offered as a first demonstration (among other things) of XProc applied to XProc.

### For reference

The [XProc.org 3.0 dashboard page](https://xproc.org) is maintained by XProc community organizers. It offers a hub for reference materials and community contributions.

The last section of this lesson unit describes more reference materials as well.

## A closer look

If you have completed [Acquire 102](../acquire/acquire_101.md) you have already inspected the [lib](../../../lib/readme.md) and [smoketest](../../../smoketest/readme.md) folders, and run the pipelines you have found there. If you haven't, now is a moment to catch up. Even if you have decided not to install any software, please look at the pipelines we are using for the purpose here.

Routine code inspection can also be done [on Github](https://github.com/usnistgov/oscal-xproc3) as well (not a bad idea in any case), not just in a copy of the distribution. If you are reading this in the repository, the pipelines files (generally, suffixed `xpl` by convention) can be inspected in another browser window.

A quick summary of what these pipelines do:

* [lib/GRAB-SAXON.xpl](../../../lib/GRAB-SAXON.xpl) downloads a zip file from a [Saxonica download site](https://www.saxonica.com/download), saves it, and extracts a `jar` (Java library) file, which it places in the Morgana library directory
* [lib/GRAB-SCHXSLT.xpl](../../../lib/GRAB-SCHXSLT.xpl) downloads a zip file from Github and unzips it into a directory where Morgana can find it.
* [lib/GRAB-XSPEC.xpl](../../../lib/GRAB-XSPEC.xpl) also downloads and &ldquo;unarchives&rdquo; a zip file resource, this time a copy of [an XSpec                distribution](https://github.com/xspec/xspec).

Essentially, these all replicate and capture the work a developer must do to identify and acquire libraries. Maintaining our dependencies this way - not quite, but almost &ldquo;by hand&rdquo; -- appears to have benefits for system transparency and robustness.

The second group of pipelines is a bit more interesting. Each of the utilities provided for in packages just downloaded is tested by running a **smoke test**.

Each smoke test performs a minor task, with the aim of determining whether a simple representative process will complete successfully. (When we plug the unit in and switch on the power, can we see and smell smoke? Do tracebacks burn your retinas?)

* [smoketest/TEST-XPROC3.xpl](../../../smoketest/TEST-XPROC3.xpl) amounts to an XProc &ldquo;Hello World&rdquo;. In that spirit, feel free to write your own version. (You get another chance to do this [real soon now](walkthrough_102.md).)
* [smoketest/TEST-XSLT.xpl](../../../smoketest/TEST-XSLT.xpl) tests Saxon, an XSLT/XQuery transformation engine. XSLT and XQuery are related technologies (different languages, same data model) developed with XML processing in mind, but in recent years generalized to a wider range of data structures.
* [smoketest/TEST-SCHEMATRON.xpl](../../../smoketest/TEST-SCHEMATRON.xpl) tests SchXSLT. SchXSLT is an implementation of Schematron, an ISO-standard validation and reporting technology. As this implementation relies on XSLT, this library also requires Saxon.
* [smoketest/TEST-XSPEC.xpl](../../../smoketest/TEST-XSPEC.xpl) tests XSpec, an XSLT-based testing framework useful for testing deployments of XSLT, XQuery and Schematron.

Any and each of these can be used as a &ldquo;black box&rdquo; by any competent operator, even without understanding the internals. But this simplicity masks and manages complexity. XProc is XProc but its capabilities are limited without XSLT, XQuery, Schematron, XSpec and others, an open-ended set of compatible and complimentary technologies.

At the same time, common foundations make it possible to learn these technologies together and in tandem.

## Survey

Each of the test pipelines exercises a simple sequence of operations. Open any XProc file in an editor or viewer where you can see the tags. Skim this section to get only a high-level view.

The aim here is demystification. Understand the parts to understand the whole. Reading the element names also inscribes them in memory circuits where they can be recovered.

### TEST-XPROC3

Examine the pipeline [TEST-XPROC3.xpl](../../../smoketest/TEST-XPROC3.xpl). It breaks down as follows:

* `p:output` – An *output port* is defined. It specifies that when the process results are delivered, a couple of serialization rules are followed: the text is indented and written without an XML declaration at the top. With this port, the process outputs can be captured by the calling process (such as your script), or simply echoed to the console.
* `p:identity` – An *identity step* does nothing with its input but simply passes it along. This one is a little different from usual in that its inputs are given as literal (XML) contents in the pipeline. Essentially, because this pipeline has this step, it does not need to load or rely on any inputs, because its inputs are given here. The input is a single line of XML.
* `p:namespace-delete` – A *namespace-delete* step is used to strip an XML namespace definition from the document bound to the identity step. This XML inherits namespaces from the pipeline itself, but it has no elements or attributes that use it, so the namespace is unneeded and its declaration comes through as noise. With this step the pipeline results are clean and simple.

When you run this pipeline, the `CONGRATULATIONS` document given in line will be echoed to the console, where designated outputs will appear if not otherwise directed.

### TEST-XSLT

[This pipeline](../../../smoketest/TEST-XSLT.xpl) executes a simple XSLT transformation, in order to test that XSLT transformations can be successfully executed.

* `p:output` – An output port is designated with `p:output` as in the [TEST-XPROC3 pipeline](../../../smoketest/TEST-XPROC3.xpl).
* `p:xslt` – Instead of providing a literal document in an *identity* step, this pipeline performs an XSLT transformation. The input to this transformation is given as a literal XML in the same way, except this time it is provided as input to a transformation process defined by an [XSLT stylesheet](../../../smoketest/src/congratulations.xsl) called in by the pipeline.
* `p:namespace-delete` – The `ox` namespace is stripped from the result as in [TEST-XPROC3 pipeline](../../../smoketest/TEST-XPROC3.xpl). This could have been done in the XSLT as well, but this way the transformation has one less thing to do or go wrong. More simpler steps prove more legible and tractable than fewer complicated ones.

Like the [TEST-XPROC3 pipeline](../../../smoketest/TEST-XPROC3.xpl) this pipeline shows its results in the console. This time the result is not just the XML given in the pipeline, but that XML as modified by the transformation.

If your pipeline execution can't process the XSLT (perhaps Saxon is not installed, or the XSLT itself has a problem) you will get an error saying so.

Errors in XProc are reported by the Morgana engine using XML syntax. Among other things, this means they can be captured and processed in pipelines.

### TEST-SCHEMATRON

Schematron is a language used to specify rules to apply to XML documents. In this case a small Schematron is applied to a small XML.

* `p:output` – An output port is designated for the results with the same settings.
* `p:validate-with-schematron` – This is an XProc step specifically for evaluating an XML document against the rules of a given Schematron. Like the TEST-XPROC3 and TEST-XSLT` pipelines, this one presents its own input, given as a literal XML document given in the pipeline document (using `p:inline`). A setting on this step provides for it to throw an error if the document does not conform to the rules. The Schematron file provided as input to this step, [src/doing-well.sch](../../../smoketest/src/doing-well.sch), gives the rules. This flexible technology enables easy testing of XML against rule sets defined either for particular cases in particular workflows, or for entire classes or sets of documents.
* `p:namespace-delete` – This step is used here as in the other tests for final cleanup of the information produced.

### TEST-XSPEC

[XSpec](https://github.com/xspec/xspec) is a testing framework for XSLT, XQuery and Schematron. It takes the form of a vocabulary and a process (inevitably implemented in XSLT and XQuery) for executing queries, transformations, and validations, by running them over known inputs, comparing the results to expected results, and reporting the results of this comparison. XProc, built to orchestrate manipulations of XML contents, is well suited for running XSpec.

An XSpec instance (or &ldquo;document&rdquo;) defines a set of tests for a transformation or query module using the XSpec vocabulary. An XSpec implementation executes the tests and delivers the results. Since XSpec, like Schematron, reports its findings in XML, XProc can be useful both to manage the inputs and outputs, and to process the XSpec reports.

* `p:import` – calls to an external XProc file to make its step definitions available.
* `p:input` – works as it does elsewhere, to declare inputs for the pipeline. In this case, the inputs must be XSpec documents using the XSpec vocabulary. You can expect errors when they are not. This testing pipeline offers three different XSpecs to be run, one each for XSLT, XQuery and Schematron.
* `p:for-each` – defines a step or sequence of steps to be applied to each input, separately.
* `p:identity` – simply passes through the previous step's result. While this is a &ldquo;no-op&rdquo; in the XProc itself, it provides an occasion for a message to help trace the XProc execution.

[The next lesson](walkthrough_102.md) offers more detail about this pipeline.

## A not-so-simple pipeline

**tl/dr** - examine the Markdown file presenting an [XProc                Element directory](../../sequence/element-directory.md). It is generated by [a             pipeline](../../PRODUCE-PROJECTS-ELEMENTLIST.xpl). Examine that pipeline to see XProc with real-world complexity.

The simple pipelines examined so far show how useful things can be done simply, while the pipeline architecture allows for great flexibility.

Simplicity and flexibility together enable complexity. Once it is factored out, a complex operation can be managed and deployed just like a simple one, with its internal complexities masked by a simple and predictable interface.

Next, take a look at a more complex example, the prototype pipeline [PRODUCE-PROJECTS-ELEMENTLIST.xpl](../../PRODUCE-PROJECTS-ELEMENTLIST.xpl). Like the setup and smoke-test pipelines, this is a standalone pipeline (requiring no runtime bindings or settings): when this plan (&ldquo;step&rdquo; or pipeline) is executed, the processor will acquires inputs, produce results and write those results to the file system. The output it generates is stored as [element-directory.md](../../sequence/element-directory.md), a Markdown file (find the `p:store` step).

The result is a reference resource encoded in Markdown: an index of XProc elements used in pipelines in this repository. As Markdown, this result can be reposted back into the repository or viewed with any Markdown viewing application. The index lists XProc elements, that is the core of the XProc vocabulary: for any XProc element used anywhere among the projects listed, the listing shows the pipelines where it appears. Following the index, the resource also shows a list of (repository) project folders in a prescribed order, with their XProc files and whatever XProc elements appear *first* (within the entire sequence up to to point) within that file. Among other uses this is helpful for assessing coverage of tutorial lessons as it offers a (semi) *ordered* survey of the elements.

For example, looking up `p:store` you can see all the pipelines that contain this common step. Or looking at the `oscal-convert` listing you can see the XProc steps appearing first in that project folder.

To confirm proper functioning, run the pipeline again after deleting or renaming the Markdown result file.

Consider also what other kinds of indexing might be useful. When you modify XProc or add new XProc pipelines to the project folders, consider running this pipeline again to update the indexes.

Open the file and inspect it to get a sense of how it works. The XML syntax is verbose, but not really all that frightening. Practice helps! The pipeline is also considered in the [102 Lesson unit](walkthrough_102.md) segment.

### PRODUCE-PROJECTS-ELEMENTLIST

The pipeline [PRODUCE-PROJECTS-ELEMENTLIST.xpl](../../PRODUCE-PROJECTS-ELEMENTLIST.xpl) contains XML comments (`<!-- using comment syntax -->`) that should help explain its operations.

There are some significant differences between this pipeline and the small ones we have looked at so far.

* Of course, it is longer and more complex, reflecting the complexity of the operations it performs.
* Part of the complexity is due to a two-step process here. First, the file system is surveyed in locations named in an input configuration. Then all those resources (which happen to be XML using the XProc vocabulary) are indexed against the files in which they occur. The two listings are both produced in this second analytical phase, showing how once the files are surveyed, more than one analysis is possible.
* In particular, the index to &ldquo;first use&rdquo; is not simple. A great deal of the complexity of detailed operations has been off-loaded into XSLT transformation code, which in this pipeline can be seen embedded in the XProc, indeed occupying the greater part of the XML in the file. (About two thirds of the element count: you can usually recognize XSLT by the conventional `xsl:` element prefix.) This pipeline also has an XSLT called from an external file (toward the end). XProc can provide XSLT either way, and each has its advantages.
* One good thing about seeing the XSLT here is you can get a good sense of what it looks like, whether embedded or kept externally. XSLT is [not                      essential to XProc](walkthrough_401.md), but it very much expands its practical capabilities.

## XML syntax, XPath and XProc

Newcomers to XML may feel they are in the deep water with XML syntax.

In the context of XProc, this is actually not as hard as it looks:

* All XML files follow the same syntax rules with respect to tags, elements and attributes (names and syntax), namespaces, comments etc.

```
<tagged attribute="value">Information goes here</tagged>
<!-- comment goes here --> 
```

* XML vocabularies are typically qualified with **namespaces** to show, and to disambiguate, which XML application or language they belong to. The namespaces are indicated by name *prefixes*. So in this repository (and conventionally for XProc), any element prefixed `p:` is an XProc element, and another prefix or none indicates an extension or another vocabulary, such as appears in XML being processed.

```
<p:output port="result" serialization="map{'indent' : true(), 'omit-xml-declaration': true() }" />
```

* Embedded in the syntax is another syntax, *XPath*. This lightweight but powerful query language is a formal subset of XQuery. XPath is ubiquitous in XProc, XSLT, Schematron, XSpec etc. In XProc, the XPath will ordinarily be given in attributes.

```
<p:output port="result" serialization="**map{'indent' : true(), 'omit-xml-declaration': true() }**" />
```

* Learn more about this in the [102 Lesson unit](walkthrough_102.md) – or plunge on, and pick up what you need as you go.

## Learning more about XProc

This tutorial has a handmade [XProc links page](../../xproc-links.md) with links.

Also, see the official [XProc.org dashboard page](https://xproc.org).

Also, check out indexing logic offered in the [xproc-doc                project folder](../../../projects/xproc-doc/readme.md). It has pipelines producing useful indexes to XProc in this repository and in general, including one producing an [index to XProc                simple steps](../../../projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl) in HTML, with code snips.

There is [a book, Erik Siegel's XProc 3.0                   Programmer's Reference](https://xmlpress.net/publications/xproc-3-0/) (2020) and an [excellent                reference site](https://xprocref.org/index.html) by the same author.
