

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [](../../..).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 401: XSLT Forward and Back

What is this XSLT?

Read this page if you are a beginner, or an expert in XSLT, or if you plan never to use it.

## Goals

* If you don't know XSLT, helps you understand what it is and what it does
* If you know XSLT, understand something more about how it fits with XProc

## Prerequisites

Possibly, you have run and inspected pipelines mentioned earlier, most especially [PRODUCE-PROJECTS-ELEMENTLIST.xpl](../../PRODUCE-PROJECTS-ELEMENTLIST.xpl), which contains `p:xslt` steps.

Possibly, you have inspected XSLT files (standalone transformations or *stylesheets*), to be found more or less anywhere in this repository, especially directories named `src`.

## Resources

XSLT links!

### XSLT 1.0 and XPath 1.0

* [XML Path  Language (XPath) Version 1.0](https://www.w3.org/TR/1999/REC-xpath-19991116/) W3C Recommendation 16 November 1999
* [XSL Transformations (XSLT) Version 1.0](https://www.w3.org/TR/xslt-10/) W3C Recommendation 16 November 1999

### XSLT 2.0 and XQuery 1.0

* [XSL Transformations (XSLT) Version 2.0 (Second Edition)](https://www.w3.org/TR/xslt20/) W3C Recommendation 30 March 2021 (Amended by W3C)
* [XQuery 1.0: An XML Query Language (Second Edition)](https://www.w3.org/TR/xquery-10/) W3C Recommendation 14 December 2010
* World Wide Web Consortium. *XQuery 1.0 and XPath 2.0 Data Model (XDM) (Second Edition)*. W3C Recommendation, 14 December 2010. See [http://www.w3.org/TR/xpath-datamodel/](https://www.w3.org/TR/xpath-datamodel/).
* World Wide Web Consortium. *XQuery 1.0 and XPath 2.0 Formal Semantics (Second Edition)*. W3C Recommendation, 14 December 2010. See [http://www.w3.org/TR/xquery-semantics/](https://www.w3.org/TR/xquery-semantics/).
* World Wide Web Consortium. *XQuery 1.0 and XPath 2.0 Functions and Operators (Second Edition)* W3C Recommendation, 14 December 2010. See [http://www.w3.org/TR/xpath-functions/](https://www.w3.org/TR/xquery-operators/).
* World Wide Web Consortium. *XSLT 2.0 and XQuery 1.0 Serialization (Second Edition)*. W3C Recommendation, 14 December 2010. See [http://www.w3.org/TR/xslt-xquery-serialization/](https://www.w3.org/TR/xslt-xquery-serialization/).

### XSLT 3.0, XQuery 3.0, XPath 3.1

* [XSL Transformations (XSLT) Version 3.0](https://www.w3.org/TR/xslt-30/) W3C Recommendation 8 June 2017
* [Normative references](https://www.w3.org/TR/xslt-30/#normative-references) for XSLT 3.0 - data model, functions and operators, etc., including **XPath 3.1**
* [XQuery 3.0: An XML Query Language](https://www.w3.org/TR/xquery-30/) W3C Recommendation 08 April 2014

## XSLT: XSL (XML Stylesheet Language) Transformations

XSLT has a long and amazing history to go with its checkered reputation. Its role in XProc is similarly ambiguous: in one sense it is an optional power feature: a nice-to-have. In another sense it can be regarded as foundational. XSLT is the reason to have XProc.

Chances are good that if you are not current on the latest XSLT version, you have little idea of what we are talking about, as it may have changed quite a bit (and even despite external appearances) since you last saw it. You may think you know it but you might have to reconsider.

Users who last used XSLT 1.0 and even 2.0, in particular, can consider their knowledge out of date until they have taken a look at XSLT 3.0.

Moreover, within the context of XProc, experienced users of XSLT should also consider it may take a different form, as it is unburdened of some operations that better belong outside it - operations such as those provided by XProc itself. Within XProc, XSLT may often be simpler than out in systems where it has to do more work.

Over time, the principle of pipelining, iterative amelioration (as it might be described) or &ldquo;licking into shape&rdquo; has been repeatedly demonstrated. Of course it proves easier to do a complicated task when broken into a series of simpler tasks. On Java alone, ways of deploying operations in sequence include at least [Apache Ant](https://ant.apache.org/), Apache Tomcat/[Cocoon](https://cocoon.apache.org/) (a web processing framework), XQuery (such as [BaseX](https://basex.org/) or [eXist-db](https://exist-db.org/exist/apps/homepage/index.html) engines) and XSLT ([Saxon](https://www.saxonica.com/documentation12/index.html#!functions/fn/transform)) to say nothing of batch scripts, shell scripts and &ldquo;transformation scenarios&rdquo; or the like, as offered by XML tools and toolkits.

All can be disturbingly haphazard. In contrast to the varied stopgap solutions, XProc helps quite a bit by taking over from XSLT, to whatever extent necessary and useful, any aspects of processing that require any sort of interaction with the wider system. This way XSLT plays to its strengths, while XProc standardizes and simplifies how it works. On one hand, XProc enables XSLT when needed, while on the other XProc may enable us largely to do without it, offering both a useful feature set and the flexibility we need, but with less overhead, especially with regard to routine chores like designating sets of inputs and outputs, or sequencing operations. The principle of Least Power may well apply here: it saves our present and our future selves effort if we can arrange and manage to do fewer things less. XProc lets us do less.

With XSLT together, this effect is magnified. XSLT lets us write less XProc, and XProc lets us write less XSLT. Together they are easier than either would be without the other to lighten the lift.

XProc lets us use XSLT when we must, but also keeps routine and simple things both simple and consistent. And it adapts itself well to new requirements as they become more complicated. Ultimately, it spares the XSLT developer the problem of having to design, build and test something like XProc.

### Reflecting on XSLT

Programmers can think of XSLT as a domain-specific language (DSL) or fourth-generation language (4GL) designed for the purpose of manipulating data structures suitable for documents and messages as well as for structured data sets. As such, XSLT is highly generalized and abstract and can be applied to a very broad range of problems. Its main distinguishing feature among similar languages (which tend to be functional languages such as Scala and Scheme) is that it is optimized for use specifically with XML-based data formats, offering well-defined handling of information sets expressed in XML, while the language itself uses XML syntax, affording nice composability, reflection and code generation capabilities. XSLT's processing model is both broadly applicable, and workable in a range of environments including client software or within encapsulated, secure software configurations and deployments.

If your XSLT is strong enough, you don't need XProc, or not much. But as a functional language, XSLT is best used in a functionally pure, &ldquo;stateless&rdquo; way that does not interact with the system: no &ldquo;side effects&rdquo;. This is related to its definitions of conformant processing (X inputs produce Y outputs) and the determinism, based in mathematical formalisms, that underlies its idea of conformance. However one cost of mathematical purity is that operations that do interact with stateful externalities – things such as reading and writing files – are not in XSLT's &ldquo;comfort zone&rdquo;. XSLT works by defining what a new structure A' should look like for any given structure A, using such terms as a conformant XSLT engine can then effectuate. But to turn an actual A into an actual A' we must first acquire A – or an effective surrogate thereof – and moreover make our A' available, in some form. XSLT leaves it up to its processor and &ldquo;calling application&rdquo; to handle this aspect of the problem – which they typically do by offering interfaces for an XSLT transformation's nominal *source* and (primary) *result*. Often, this gap has been bridged by extended functionality in processors. Does your processor read and parse XML files off the file system? Can it be connected to upstream data producers in different ways? Can it use HTTP `GET` and `PUT`? The answer may be Yes to any or all of these. Throughout its history, XSLT in later versions was also extended in this direction, with features such as the `collection()` function, `xsl:result-document`, `doc-available()` and other features we may not need if we are using XProc.

### Running XSLT without XProc

As a standard and an externally-specified technology, XSLT can in principle be implemented on any platform, but the leading XSLT implementation for some years has been Saxon, produced by Saxonica of Reading, England. Saxon has achieved market share and developer support on a record of strictly-conformant, performant applications, deployed as an open-source software product free for developers to use and integrate. (While doing this, Saxonica also has related product offerings including optimized processor for those who choose to support it.)

Download and run Saxon to apply XSLT to XML and other inputs, without XProc.

## Using XSLT in XProc: avoiding annoyances

If you are an experienced XSLT user, congratulations! The power XProc puts into your hands is everything you might think and hope.

There are a couple of small but potentially annoying considerations when embedding XSLT literals in your XProc code. They do not apply when your XSLT is called from out of line, acquired by binding to an input port or even `p:load`. If you acquire and even manipulate your XSLT without including literal XSLT code in your XProc, that eliminates the syntax-level clashes at the roots of both these problems.

### Text and attribute value syntax in embedded XSLT

XSLT practitioners know that within XSLT, in attributes and (in XSLT 3.0) within text (as directed), the curly brace signs `{` and `}` have special semantics as [attribute](https://www.w3.org/TR/xslt-30/#attribute-value-templates) or [text value templates](https://www.w3.org/TR/xslt-30/#text-value-templates). In the latter case, the operation can be controlled with an `xsl:expand-text` setting. When effective as template delimiters, these characters can be escaped and hidden from processing by doubling them: `{{` for `{` etc.

XProc offers a similar feature for expanding expressions dynamically, indicated with a `p:expand-text` setting much like XSLT's.

Because they both operate, an XSLT author must take care to provide for the correct escaping (sometimes more than one level) or settings on either language's `expand-text` option. Searching the repository for the string value `{{` (two open curlies together) will turn up instances of this – or try [a worksheet XProc with XSLT                embedded](../../worksheets/NAMESPACE_worksheet.xpl).

### Namespaces in and for your XSLT

[A lesson unit on namespaces in                   XProc](../oscal-convert/oscal-convert_350.md) may help newcomers or anyone mystified by XML namespaces. They are worth mentioning here because everything tricky in XProc regarding namespaces is doubly tricky with XSLT in the picture.

In brief: keep in mind XSLT has its own features for both configuring namespace-based matching on elements by name (such as `xpath-default-namespace`), and for managing namespaces in serialization (`exclude-namespace-prefixes`). In the XProc context, however, your XSLT will typically not be writing results directly, instead only producing the same kind of (XDM) tree as is emitted and consumed by other steps.

## Learning XSLT the safer way

If setting out to learn XSLT, pause to read the following *short* list of things to which you should give early attention, in order:


1. Namespaces in XML and XSLT: names, name prefixes, unprefixed names and the `xpath-default-namespace` setting (not available until XSLT 2.0)

1. Templates and modes in XSLT: template matching, `xsl:apply-templates`, built-in templates, and using modes to configure default behaviors when no template matches

1. XPath, especially absolute and relative location paths: start easy and work up

Understanding each of these will provide useful insights into XProc.

## XProc without XSLT?

XProc does not require XSLT absolutely, even if XSLT is indispensable for some XProc libraries, including those in this repository.

How could we do without it?

* Using XQuery any time queries get complicated
* Use XProc where possible, for example steps that support matches on patterns? E.g. `p:insert`, `p:label-elements` and `p:add-attribute`
* Reliance on iterators and `p:viewport`
* Much smarter (declarative, data-centric) HTML or other dialect in the application space?

Chances are, there is a limit. One thing XSLT does better than almost any comparable technology is support generalized or granular mappings between vocabularies.

So not only creating, but also consuming HTML, is the place we begin with XSLT. But since it is also very fine for other vocabulary mappings in the middle and back, it becomes indispensable almost as soon as it is available for use.

An XSLT that is used repeatedly can of course always be encapsulated as an XProc step.

## XProc, XDM (the XML data model) and the standards stack

Another critical consideration is whether and to what extent XProc and XSLT introduce unwanted dependencies, which make them strategically not a good choice (or not a good choice for everyone) at least in comparison to alternatives. These are standards in every way including nominally, emerging as the work of organizations such as W3C and ISO, while not escaping a reputation as &ldquo;boutique&rdquo; or &ldquo;niche&rdquo; technologies. Yet alternative models – whether offered by large software vendors and service providers, or by forests of Javascript libraries, or a bespoke stack using a developers' favorite flavor of Markdown or microformats – have not all fared very well either. Often scorned, XSLT has a reputation for projects migrating away from it as much as towards it. Yet look closely, and when problems arise, XSLT is never the issue by itself. (A project choosing not to use XSLT because of a lack of understanding or skills is something differet.) Often the question is, were you even using the right tool? It helps when your application is within the sweet spot of document processing at scale (and there is a sweet spot), but even this is not an absolute rule. Sometimes the question is, are you actually fitting the capabilities of the processing model to the problem at hand. Too often, that fit happens by accident. Too often, other considerations prevail and compromises are made - then the resulting system is blamed.

So where has XML-based processing been not only tenable but rewarding over the long term? Interestingly, its success is to be found often in projects that have survived across more than one system over time, that have grown from one system into another, and that have morphed and adapted and grown new limbs. In many cases, look at them today and you do not see the same system as you would have only five years ago.
