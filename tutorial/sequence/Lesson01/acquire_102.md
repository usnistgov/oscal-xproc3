

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [](../../..).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 102: Examining the setup

## Goals

* Look at some pipeline organization and syntax on the inside
* Success and failure invoking XProc pipelines: an early chance to &ldquo;learn to die&rdquo; gracefully (to use the gamers' idiom).

## Resources

Same as [Setup 101](acquire_101.md).

## Prerequisites

Please complete the repository setup and smoke tests as described in the [101 lesson](acquire_101.md). In this lesson, we will run these pipelines with adjustments, or similar pipelines.

This discussion assumes basic knowledge of coding, the Internet (including retrieving resources via `file` and `http` protocols), and web-based technologies including HTML.

XML knowledge is also assumed. In particular, XProc uses [XPath                3.1](https://www.w3.org/TR/xpath-31/), the query language for XML. This latest version of XPath builds on XPath 1.0, so any XPath experience will help. In general, any XSLT or XQuery experience will be invaluable.

You will also need a programmer's plain text editor, XML/XSLT editor or IDE (integrated development environment) for more interactive testing of the code.

## Step One: Inspect the pipelines

The two groupings of pipelines used in setup and testing can be considered separately.

The key to understanding both groups is to know that once the initial [Setup                script](../../../setup.sh) is run, Morgana can be invoked directly, as paths and scripts are already in place. In doing so – before extension libraries are in place – it can use only basic XProc steps, but those are enough to start with.

Specifically, the pipelines can acquire resources from the Internet, save them locally, and perform unarchiving (unzipping). Having been downloaded, each library provides software that the pipeline engine (Morgana) can use to do more.

Accordingly, the first group of pipelines (in the [lib](../../../lib/readme.md) directory has a single purpose, namely (together and separately) to download software to augment Morgana's feature set.

* [lib/GRAB-SAXON.xpl](../../../lib/GRAB-SAXON.xpl)
* [lib/GRAB-SCHXSLT.xpl](../../../lib/GRAB-SCHXSLT.xpl)
* [lib/GRAB-XSPEC.xpl](../../../lib/GRAB-XSPEC.xpl)

Pipelines in a second group work similarly in that each one exercises and tests capabilities provided by software downloaded by a member of the first group.

* [smoketest/TEST-XPROC3.xpl](../../../smoketest/TEST-XPROC3.xpl) tests MorganaXProc-III
* [smoketest/TEST-XSLT.xpl](../../../smoketest/TEST-XSLT.xpl) tests Saxon
* [smoketest/TEST-SCHEMATRON.xpl](../../../smoketest/TEST-SCHEMATRON.xpl) tests SchXSLT
* [smoketest/TEST-XSPEC.xpl](../../../smoketest/TEST-XSPEC.xpl) tests XSpec

Take a look at these files. It may be helpful (for those getting used to it) to envision the XML syntax as a set of nested frames with labels and connectors.

Try more than one way of looking at the XProc source code: in the Github repository, on your file system, in a plain text editor, in an XML editor.

## Step Two: Modify the pipelines

Use a text editor or software development application for this exercise.

If you have any concepts for improvements to the pipelines, or other resources that might be acquired this way, copy and modify one of the pipelines given to achieve those results.

Even if not: be sure to break the pipelines given – or copies under new names – in any of several ways. Then run the modified pipelines, as a *safe way* to familiarize yourself with error messages:

* Break the XML syntax of a pipeline and try to run it
* Leave XML syntax intact (well-formed), but break something in the XProc 
  * An element name, attribute or attribute setting
  * A namespace
* Try to retrieve something from a broken link

Having introduced an error, reverse the damage. Make sure your pipelines are back in working order when this exercise is complete.

## For consideration

Developers coming to this technology need to consider who would use it, and whether it is useful mainly at the back end, or also &ldquo;on the shop floor&rdquo;, directly in the hands of professionals who must work with the data, bringing expertise in subject matter (such as, for OSCAL, systems security documentation) but not in data processing as such.

Key to this question is not only whether attractive and capable user interfaces (or other mediators) can be developed (this is a known problem) but more importantly whether the systems themselves are adaptable enough so they can be deployed, used, refitted and maintained not just for repetitive generic tasks, but for *particular*, *special* and *local* problems, especially those discoverable only at the points where information is gathered and codified.

This larger fitting of solutions to problems is a responsibility for both SMEs (subject matter experts) and software developers together, who must define problems to be solved before approaches to them can be found.

The open questions are: who can use XProc pipelines; and how can they be made more useful? The questions come up in an OSCAL context or any context where XML is demonstrably capable.

Having completed and tested the setup you are ready for work with XProc: proceed to the next lesson.
