

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [](../../..).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 201: XProc in more depth

## Goals

Get more in-depth information about XProc internals.

## Prerequisites

You have succeeded in prior exercises, including tools installation and setup. You have seen enough XProc to be impressed, but possibly also a little intimidated.

## Resources

Again, reference is made to pipelines and processes defined for the [oscal-convert project](../../../projects/oscal-convert/readme.md).

## Overview: the anatomy of an XProc pipeline

Experts in XML can read this section quickly. Newcomers will find some of the concepts here (such as namespaces) also apply across XML- and XDM-based technologies including XSLT and Schematron. XDM is the [XQuery and XPath Data Model](https://www.w3.org/TR/xpath-datamodel/), the foundation of XPath, XQuery and XSLT.

### XProc files

An XProc pipeline takes the form of an XML &ldquo;document entity&rdquo;. Unless you are concerned to write an XML parser (which is not very likely for XProc's natural constituency), this typically means an XML file, that is to say a file encoded in plain text (typically the UTF-8 serialization of Unicode, or alternatively another form of &ldquo;plain text&rdquo; supported by your toolkit), and following the rules of XML syntax. These rules include how elements and attributes and other XML features are encoded in **tags** that

* Follow the rules with respect to naming, whitespace, delimiters and reserved characters
* Are correctly balanced, with an end tag for every start tag – for a `<start>` there must be a `</start>` (an end to the start).
* Are cleanly nested with no overlap: end tags always close the most recently opened element, so no element ever extends beyond the boundaries of its &ldquo;ancestor&rdquo; or containing elements

These rules are fairly simple, and they are well supported by tools designed to read and write XML – to respect, follow and enforce the rules on our behalf.

Thus they are also quickly and easily internalized, often in only a few minutes of working with XML.

Over and above being XML, XProc has some rules of its own ...

#### XProc document element

```
<p:declare-step version="3.0"
   xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:TEST-XPROC3"
   name="TEST-XPROC3">
...
</p:declare-step>
```

#### Namespaces

```
   xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
```

#### @name and @type

On `p:declare-step`, whether at the top or in a step definition within a pipeline, either or both a `@name` and a `@type` are permitted.

```
   type="ox:TEST-XPROC3"
   name="TEST-XPROC3">
```

The name makes it possible to reference the step by name. This is often useful and sometimes more or less essential, for example for providing input to one step from another step's output. (We say &ldquo;more or less essential&rdquo; because the processor will produce names for itself as a fallback, if it needs them, but these are brittle, somewhat opaque – such as `!1.2.3` – and more difficult to use than the names a developer gives.)

Understandably, the name of an XProc must be different from the names given to all the steps in the XProc (which must also be distinct). 

This repository follows a rule that a step name should correspond to its file base name (i.e., without a filename suffix), so `identity_` for `identity_.xproc`, etc. But that is a rule for us, not for XProc in general.

A step may also have an assigned `@type`. Unlike the name, which can be in any namespace or none, the `@type` must be assigned to a namespace.

### Prologue and body

Keep in mind that to build a pipeline is also to design and deploy a step, since any pipeline can be used as a step, and any step may comprise, internally, a pipeline.

Since step definitions are more often &ldquo;out of line&rdquo; (in an external file) than inline (in the XProc itself), 

As described in the [XProc 3.0                   specification](https://spec.xproc.org/3.0/xproc/#declare-pipelines), XProc step declarations can be divided into an initial set of elements for setup and configuration, followed by what the specification calls a *subpipeline*, consisting of a sequence of steps to be executed – any steps available, which could be anything. Think of the subpipeline as the working parts of the pipeline, while the rest is all about how it is set up.

The list of elements that come before the subpipeline is short, which helps: `p:import`, `p:import-functions`, `p:input`, `p:output`, `p:option` or `p:declare-step`. Everything coming after is a step.

Within this set of elements (all preceding, none following the subpipeline) XProc further distinguishes between the **imports** for steps and functions, appearing first (elements `p:import` and `p:import-functions`), to be followed by elements configuring the step: `p:input`, `p:output`, `p:option` – elements together called the [prologue](https://spec.xproc.org/3.0/xproc/#declare-pipelines).

The prologue is used to define ports and options for the pipeline. It can be thought of as the definition of the interface for the step as a whole. Defining ports and options is how you give the users of the step with the affordances or control points they need to use it. If only a single input is needed, a single input port (named `source`) can be assumed (XXX is this so?), so prologues can be empty (and invisible, or not there).

Following the prologue, a step may also have local step definitions (`p:declare-step`). One might think of these as macros: maybe they are never used by another pipeline (XXX test: is this even possible?), but these locally-defined pipelines can be used internally for logic that is used repeatedly, or that warrants separating from the main pipeline for some other reason.

After imports, prologue and (optional) step declarations, the step sequence that follows comprises the [subpipeline](https://spec.xproc.org/3.0/xproc/#dt-subpipeline).

One other complication: among the steps in the subpipeline, `p:variable` (a variable declaration) and `p:documentation` (for out-of-band documentation) are also permitted – these are not properly steps, but can be useful to have with them.

In summary: any XProc pipeline, viewed as a step declaration, can have the following --

* Pipeline name and type assignment (if needed), given as attributes at the top
* **Imports**: step declarations, step libraries and functions to make available
* The pipeline **prologue**: any of the elements named `p:input`, `p:output` and `p:option`, defining this pipeline's ports and options
  * If no ports are named, assume a single `source` primary input port, permitting a single document
* Optionally (and not common): step declarations for local steps, appearing at `p:declare-step`. Each of these will have its own name, type, prologue and steps
* For this pipeline, one or more steps, called the [subpipeline](https://spec.xproc.org/3.0/xproc/#dt-subpipeline)
  * Standard atomic and compound steps in XProc namespace (probably prefixed `p:`)
  * Imported steps - in their own namespaces (in this repository, prefixed `ox:`)
  * Variable declarations - `p:variable`
* Finally, as noted above, `p:documentation` can appear anywhere in a pipeline, but it will be ignored except when appearing inside `p:inline`. What to do with these is a topic to be covered later.

NB: the pipelines run so far have XML comments demarcating the prologue from the steps.

### XProc steps

The *step* is the core conceptual unit of XProc. An XProc processing pipeline is composed of steps. But a pipeline is also considered as a step in itself. As such it can be used in other pipelines, and so on.

In other words, steps in XProc are *compositional*. They are building block assemblies made out of smaller building block assemblies. A step is a way to process data. A pipeline is a way of orchestrating and arranging such processes.

The distinction between pipelines and steps is relative and provisional, but important and useful. The pipeline is the logical and actual definition of how your data is to be processed. Every pipeline is composed of an arrangement, often a series, of operations. These operations – the steps – include &ldquo;primitives&rdquo;, being designed for generality and reusability for the most common operations. But they can also include new steps we have written, as pipelines, and such custom-designed steps can be used in combination with the primitives or core compound steps of the language.

At a higher level, defining new steps with new step declarations, and using them in combination with other steps, is how we manage complexity and change in processing requirements. This strategy maximizes adaptability, while also supporting an &ldquo;incremental maturity model&rdquo;, in which all defined processes can be improved with reuse, building and testing over time. Careful use and deployment of new steps is how we save work, by focusing optimization and making it possible to scale up to address data processing requirement sets that are both large and complex.

Accommodating this design, an XProc *file* considered as an XML instance is either of two things: a *step declaration*, or a collection of such declarations, a *library*. At the top level, recognize an XProc step declaration by the element, `p:declare-step` (in the XProc namespace) and a library by the element `p:library`.

```
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0" 
    name="a-first-step">
...
</p:declare-step>
```

Additionally, step declarations can include their own pipeline (step) declarations, making a hybrid architecture: the pipeline comprises a step, with its own library not imported but in line. This can also be useful.

An example of a step library in this repository is [xspec-execute.xpl](../../../xspec/xspec-execute.xpl), which collects several steps supporting XSpec, one each for supporting the XSpec testing framework for XSLT, XQuery and Schematron respectively.

The advantage of defining a step at the top level, rather than putting all steps into libraries, is that such a step can be invoked without prior knowledge of its type name, which is used by XProc to distinguish it from other steps. The pipeline simply needs to be presented to the processor, which does the rest.

#### XProc as an XML document

Like any language using XML syntax, XProc depends on a conceptual relation between primitive constructs of the language, and XML syntax, a relation that is ordinarily (and usefully) mediated by means of an (actual or putative) XML *data model* including elements, attributes, comment nodes, text nodes and so forth. XSLT is such a language, for example: it has its top-level *declarations*, its *template rules* and its *instructions*, all of which are represented using elements in the (standard and most commonly used) XML syntax. Thus, part of learning XSLT is learning that `xsl:key` is syntax for a &ldquo;key declaration&rdquo; while `xsl:template` is a &ldquo;template rule&rdquo;.

In the same way, elements in XProc's XML vocabulary correspond to structures in XProc - structures which developers and users rely on, as they define both the internals and the &ldquo;control interface&rdquo; for the language as a semantic construct - something that &ldquo;does something&rdquo;. In XProc, those structures include things like **documents**, **content-types** (think of &ldquo;formats&rdquo; such as XML and JSON), **ports** and **steps**. Some XProc elements represent steps, others do not. (In the same way as an XSLT key declaration is not a template rule.) Learning this difference among others is how you learn XProc.

Fortunately, the vocabulary of the language is not very large. Core XProc 3.0 has only 95 elements defined in its namespace (or 99, if you are strictly counting all element types defined, not just the names those elements are given). XProc 3.1 adds a few more. This includes elements for all the core and community-defined steps (recognizable by the prefix `p:`). Additional to these 95 might be other steps you acquire or define. As with any language, there are parts you will hardly ever use, while other parts are used routinely.

#### XProc embedded documentation

An example of this is the XProc `p:documentation` element. This element is designed to carry documentation to a consuming application. Rather than mandate some kind of behavior for `p:documentation` – something difficult or impossible to do for the general case, or to test –- the XProc rule is &ldquo;anything marked as documentation is for some other consumer&rdquo;, i.e. a documentation engine, not the XProc processor. In other words, a conformant processor [must ignore anything it sees](https://spec.xproc.org/3.0/xproc/#documentation) inside `p:documentation`.

There is a small loophole, namely that the effect of `p:inline` for capturing XML overrides this provision, so if you put `p:documentation` inside `p:inline`, it &ldquo;becomes visible&rdquo; as inline content, not as XProc to be operated on (or not).

As always it is up to the developer how thoroughly and in what form to include inline documentation. And short of managing a corpus of code documentation along with the code, placing explanatory remarks and code snippets into comments is a widely followed practice, and recommended for its combination of ease and usefulness.

### Atomic and compound steps

Given an understanding of the organization of an XProc pipeline, the focus shifts to the steps themselves, which follow a common pattern. Briefly put, an atomic step is any step you use by simply invoking it with inputs and options: its logic is self-contained, and the operation it carries out is (at least conceptually) &ldquo;single&rdquo; and unified. A compound step, in contrast, combines one or more other steps in a *subpipeline* and manages these together through a single interface.

XProc keeps things workable by providing only a few compound steps supporting the identified range of needs. This does not prove to be a practical limitation, since all steps including atomic steps can have multiple inputs and outputs, distinguished by type and role. (For example, a validation step might output both a copy of the input, potentially annotated, along with a validation report.) Atomic steps are not necessarily simple, and may include compound steps in their own subpipelines, either externally or even within the same step declaration. Accordingly, compound steps are not necessarily more complex than atomic steps: they are useful because they handle common contingencies such as splicing (with `p:viewport`), splitting (with `p:for-each`, perform an operation in parallel over a set of inputs, not a single document), conditionals (`p:if`, `p:choose`) and exception handling (`p:try` with `p:catch` and `p:finally`).

Here are all the compound steps. All others are atomic steps.

* [p:group](https://spec.xproc.org/3.0/xproc/#p.group) - group a subpipeline (step sequence) into a single logical step
* [p:if](https://spec.xproc.org/3.0/xproc/#p.if) - execute a subpipeline conditionally
* [p:choose](https://spec.xproc.org/3.0/xproc/#p.choose) - execute a subpipeline conditionally (`switch/case` operator)
* [p:for-each](https://spec.xproc.org/3.0/xproc/#p.for-each) - produce subpipeline results for each member of a sequence of inputs (documents or nodes)
* [p:viewport](https://spec.xproc.org/3.0/xproc/#p.viewport) - reproduce outputs, except splicing subpipeline results in place of matched nodes (elements) in the input
* [p:try](https://spec.xproc.org/3.0/xproc/#p.try) - execute a subpipeline, and deliver its results, or if it fails, run a fallback subpipeline given in a `p:catch`

Additionally to these elements, XProc subpipelines may contain variable declarations (`p:variable`) and documentation (`p:documentation`), as noted.

### Namespaces and extension steps

We recognize steps because we either recognize them by name - for standard steps in the `p:` (XProc) namespace such as `p:filter` and `p:add-attribute` - or sometimes by process of elimination – because they cannot be anything else. This is because extension steps, whether written or acquired, can be named anything. Fortunately, extension steps in XProc take the form of elements in an *extension namespace*. Generally speaking, that is, any element not prefixed with `p:` is treated as out of scope for XProc and to be ignored, while subject to evaluation as an extension.

But this is an important category, since such extensions may include XProc steps whose functioning is core to the pipeline as a whole.
<details><summary>Question: Where are extension steps used in the XProcs run so far?</summary>

One answer: The [XSpec smoke test](./../../../smoketest/TEST-XSPEC.xpl) calls an extension step named `ox:execute-xspec`, defined in an imported pipeline. In this document, the prefix `ox` is bound to a utility namespace, `http://csrc.nist.gov/ns/oscal-xproc3`.

In an XProc pipeline (library or step declaration) one may also see additional namespaces, including

* The namespaces needed for XSLT, XSD, or other supported technology
* One or more namespaces deployed by the XProc author to support either steps or internal operations (for example, XSLT functions)
* The namespace `http://www.w3.org/ns/xproc-step`, usually associated with the name prefix `c:`. This namespace is designated by XProc in order to help standardize the interfaces (inputs and outputs) supported by standard steps.
* The namespace `http://www.w3.org/ns/xproc-error`, for XProc's error reportingThese declarations (often but not always at the top of the document) are critically important for XPath and hence for the correct operation of your pipelines. See [the specification](https://spec.xproc.org/3.0/xproc/#namespaces) for more information.</details>

### Schema for XProc 3.0

See coverage of [XProc, XML and XDM (the XML                   Data Model)](../walkthrough/walkthrough_399.md) in the prior lesson unit for a link to the schema for XProc.

## Some breaking and making

Every project you examine provides an opportunity to alter pipelines and see how they fail when not encoded correctly – when &ldquo;broken&rdquo;, any way we can think of breaking them. Then build good habits by repairing the damage. Experiment and observation bring learning.

After reading this page, perform some more disassembly / reassembly. Here are a few ideas:

* Switch out the value of an `@href` on a `p:document` or `p:load` step. See what happens when the file it points to is not actually there.
* There is a difference between `p:input`, used to configure a pipeline in its prologue, and `p:load`, a step that loads data. Ponder what these differences are. Try changing a pipeline that uses one into a pipeline that uses the other.
* Similarly, there is a difference between a `p:output` configuration for a pipeline, and a `p:store` step executed by that pipeline. Consider this difference and how we might define a rule for when to prefer one or the other. How is the pipeline used - is it called directly, or intended for use as a step in other pipelines? How is it to be controlled at runtime?
* Try inserting `p:store` steps into a pipeline to capture intermediate results, that is, the output of any step before they are processed by the next step. Such steps can aid in debugging, among other uses.
* `@message` attributes on steps provide messages for the runtime traceback. They are optional but this repo follows a rule that any `p:load` or `p:store` should be provided with a message. Why?
* A `p:identity` step passes its input unchanged to the next step. But can also be provided with a `@message`.

After breaking anything, restore it to working order. Create modified copies of any pipelines for further analysis and discussion.

* Concept: copy and change one of the pipelines provided to acquire a software library or resource of your choice.

## What could possibly go wrong?

When coping with errors, syntax errors are relatively easy. But anomalous inputs, especially invalid inputs, can result in lost data. (A common reason data is not valid even when it appears to be is that it has foreign unknown contents, or contents out of place - the kinds of things that might fail to be converted.) The most important concern when engineering a pipeline is to see to it that no data quality problems are introduced inadvertantly. While in comparison to syntax or configuration problems, data quality issues can be subtle, there is also good news: the very same tools we use to process inputs into outputs, can also be used to test and validate data to both applicable standards and local rules.

Generally speaking, OSCAL maintains &ldquo;validation parity&rdquo; between its XML and JSON formats with respect to their schemas. That is to say, the XSD (XML schema) covers essentially the same set of rules for OSCAL XML data as the JSON Schema does for OSCAL JSON data, accounting for differences between the two notations, the data models and how information is mapped into them. A consequence of this is that valid OSCAL data, either XML or JSON, can reliably be converted to valid data in the other notation, while invalid data may not be converted at all, resulting in gaps or empty results.

For this and related reasons on open systems, the working principle in XML is often to formalize a model (typically by writing and deploying a schema) as early as possible - or adopt a model already built - as a way to institute and enforce schema validation as a **prerequisite** and **primary requirement** for working with any data set. Validation against schemas is covered in a subsequent lesson unit (coming soon near you).

### Intercepting errors

One way to manage the problem of ensuring input quality is to validate on the way in, either as a dependent (prerequisite) process, or built into a pipeline. Whatever you want to do with invalid inputs, including ignoring them and producing warnings or runtime exceptions, can be defined in a pipeline much like anything else.

In the [publishing demonstration                   project folder](../../../projects/oscal-publish/publish-oscal-catalog.xpl) is an XProc that valides XML against an OSCAL schema, before formatting it. The same could be done for an XProc that converts the data into JSON - either or both before or after conversion.

Learn more about recognizing and dealing with errors in [Lesson 102](oscal-convert_102.md), or continue on to the next project, oscal-validate, for more on validation of documents and sets of documents.

## for 599: XProc for JSON

map objects; steps for working with them; interim p:store as debug method; output ports to see results (final and intermediate) or bind them

## for 599: YAML TODO

map objects; steps for working with them

## for 599: XProc port bindings

This is actually a .bat or .sh exercise - write a script that invokes XProc with a binding to a runtime argument

Thus, a script `convert-oscal-catalog-xml.sh mycatalog.xml` could produce `mycatalog.json` from `mycatalog.xml` etc.

Such a script could live in the project directory - do we want an Issue for this work item? 

## for 599: URIs and URI schemes

As described in [the XProc                specification](https://spec.xproc.org/master/head/xproc/#err.inline.D0012), it is up to implementations to define supported URI schemes and data retrieval mechanics, including XML catalogs to support resource caching and indirection, etc.

## for 599: round tripping as process test
