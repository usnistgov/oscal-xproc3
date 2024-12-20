

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [../../../source/oscal-convert/oscal-convert_201_src.html](../../../source/oscal-convert/oscal-convert_201_src.html).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 201: Anatomy of an XProc pipeline

## Goals

Get more in-depth information about XProc internals, including especially the parts of an XProc pipeline step, as a step.

This includes its imports, its prologue, subpipeline and steps.

## Prerequisites

You have succeeded in prior exercises, including tools installation and setup. You have seen enough XProc to be impressed, at least, by the concept.

While concepts here are basic, what is presented is not always obvious.

## Resources

Pipelines throughout the repository serve as examples for the description that follows.

Earlier coverage of [the XML Data Model                (XDM) as it relates to XProc ](../walkthrough/walkthrough_219.md) can also be kept in mind.

## XProc as XML (redux)

Recall that an XProc pipeline itself takes the form of an XML [document entity](https://www.w3.org/TR/REC-xml/#sec-doc-entity). Put less mysteriously, this means that XProc is designed to be written and maintained in XML syntax, and most XProc systems will be reliant on XProc kept in XML files (in a file server or database). We recognize XProc by its XML *vocabulary* expressed using *tags* that follow the XML tagging rules:

* They follow XML's rules with respect to naming, whitespace, delimiters and reserved characters
* They are correctly balanced, with an end tag for every start tag – for a `<start>` there must be a `</start>` (an end to the start).
* They are cleanly nested with no overlap: end tags always close the most recently opened element, so no element ever extends beyond the boundaries of its &ldquo;ancestors&rdquo; or containing elements

These rules are fairly simple, and they are well supported by tools designed to read and write XML – to respect, follow and enforce the rules on our behalf.

Thus they are also quickly and easily internalized, often in only a few minutes of working with XML.

Over and above being XML, XProc has some rules of its own ...

### XProc at the top

At the very top of an XProc file, expect to see something not unlike this:

```
<p:declare-step version="3.0"
   xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
   type="ox:TEST-XPROC3"
   name="TEST-XPROC3">
...
</p:declare-step>
```

XProc pipelines are XML documents using the XProc vocabulary. At the top (paradoxically, we call this the &ldquo;root&rdquo;), an XProc instance is identified by tagging it either of `p:declare-step` or `p:library`. XProc in this repository includes at least one `p:library`, and it might be nice to have more. More on this below.

As noted next, the element at the top ordinarily provides namespace prefix bindings (namespace declaration attributes) along with a `name` and a `type` for the step.

### Namespaces

```
   xmlns:p="http://www.w3.org/ns/xproc"
   xmlns:ox="http://csrc.nist.gov/ns/oscal-xproc3"
```

Namespaces are discussed [soon enough](oscal-convert_350.md). Here it suffices to reiterate that XProc needs to be able to use its own namespace, `http://www.w3.org/ns/xproc`) at the very minimum, as well as others, both for the data sets in scope (inputs and process results) and for processes: namespaces also serve to support extensibility up and down the stack (in XProc, XSLT and XPath/XQuery). Accordingly you will probably also want a namespace (or more than one) whose prefix and URI bindings you control.

Since namespaces declared at the top of the document will apply throughout the document, this is a good (and conventional) place to put namespace declaration attributes, keeping them out of the way and make them easier to find.

### @name and @type

On `p:declare-step`, whether at the top or in a step definition within a pipeline, either or both a `@name` and a `@type` are permitted.

```
   type="ox:TEST-XPROC3"
   name="TEST-XPROC3"
```

The name makes it possible to reference the pipeline itself by name, as a step. This makes it possible to create bindings inside the pipeline to the pipeline's own ports, when implicit (i.e., defaulted) bindings are not sufficient.

Understandably, the name of an XProc must be different from the names given to all the steps in the XProc (which must also be distinct).

This repository follows a rule that a step name should correspond to its file base name (i.e., without a filename suffix), so `identity_` for `identity_.xproc`, etc. But that is a rule for us, not for XProc in general.

