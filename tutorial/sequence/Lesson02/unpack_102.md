102: XProc fundamentals
# 102: XProc fundamentals



## Goals

 * More familiarity with XProc 3.0: more syntax
 * History, concepts and resources
 

## Resources

The same pipelines you ran in setup: [Setup 101](../setup/setup_101_src.html).

This tutorial's handmade[XProc dashboard](../../xproc-dashboard.md) with links

Also, the official [XProc.org dashboard page](https://xproc.org)

Also, check out XProc index materials produced in this repository: [XProc docs](../../../xproc-doc/readme.md)

## Prerequisites
Same as [Setup 101](setup_101_src.html).

## Learning about XProc

## Architecture of an XProc pipeline

### XProc files and XProc steps

The *step* is the core conceptual unit of XProc. An XProc processing pipeline is composed of steps. But a pipeline is also considered as a step in itself.

In other words, steps in XProc are *compositional*. They are building block assemblies made out of smaller building block assemblies. A step is a way to process data. A pipeline is a way of orchestrating and arranging such processes.

Thus it is also normal when working with XProc to distinguish between pipelines and steps. It is a relative distinction, but important. The pipeline is the logical and actual definition of how your data is to be processed. Every pipeline is composed of an arrangement, often a series, of such definitions. The definitions - the steps - include "primitives", and are designed for generality and reusability. This saves work, focuses optimization, and makes it possible to scale up to address data processing requirement sets that are both large and complex.

Accommodating this design, an XProc *file* considered as an XML instance is either of two things: a *step declaration*, or a collection of such declarations, a *library*.

Additionally, step declarations can include their own subpipeline (step) declarations, as a hybrid: declaring a step, with its own library.

An example of a step library in this repository is [xpec-execute.xpl](../../../xspec/xspec-execute.xpl), which collects several steps supporting XSpec, one each for supporting test suites for XSLT, XQuery and Schematron respectively.

Most other pipelines arestep declarations. Recognize a step declaration by the element, `p:declare-step` (in the XProc namespace) and a library by the element `p:library`.

### XProc step header and body

### Atomic and compound steps

### Namespaces and extension steps

### Schema for XProc 3.0

(for 599?)

## Take note

### Where are these downloads coming from?

These pipelines use different strategies for resource acquisition, depending on the case, and on where and in what form the resource is available. (Sometimes a file on Github is downloaded "raw", sometimes an archive is downloaded and opened, and so on.) For now, it is not necessary to understand details in every case, only to observe the variation and range. (With more ideas welcome. Could XProc be used to build a "secure downloader"?)

Wherever you see `href` attributes, take note.

Since `href` is how XProc "sees" the world, either to read data in or to write data out, this attribute is a reliable indicator of an assumed feature, often a dependency of some kind. For example, a download will not succeed if the resource indicated by the `href` for the download returns an error, or nothing. `href` attribute settings therefore become *points of control* for interaction between an XProc pipeline, and its runtime environment.

Useful detail: where XProc has `p:store href="some-uri.file"`, the `href` is read by the processor as the intended location for storage of pipeline data, that is, for a *write* operation. In other cases `href` is always an argument for a *read* operation.

### Syntax tips

XProc uses XPath syntax, in which a syntax such as `$foo` (a name with a `$` prefixed) indicates a **variable reference**. XProc also uses a *value expansion syntax* (either*text* or *attribute* value syntax) using curly braces - so syntax such as `href="{$some-xml-uri}"` is not uncommon. Depending on use, this would mean "read [or write] to the URI given by `$some-xml-uri`".

An XProc developer always knows where `href` is used in a pipeline, and how to test for and update their use. As always with syntax, the easiest way to learn about it is to try making changes and observing outcomes.
