101 - Unpacking XProc 3.0
# 101 - Unpacking XProc 3.0



## Goals

 * More familiarity with XProc 3.0: more syntax
 * History, concepts and resources
 

## Resources

The same pipelines you ran in setup: [Setup 101](../setup/setup_101_src.html).

Also, [XProc.org dashboard page](https://xproc.org)

Also, XProc index materials produced in this repository: [XProc
               docs](../../../xproc-doc/readme.md)

## Prerequisites
Same as [Setup 101](setup_101_src.html).

## A closer look

If you have completed [Setup 102](../setup/setup_101_src.html) you have already opened and inspected the pipelines in the [lib]() and [smoketest]() folders.

Routine code inspection can also be done on Github as well (not a bad idea in any case) not just in a copy.

A quick summary of what these pipelines do:

 * [lib/GRAB-SAXON.xpl](../../lib/GRAB-SAXON.xpl)
 * [lib/GRAB-SCHXSLT.xpl](../../lib/GRAB-SCHXSLT.xpl)
 * [lib/GRAB-XSPEC.xpl](../../lib/GRAB-XSPEC.xpl)
 

The second group of pipelines is a bit more interesting. Each of the utilities provided for in packages just downloaded is tested by running a smoke test.

Each smoke test performs a minor task, serving as a smoke test inasmuch as its only aim is to determine whether a simple and robust process completes successfully.

 * [smoketest/SMOKETEST-XSLT.xpl](../../smoketest/SMOKETEST-XSLT.xpl) tests Saxon, an XSLT/XQuery transformation engine. XSLT and XQuery are related technologies (different languages, same data model) developed with XML processing in mind, but in recent years generalized to a wider range of data structures.
 * [smoketest/SMOKETEST-SCHEMATRON.xpl](../../smoketest/SMOKETEST-SCHEMATRON.xpl) tests SchXSLT. SchXSLT is an implementation of Schematron, an ISO-standard validation and reporting technology. Schematron relies on XSLT, so this library requires Saxon.
 * [smoketest/SMOKETEST-XSPEC.xpl](../../smoketest/SMOKETEST-XSPEC.xpl) tests XSpec, an XSLT-based testing framework useful for testing deployments of XSLT, XQuery and Schematron.
 

All these together comprise more than can be learned in an afternoon, or even a week.

At the same time, common foundations make it possible to learn these technologies together and in tandem.

In particular, they all share a syntax for interrogating (querying) the structure of an XML document and returning its data: the XPath expression language.

## Learning about XProc