A step may also have an assigned `@type`. Unlike the name, which can be in any namespace or none, the `@type` must be assigned to a namespace.

The assigned typed is just as important as the name, as a step is called by its *type name*. Decoupling the name from the type name provides useful flexibility, as both can be important but they do not need to be the same.

## Prologue and body

A pipeline will typically be a collection or sequence of steps, of arbitrary complexity. By this we mean that any step might be simple or complex in its operations; and the sequence may be short or long, or simple and singular or branching, multiple (with respect to inputs or outputs) and conditional. In addition to this orchestration, simple or complex, a pipeline must have one other thing, namely an interface or *signature*. This is what gives the pipeline (if one dare say) &ldquo;semantics&rdquo; in the form of a specification, whether explicit or implicit, of what constitute valid inputs, expected outputs, and recognized runtime options. This interface is defined in the pipeline's *prologue*. The sequence or arrangement of steps, however long or short, constitutes the pipeline's *body* and serve as the pipeline's [subpipeline](https://spec.xproc.org/3.0/xproc/#declare-pipelines) .

Think of the subpipeline as the working components of the pipeline, while the prologue defines its interface or &ldquo;control surface&rdquo;, as on a black box. That is, what kinds of inputs need to be provided to it (if any), what kinds of results it exposes (apart from outputs it has taken on itself to produce), and what kinds of options or configurations are available.

But even before the prologue we may see import declarations. Add to these any local step definitions for embedded pipelines (not common but not unheard of), and at a high level we see these element groups:

* Imports (optional) - configuring where the processor can find logic to be called from external pipelines: `p:import`, `p:import-functions`
* Prologue - configuring inputs, outputs and options for the pipeline, if any - the prologue can be empty: , `p:input`, `p:output`, `p:option`
* Local step definitions, if any: `p:declare-step` 
* Subpipeline - step invocations, connected implicitly or explicitly, with supporting variable declarations and documentation

In total, the list of elements coming before the subpipeline is short, which helps: six in total between `p:import` and `p:declare-step`. Everything coming after is part of the subpipeline.

Imports will be discussed later, or can be reasoned about readily from examples.

The *prologue* is used to define *ports* and *options* for the pipeline. Defining ports and options is how you give the users of the step with the affordances or control points they need to use it. It is common and conventional to have a single input port named `source` as *primary input*. But some pipelines require no input bindings since they acquire data in other ways. If your pipeline is intended to be self-contained, its prologue can be empty. More commonly, ports and options are defined, at least to provide default settings.

Keep in mind that just because a pipeline has no exposed ports for inputs or outputs, does not mean it does nothing. Among other things, pipelines can read and write (or be asked to write) arbitrary resources to a file system. Its exposed interfaces provide for functional composition: since they have inputs and outputs, pipelines can be used as steps in pipelines. But those do not in any way preclude its operations. Unlike the functional languages it embeds (XSLT and XQuery), XProc does *not* seek to be side-effect free.

Following the prologue, a step may also have local step definitions (`p:declare-step`). One might think of these as an XProc equivalent of a &ldquo;macro&rdquo;: these locally-defined pipelines can be used internally for logic that is used repeatedly, or that warrants separating from the main pipeline for some other reason.

