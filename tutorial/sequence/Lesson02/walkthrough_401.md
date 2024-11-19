

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [](../../..).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 401 - XSLT Forward and Back

What is this XSLT?

Read this page if you are a beginner, or an expert in XSLT, or if you plan never to use it.

## Goals

* If you don't know XSLT, helps you understand what it is and what it does
* If you know XSLT, understand something more about how it fits with XProc

## Prerequisites

You have run and inspected pipelines mentioned earlier, most especially [PRODUCE-PROJECTS-ELEMENTLIST.xpl](../../PRODUCE-PROJECTS-ELEMENTLIST.xpl), which contains `p:xslt` steps.

You have inspected XSLT files (standalone transformations or *stylesheets*), to be found more or less anywhere in this repository, especially directories named `src`.

## Resources

XSLT links!

### XSLT 1.0 and XPath 1.0

### XSLT 2.0 and XQuery 1.0

### XSLT 3.0, XQuery 3.0, XPath 3.1

## XSLT: XSL (XML Stylesheet Language) Transformations

XSLT has a long and checkered reputation and a history that may be even more amazing.

Chances are good that if you are not current on the latest version of this technology, you have little idea of what we are talking about, as it may have changed quite a bit (and even despite external appearances) since you last saw it.

Users who last used XSLT 1.0 and even 2.0, in particular, can consider their knowledge out of date until they have taken a look at XSLT 3.0.

Programmers can think of XSLT as a domain-specific language (DSL) or fourth-generation language (4GL) designed for the purpose of manipulating data structures suitable for documents and messages as well as for structured data sets. As such, XSLT is highly generalized and abstract and can be applied to a very broad range of problems. Its main distinguishing feature among similar languages (which tend to be functional languages such as Scala and Scheme) is that it is optimized for use specifically with XML-based data formats, offering well-defined handling of information sets expressed in XML, while the language itself uses XML syntax, affording nice composability, reflection and code generation capabilities. XSLT's processing model is both broadly applicable, and workable in a range of environments including client software or within encapsulated, secure software configurations and deployments.

If your XSLT is strong enough, you don't need XProc, or not much. But as a functional language, XSLT is best used in a functionally pure, &ldquo;stateless&rdquo; way that does not interact with the system: no &ldquo;side effects&rdquo;. This is related to its definitions of conformant processing (X inputs produce Y outputs) and the determinism, based in mathematical formalisms, that underlies its idea of conformance. However one cost of mathematical purity is that operations that do interact with stateful externalities – things such as reading and writing files – are not in XSLT's &ldquo;comfort zone&rdquo;. It easily defines what a new structure A' should look like for any given structure A. But how A is first acquired or what we do once we have determined A', is less clear, and left up to the processor to handle, as an interface, starting with an XSLT transformation's nominal *source* and (primary) *result*. Often, this gap has been bridged by extended functionality in processors. Does your processor read and parse XML files off the file system? Can it be connected to upstream data producers in different ways? Can it use HTTP `GET` and `PUT`? The answer may be Yes to any or all of these. Throughout its history, XSLT in later versions was also extended in this direction, with features such as the `collection()` function, `xsl:result-document`, `doc-available()` and other features we may not need if we are using XProc.

XSLT is commonly run from scripts, in web hosting environments and XQuery databases. Or you might be able to configure your desktop software (Editor or IDE) to run your XSLT, or acquire specialized software just for reading and filtering collections or managing sets of file outputs in XSLT-based workflows.

Yet XProc may offer a gentler approach, while it enables XSLT on the one hand when needed, while on the other enables us largely to do without it, offering both a useful feature set and the flexibility we need, but with less overhead, especially with regard to routine chores like designating sets of inputs and outputs, or sequencing operations. The principle of Least Power may well apply here: it saves our present and our future selves effort if we can arrange and manage to do things less. XProc lets us do less.

XProc lets us use XSLT when we must, but also keeps routine and simple things both simple and consistent. And it adapts itself well to new requirements as they become more complicated. Ultimately, it spares the XSLT developer the problem of having to design, build and test something like XProc.

### Running XSLT without XProc

As a standard and an externally-specified technology, XSLT can in principle be implemented on any platform, but the leading XSLT implementation for some years has been Saxon, produced by Saxonica of Reading, England. Saxon has achieved market share and developer support on a record of strictly-conformant, performant applications, deployed as an open-source software product free for developers to use and integrate. (While doing this, Saxonica also has related product offerings including optimized processor for those who choose to support it.)

Download and run Saxon to apply XSLT to XML and other inputs, without XProc.

## Using XSLT in XProc: avoiding annoyances XXX

If you are an experienced XSLT user, congratulations! The power XProc puts into your hands is everything you might think and hope.

There are a couple of small but potentially annoying considerations when embedding XSLT literals in your XProc code. They do not apply when your XSLT is called from out of line, acquired by binding to an input port or even `p:load`. If you acquire and even manipulate your XSLT without including literal XSLT code in your XProc, that eliminates the syntax-level clashes at the roots of both these problems.

### Text and attribute value syntax in embedded XSLT

### Namespaces in and for your XSLT

## Learning XSLT the safer way

If setting out to learn XSLT, pause to read the following list of things to which you should give early attention, in order:


1. Namespaces in XML and XSLT: names, name prefixes, unprefixed names and the `xpath-default-namespace` setting (not available until XSLT 2.0)

1. Templates and modes in XSLT: template matching, `xsl:apply-templates`, built-in templates, and using modes to configure default behaviors when no template matches

1. XPath, especially absolute and relative location paths: start easy and work up

Only one of these topics does not also apply to XProc.

## XProc without XSLT?

XProc does not require XSLT absolutely, even if XSLT is indispensable for some of XProc libraries, including those in this repository.

How could we do without it?

* Using XQuery any time queries get complicated
* Use XProc where possible, for example steps that support matches on patterns? E.g. `p:insert`, `p:label-elements` and `p:add-attribute`
* Reliance on iterators and `p:viewport`
* Much smarter (declarative, data-centric) HTML or other dialect in the application space?

Chances are, there is a limit. One thing XSLT does better than almost any comparable technology is support generalized or granular mappings between vocabularies.

So not only creating, but also consuming HTML, is the place we begin with XSLT. But since it is also very fine for other vocabulary mappings in the middle and back, it becomes indispensable almost as soon as it is available for use.

## XProc, XDM (the XML data model) and the standards stack

Another critical consideration is whether and to what extent XProc and XSLT introduce unwanted dependencies, which make them strategically not a good choice (or not a good choice for everyone) at least in comparison to alternatives. These are standards in every way including nominally - emerging as the work of organizations such as W3C and ISO, while not escaping a reputation as &ldquo;boutique&rdquo; or &ldquo;niche&rdquo; technologies. Yet alternative models – whether to go with the big guys, or rely on forests of Javascript libraries, or support a bespoke Markdown-based stack – have not all fared very well either. Often scorned, XSLT has a reputation for projects migrating away from it as much as towards it. Yet look closely, and when problems arise, XSLT is never the issue by itself. Often the question is, were you even using the right tool? one way is to be in the sweet spot (and there is a sweet spot) of document processing at scale, but this is not definitive. Sometimes the question is, are you actually fitting the capabilities of the processing model to the problem at hand. Too often, that fit happens by accident.

So where has XML-based processing been not only tenable but rewarding over the long term? Interestingly, its success is to be found often in projects that have survived across more than one system over time, that have grown from one system into another, and that have morphed and adapted and grown new limbs. (Pubmed Central comes to mind. But what about Optical Society? PLOS?) In other words, look at them today and you do not see the same system as you would have only five years ago.
