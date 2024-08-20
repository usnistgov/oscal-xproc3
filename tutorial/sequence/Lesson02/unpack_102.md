> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [/tutorial/source/unpack/unpack_102_src.html](../../../tutorial/source/unpack/unpack_102_src.html).
> 
> To create a persistent copy (for example, for purposes of annotation) save this file out elsewhere, and edit the copy.

# 102: XProc fundamentals



## Goals

* More familiarity with XProc 3.0: more syntax
* History, concepts and resources


## Resources

Take a quick look *now*:

This tutorial's handmade [XProc dashboard](../../xproc-dashboard.md) with links

Also, the official [XProc.org dashboard page](https://xproc.org)

Also, check out XProc index materials produced in this repository: [XProc docs](../../../projects/xproc-doc/readme.md)

And the same pipelines you ran in setup: [Setup 101](../setup/setup_101.md).

## Prerequisites

You have done [Setup 101](../setup/setup_101.md), [Setup 102](../setup/setup_101.md) and [Unpack 101](unpack_101_src.html).

## Learning about XProc

* Search engines: use keywords &ldquo;XProc3&rdquo; or &ldquo;XProc 3.0&rdquo; to help distinguish from 1.0 technologies
* Resources: links here and elsewhere
* Hands on exercises
* Work the notes - save out and annotate these pages


## Anatomy of an XProc pipeline

### XProc files and XProc steps

The *step* is the core conceptual unit of XProc. An XProc processing pipeline is composed of steps. But a pipeline is also considered as a step in itself. As such it can be used in other pipelines, and so on.

In other words, steps in XProc are *compositional*. They are building block assemblies made out of smaller building block assemblies. A step is a way to process data. A pipeline is a way of orchestrating and arranging such processes.

The distinction between pipelines and steps is relative and provisional, but important and useful. The pipeline is the logical and actual definition of how your data is to be processed. Every pipeline is composed of an arrangement, often a series, of operations. The definitions - the steps - include &ldquo;primitives&rdquo;, being designed for generality and reusability for the most common operations. But since a pipeline is also a step, we can always combine more than the primitives or core compound steps of the language. At a higher level, defining new steps with new step declarations, and using them in combination with other steps, is how we manage complexity and change in the requirements. This strategy can support for adaptability while also supporting an 'incremental maturity model', improving with reuse, building and testing over time. Careful use and deployment of new steps is how we save work, by focusing optimization and making it possible to scale up to address data processing requirement sets that are both large and complex.

Accommodating this design, an XProc *file* considered as an XML instance is either of two things: a *step declaration*, or a collection of such declarations, a *library*.

Additionally, step declarations can include their own pipeline (step) declarations, making a hybrid architecture: the pipeline comprises a step, with its own library not imported but in line. This can be useful.

An example of a step library in this repository is [xpec-execute.xpl](../../../xspec/xspec-execute.xpl), which collects several steps supporting XSpec, one each for supporting the XSpec testing framework for XSLT, XQuery and Schematron respectively.

The advantage of defining a step at the top level, rather than putting all steps into libraries, is that such a step can be invoked without prior knowledge of its type name, which is used by XProc to distinguish it from other steps. 

At the top level, recognize an XProc step declaration by the element, `p:declare-step` (in the XProc namespace) and a library by the element `p:library`.

```
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0" 
    name="a-first-step">
...
</p:declare-step>
```

#### XProc as an XML document

Like any language using XML syntax, XProc depends on a conceptual relation between primitive constructs of the language, and XML syntax, a relation that is ordinarily (and usefully) mediated by means of an (actual or putative) XML *data model* including elements, attributes, comment nodes, text nodes and so forth. XSLT is such a language, for example: it has its top-level *declarations*, its *template rules* and its *instructions*, all of which are represented using elements in the (standard and most commonly used) XML syntax. Part of learning XSLT is learning that `xsl:key` is a declaration while `xsl:template` is a template rule.

In the same way, elements in XProc's XML vocabulary correspond to structures in XProc - structures which developers and users rely on, as they define both the internals and the &ldquo;control interface&rdquo; for the language as a semantic construct - something that &ldquo;does something&rdquo;. In XProc, those structures include things like **documents**, **content-types** (think of &ldquo;formats&rdquo; such as XML and JSON), **ports** and **steps**. Some XProc elements represent steps, others do not. (In the same way as an XSLT key declaration is not a template rule.) Learning this difference among others is how you learn XProc.

Fortunately, the vocabulary of the language is not very large. Core XProc has only 95 elements defined in its namespace (or 99, if you are strictly counting all element types defined, not just the names those elements are given). This includes elements for all the core and community-defined steps (recognizable by the prefix `p:`). Additional to these 95 might be other steps you acquire or define. As with any lanuage, there are parts you will hardly ever use, while other parts are used routinely.

#### XProc embedded documentation

An example of this is the XProc `p:documentation` element. This element is designed to carry documentation to a consuming application. Rather than mandate some kind of behavior for `p:documentation` &mdash; something difficult or impossible to do for the general case, or to test &mdash;- the XProc rule is &ldquo;anything marked as documentation is for some other consumer&rdquo;, i.e. a documentation engine, not the XProc processor. In other words, a conformant processor [must ignore anything it sees](https://spec.xproc.org/3.0/xproc/#documentation) inside `p:documentation`.

There is a small loophole, namely that the effect of `p:inline` for capturing XML overrides this provision, so if you put `p:documentation` inside `p:inline`, it &ldquo;becomes visible&rdquo; - as inline content, not as XProc to be operated on.

### XProc step prologue and body

Keep in mind that every XProc pipeline is also, potentially and actually, a step. There are two things we need to know about steps - how to define them, and how to use them.

We begin with how to recognize and use steps, but we can't avoid how to define them: because an XProc pipeline is also an XProc step, we can't use steps without ending up with a pipeline. We have only to look at the working pipeline we make with our steps, to see how a step is made.

As described in the [XProc 3.0
                  specification](https://spec.xproc.org/3.0/xproc/#declare-pipelines), XProc step declarations can be divided into an initial set of elements for setup and configuration, followed by what the specification calls a *subpipeline*, which is typically a sequence of steps to be executed &mdash; any steps available, which could be anything. Think of the subpipeline as the working parts of the pipeline, while the rest is all about how it is set up.

The list of elements that come before the steps is short, which helps: `p:import`, `p:import-functions`, `p:input`, `p:output`, `p:option` or `p:declare-step`. Everything coming after is a step.

Within this set of elements (all preceding, none following the subpipeline) XProc further distinguishes between the **imports** for steps and functions, appearing first (elements `p:import` and `p:import-functions`), to be followed by elements configuring the step: `p:input`, `p:output`, `p:option` &mdash; elements together called the [prologue](https://spec.xproc.org/3.0/xproc/#declare-pipelines).

The prologue is used to define ports and options for the pipeline - the points of control for its interfaces. (Technically: runtime bindings, and parameter or option settings.) If only a single input is needed, a single input port (named `source`) can be assumed, so prologues can be empty (and invisible, or not there).

Following the prologue, a step may also have local step definitions (`p:declare-step`).

After imports, prologue and (optional) step declarations, the step sequence that follows comprises the [subpipeline](https://spec.xproc.org/3.0/xproc/#dt-subpipeline).

One other complication: for purposes of exposition, we have pretended that `p:variable` (a variable declaration) and `p:documentation` (for out-of-band documentation) are steps, which is not how the XProc recommendation describes them, although they appears in the subpipeline with and among its steps.

In summary: any XProc pipeline, viewed as a step declaration, can have the following --

* Pipeline name and type assignment (if needed), given as attributes at the top
* **Imports**: step declarations, step libraries and functions to make available
* The pipeline **prologue**: any of the elements named `p:input`, `p:output` and `p:option`, defining this pipeline's ports and options
  * If no ports are named, assume a single `source` primary input port, permitting a single document


* Optionally (and not common): step declarations for local steps - each has its own name and type, prologue and steps
* For this pipeline, one or more steps, called the [subpipeline](https://spec.xproc.org/3.0/xproc/#dt-subpipeline)
  * Standard atomic and compound steps in XProc namespace (probably prefixed `p:`)
  * Imported steps - in their own namespaces (in this repository, prefixed `ox:`)
  * Variable declarations - `p:variable`


* Finally, as noted above, `p:documentation` can appear anywhere in a pipeline, but it will be ignored except when appearing inside `p:inline`. What to do with these is a topic to be covered later.


NB: the pipelines run so far have XML comments demarcating the prologue from the steps

### Atomic and compound steps

Given an understanding of the organization of an XProc pipeline, all that remains to understand of its syntax is the steps themselves, which follow a common pattern. Briefly put, atomic steps are any steps you use by simply invoking it with inputs and options: its logic is self-contained, and the operation it carries out is (at least conceptually) &ldquo;single&rdquo;. Compound steps, instead, are used to execute more than one subpipeline, with settings determined dynamically for the step.

Fortunately XProc keeps things simple by providing only a few compound steps supporting the identified range of needs &mdash; and no way for users to define their own. This does not prove to be a practical limitation, since atomic steps can have multiple inputs and outputs, distinguished by type and role, and indeed since atomic steps used in a pipeline can be defined with compound steps in their own subpipelines, either externally or even within the same step declaration.

Here are all the compound steps. All others are atomic steps.

* [p:for-each](https://spec.xproc.org/3.0/xproc/#p.for-each) - produce subpipeline results for each member of a sequence of inputs (documents or nodes)
* [p:if](https://spec.xproc.org/3.0/xproc/#p.if) - execute a subpipeline conditionally
* [p:choose](https://spec.xproc.org/3.0/xproc/#p.choose) - execute a subpipeline conditionally (`switch/case` operator)
* [p:group](https://spec.xproc.org/3.0/xproc/#p.group) - group a subpipeline (step sequence) into a single logical step
* [p:viewport](https://spec.xproc.org/3.0/xproc/#p.viewport) - reproduce outputs, except splicing subpipeline results in place of matched nodes (elements) in the input
* [p:try](https://spec.xproc.org/3.0/xproc/#p.try) - execute a subpipeline, and deliver its results, or if it fails, a fallback subpipeline given in a `p:catch`


Additionally to these elements, XProc subpipelines may contain variable declarations and documentation, as noted below.

### Namespaces and extension steps

We recognize steps because we either recognize them by name - for standard steps in the `p:` (XProc) namespace such as `p:filter` and `p:add-attribute` - or because we do not. Extension steps in XProc take the form of elements in an extension namespace. Generally speaking, that is, any element not prefixed with `p:` is treated as out of scope for XProc and to be ignored, while subject to evaluation as an extension.

In an XProc pipeline (library or step declaration) one may also see a namespace `c:`. TODO - come back to

<details><summary>Question: Where are extension steps used in the XProcs run so far?</summary>
Answer: The [XSpec smoke test](./../../../smoketest/SMOKETEST-XSPEC.xpl) calls an extension step named `ox:execute-xspec`, defined in an imported pipeline. In this document, the prefix `ox` is bound to a utility namespace, `http://csrc.nist.gov/ns/oscal-xproc3`.
</details>
### Schema for XProc 3.0

See the [599-level coverage in this lesson unit](unpack_599_src.html) for a discussion of the schema for XProc.

## Take note

### Where are these downloads coming from?

Pipelines can use a few different strategies for resource acquisition, depending on the case, and on where and in what form the resource is available. (Sometimes a file on Github is easiest to download "raw", sometimes an archive is downloaded and opened, and so on.) For now, it is not necessary to understand details in every case, only to observe the variation and range. (With more ideas welcome. Could XProc be used to build a &ldquo;secure downloader&rdquo; that knows how, for example, to compare hashes?)

Wherever you see `href` attributes, take note.

Since `href` is how XProc &ldquo;sees&rdquo; the world, either to read data in or to write data out, this attribute is a reliable indicator of an assumed feature, often a dependency of some kind. For example, a download will not succeed if the resource indicated by the `href` for the download returns an error, or nothing. In XProc, `href` attribute settings are the *points of control* for interaction between an XProc pipeline, and its runtime environment.

Useful detail: where XProc has `p:store href="some-uri.file"`, the `href` is read by the processor as the intended location for storage of pipeline data, that is, for a *write* operation. In other cases `href` is always an argument for a *read* operation.

### Syntax tips

In XPath syntax, `$foo` (a name with a `$` prefixed) indicates a **variable reference** named (in this case) &ldquo;foo&rdquo;. XProc also uses a *value expansion syntax* (either*text value syntax* or *attribute value syntax*) using curly braces - so syntax such as `href="{$some-xml-uri}"` is not uncommon. Depending on use, this would mean &ldquo;read [or write] to the URI given by `$some-xml-uri`&rdquo;.

An XProc developer always knows where `href` is used in a pipeline, and how to test for and update its use. As always with syntax, the easiest way to learn it is to try making changes and observing outcomes.

## Exercise: Knowing what to look for

The last lesson unit already provided an opportunity to alter pipelines and see how they fail when not encoded correctly &mdash; when &ldquo;broken&rdquo;, any way we can think of breaking them. (Then we had an opportunity to put them back.)

After reading this page, do this again, except focusing on a few key areas:

* Keep in mind how inputs (source data) for your pipeline can be provided either with `p:input` (part of the pipeline prologue) or directly by `p:load` (a step). When you see a document referenced on either `p:document` or `p:load`, by means of `href`, you are looking at a call either to an XML document, or some other data instance (e.g.: text file; JSON data instance). (One difference is that `p:document` bindings provided to `p:input` can be overridden but `p:load` says what it says.) These inputs are ordinarily dependencies for the pipeline. Change or override them, and you change the inputs provided.
* `@href` attributes on `p:store` (in contrast to `p:load`) are equally important, but for the opposite reason: `p:store` is one of the ways XProc offers to &ldquo;write&rdquo; or save out its processing results, to the location given (in a writeable file system). The other way is binding to a `p:output` port and doing something with that.
* Detail: while `p:input/p:document` is a way of providing inputs, you aren't likely to see `p:output/p:document`. The XProc specication clarifies the reason why (at the end of the section [p:output](https://spec.xproc.org/3.0/xproc/#p.output)) this pattern would be used only for very special purposes, if at all. Defining an output **port**, `p:output`, when given, shows not what will or should happen with process results (outputs), but rather exactly what kinds of outputs are available, with the names and configurations including which results they capture. If such a port is not connected to a processing result but to a static resource, the static resource is what will appear there.
* Reverse this logic and you can see that a pipeline with no `p:output` must somewhere among its steps have one or more `p:store` steps, since these are the only ways results are made available externally to the pipeline runtime.
* For security analysts: yes, this last point is consequential for purposes of auditing and assessing vulnerabilities in and with XProc. A pipeline with no `p:store` has no effects on a file system where it runs; a pipeline with no output ports exposes no results (for a calling process to receive) - so to have neither is effectively to have no effects anywhere.
* Both `p:load` and `p:store` are commonly provided with `@message` attributes, which are used to produce console messages (in a tool like Morgana) when steps in a subpipeline are executed.


After breaking anything, restore it to working order. Create modified copies of any pipelines for further analysis and discussion.

Concept: copy and change one of the pipelines provided to acquire a software library or resource of your choice.