After imports, prologue and (optional) step declarations, the step sequence that follows comprises the [subpipeline](https://spec.xproc.org/3.0/xproc/#dt-subpipeline).

One other complication: among the steps in the subpipeline, `p:variable` (a variable declaration) and `p:documentation` (for pipeline documentation) are also permitted – these are not properly steps, but can be useful to have with them.

In summary with more detail: any XProc pipeline, viewed as a step declaration, can have the following:

* Pipeline name and type assignment (if needed), given as attributes at the top
* **Imports**: step declarations, step libraries and functions to make available
* The pipeline **prologue**: any of the elements named `p:input`, `p:output` and `p:option`, defining this pipeline's ports and options
* Optionally (and not common): step declarations for local steps, appearing at `p:declare-step`. Each of these will have its own name, type, prologue and steps
* For this pipeline, one or more steps, called the [subpipeline](https://spec.xproc.org/3.0/xproc/#dt-subpipeline)
  * Standard atomic and compound steps in XProc namespace (probably prefixed `p:`)
  * Imported steps - in their own namespaces (in this repository, prefixed `ox:`)
  * Variable declarations - `p:variable`
* Finally, as noted above, `p:documentation` can appear anywhere in a pipeline, but it will be ignored except when appearing inside `p:inline`. What to do with these is a topic to be covered later.

A useful exercise can be to open a few pipelines and distinguish its internal boundaries.

## XProc steps

The *step* is the core conceptual unit of XProc. An XProc processing pipeline is composed of steps. But a pipeline is also considered as a step in itself. As such it can be used in other pipelines, and so on.

In other words, steps in XProc are *compositional*. They are building block assemblies made out of smaller building block assemblies. A step is a way to process data. A pipeline is a way of orchestrating and arranging such processes.

The distinction between pipelines and steps is relative and provisional, but important and useful. The pipeline is the logical and actual definition of how your data is to be processed. Every pipeline is composed of an arrangement, often a series, of operations. These operations – the steps – include &ldquo;primitives&rdquo;, being designed for generality and reusability for the most common operations. But they can also include new steps we have written, as pipelines, and such custom-designed steps can be used in combination with the primitives or core compound steps of the language.

At a higher level, defining new steps with new step declarations, and using them in combination with other steps, is how we manage complexity and change in processing requirements. This strategy maximizes adaptability, while also supporting an incremental maturity model, in which all defined processes can be improved with reuse, building and testing over time. Careful use and deployment of new steps is how we save work, by focusing optimization and making it possible to scale up to address data processing requirement sets that are both large and complex.

Thus a kind of &ldquo;recursive orderability&rdquo;, wherein encapsulation itself is scaled up and out arbitrarily but only as much as needed, can be a working principle with XProc. As a pipeline, a step definition may include only a single step (a pipeline can be an interface or wrapper to another pipeline, or to a simple operation), or a long sequence or complex choreography of steps. In either case it can become a relatively self-contained black box process available to other processes.

Accommodating this design, an XProc *file* considered as an XML instance (as noted) is either of two things: a *step declaration*, or a collection of such declarations, a *library*. At the top level (as noted), recognize an XProc step declaration by the element, `p:declare-step` (in the XProc namespace) and a library by the element `p:library`.

```
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0" 
    name="a-first-step">
...
</p:declare-step>
```

Additionally, step declarations can include their own pipeline (step) declarations, making a hybrid architecture: the pipeline comprises a step, with its own library not imported but in line. This can also be useful.

An example of a step library in this repository is [xspec-execute.xpl](../../../xspec/xspec-execute.xpl), which collects several steps supporting XSpec, one each for supporting the XSpec testing framework for XSLT, XQuery and Schematron respectively.

The advantage of defining a step at the top level, rather than putting all steps into libraries, is that such a step can be invoked without prior knowledge of its type name, which is used by XProc to distinguish it from other steps. The pipeline simply needs to be presented to the processor, which does the rest. Your library of steps then looks very similar to your directory full of XProc files – and can be treated, where appropriately, as self-contained scripts encapsulating everything they need for a given runtime.

## Atomic and compound steps

Given an understanding of the organization of an XProc pipeline, the focus shifts to the steps themselves, which follow a common pattern. Briefly put, an atomic step is any step you use by simply invoking it with inputs and options: its logic is self-contained, and the operation it carries out is (at least conceptually) single and unified. A compound step, in contrast, combines one or more other steps in its own *subpipelines* and manages these together through a single interface, while providing – unlike an atomic step -- some other functionality depending on the step.

XProc keeps things workable by providing only a few compound steps supporting the identified range of needs. This does not prove to be a practical limitation, since all steps including atomic steps can have multiple inputs and outputs, distinguished by type and role. (For example, a validation step might output both a copy of the input, potentially annotated, along with a validation report.) Atomic steps are not necessarily simple, and may include compound steps in their own subpipelines. All steps you define will be atomic steps. Accordingly, compound steps are not necessarily more complex than atomic steps: they are useful because they handle common contingencies such as splicing (with `p:viewport`), splitting (with `p:for-each`, perform an operation in parallel over a set of inputs, not a single document), conditionals (`p:if`, `p:choose`) and exception handling (`p:try` with `p:catch` and `p:finally`).

Here are all the compound steps:

* [p:group](https://spec.xproc.org/3.0/xproc/#p.group) - group a subpipeline (step sequence) into a single logical step
* [p:if](https://spec.xproc.org/3.0/xproc/#p.if) - execute a subpipeline conditionally
* [p:choose](https://spec.xproc.org/3.0/xproc/#p.choose) - execute a subpipeline conditionally (`switch/case` operator)
* [p:for-each](https://spec.xproc.org/3.0/xproc/#p.for-each) - produce subpipeline results for each member of a sequence of inputs (XDM nodes or values treated as documents)
* [p:viewport](https://spec.xproc.org/3.0/xproc/#p.viewport) - reproduce outputs, except splicing subpipeline results in place of matched nodes (elements) in the input
* [p:try](https://spec.xproc.org/3.0/xproc/#p.try) - execute a subpipeline and deliver its results, or if it fails, run a fallback subpipeline given in a `p:catch`

All other steps are atomic steps. A survey of built-in atomic steps [has been offered earlier](../walkthrough/walkthrough_219_src.html); additionally they are well-indexed [in this repository](../../../projects/xproc-doc/out/repository-step-list.html) (generated with [XProc](../../../projects/xproc-doc/XPROC-STEP-INDEX-HTML.xpl)) and [on line](https://xprocref.org/index.html) (by Erik Siegel). But of course the atomic steps include steps you write and deploy yourself, or acquire from external libraries.

Additionally to these elements, XProc subpipelines may contain variable declarations (`p:variable`) and documentation (`p:documentation`), as noted.

## Namespaces and extension steps

XML Namespaces is [the topic that will not go away](oscal-convert_350_src.html).

We recognize steps because we either recognize them by name - for standard steps in the `p:` (XProc) namespace such as `p:filter` and `p:add-attribute` - or sometimes by process of elimination – because they cannot be anything else. This is because extension steps, whether written or acquired, can be named anything. Fortunately, extension steps in XProc take the form of elements in an *extension namespace*. Generally speaking, that is, any element not prefixed with `p:` is treated as out of scope for XProc and to be ignored, while subject to evaluation as an extension.

But this is an important category, since such extensions may include XProc steps whose functioning is core to the pipeline as a whole.
<details><summary>Question: Where are extension steps used in the XProcs run so far?</summary>

One answer: The [XSpec smoke test](./../../../smoketest/TEST-XSPEC.xpl) calls an extension step named `ox:execute-xspec`, defined in an imported pipeline. In this document, the prefix `ox` is bound to a utility namespace, `http://csrc.nist.gov/ns/oscal-xproc3`.

In an XProc pipeline (library or step declaration) one may also see additional namespaces, including:

* The namespaces needed for XSLT, XSD, or other supported technology
* One or more namespaces deployed by the XProc author to support either steps or internal operations (for example, XSLT functions)
* The namespace `http://www.w3.org/ns/xproc-step`, usually associated with the name prefix `c:`. This namespace is designated by XProc in order to help standardize the interfaces (inputs and outputs) supported by standard steps.
* The namespace `http://www.w3.org/ns/xproc-error`, for XProc's error reportingThese declarations (often but not always at the top of the document) are critically important for XPath and hence for the correct operation of your pipelines. See [the specification](https://spec.xproc.org/3.0/xproc/#namespaces) for more information.</details>

## Schema for XProc 3.0

See coverage of [XProc, XML and XDM (the                XML Data Model)](../walkthrough/walkthrough_219.md) in the prior lesson unit for a link to the schema for XProc.
