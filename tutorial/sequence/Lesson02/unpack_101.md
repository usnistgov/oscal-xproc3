
> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [/tutorial/source/unpack/unpack_101_src.html](../..//tutorial/source/unpack/unpack_101_src.html).

> 
To create a persistent copy (for example, for purposes of annotation) save this file out elsewhere, and edit the copy.

# 101: Unpacking XProc 3.0



## Goals

* More familiarity with XProc 3.0: more syntax
* History, concepts and resources


## Resources

The same pipelines you ran in setup: [Setup 101](../setup/setup_101_src.html).

Also, [XProc.org dashboard page](https://xproc.org)

Also, XProc index materials produced in this repository: [XProc
               docs](../../../xproc-doc/readme.md)

## Prerequisites

Same as [Setup 101](../setup/setup_101_src.html).

## A closer look

If you have completed [Setup 102](../setup/setup_101_src.html) you have already opened and inspected the pipelines in the [lib](../../../lib/readme.md) and [smoketest](../../../smoketest/readme.md) folders.

Routine code inspection can also be done on Github as well (not a bad idea in any case), not just in a copy.

A quick summary of what these pipelines do:

* [lib/GRAB-SAXON.xpl](../../../lib/GRAB-SAXON.xpl) downloads a zip file from a [Saxonica download site](https://www.saxonica.com/download), saves it, and extracts a `jar` (Java library) file, which it places in the Morgana library directory
* [lib/GRAB-SCHXSLT.xpl](../../../lib/GRAB-SCHXSLT.xpl) downloads a zip file from Github and unzips it into a directory where Morgana can find it.
* [lib/GRAB-XSPEC.xpl](../../../lib/GRAB-XSPEC.xpl) also downloads and &ldquo;unarchives&rdquo; a zip file resource, this time a copy of [an XSpec
               distribution](https://github.com/xspec/xspec).


Essentially, these all replicate and capture the work a developer must do to identify and acquire libraries. Maintaining our dependencies this way - not quite, but almost &ldquo;by hand&rdquo;, -- appears to have benefits for system transparency and robustness.

The second group of pipelines is a bit more interesting. Each of the utilities provided for in packages just downloaded is tested by running a smoke test.

Each smoke test performs a minor task, serving as a smoke test inasmuch as its only aim is to determine whether a simple representative process completes successfully.

* [smoketest/POWER-UP.xpl](../../../smoketest/POWER-UP.xpl) amounts to an XProc &ldquo;Hello World&rdquo;. In that spirit, feel free to edit and adjust.
* [smoketest/SMOKETEST-XSLT.xpl](../../../smoketest/SMOKETEST-XSLT.xpl) tests Saxon, an XSLT/XQuery transformation engine. XSLT and XQuery are related technologies (different languages, same data model) developed with XML processing in mind, but in recent years generalized to a wider range of data structures.
* [smoketest/SMOKETEST-SCHEMATRON.xpl](../../../smoketest/SMOKETEST-SCHEMATRON.xpl) tests SchXSLT. SchXSLT is an implementation of Schematron, an ISO-standard validation and reporting technology. Schematron relies on XSLT, so this library requires Saxon.
* [smoketest/SMOKETEST-XSPEC.xpl](../../../smoketest/SMOKETEST-XSPEC.xpl) tests XSpec, an XSLT-based testing framework useful for testing deployments of XSLT, XQuery and Schematron.


All these together comprise more than can be learned in an afternoon, or even a week.

At the same time, common foundations make it possible to learn these technologies together and in tandem.

In particular, they all share a syntax for interrogating (querying) the structure of an XML document and returning its data: the XPath expression language.

## Learning about XProc

This tutorial has as handmade[XProc
               dashboard page](../../xproc-dashboard.md) with links.

Also, the official [XProc.org dashboard page](https://xproc.org).

Also, check out XProc index materials (with code snips) produced in this repository: [XProc docs](../../../xproc-doc/readme.md). Produced using XProc, these can be covered in detail in a later lesson unit.

There is [a book, Erik Siegel's XProc 3.0
                  Programmer's Reference](https://xmlpress.net/publications/xproc-3-0/) (2020).
