

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [../../source/oscal-produce/oscal-produce_102_src.html](../../source/oscal-produce/oscal-produce_102_src.html).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 102: Producing OSCAL from unrefined inputs

## Goals

Learn about the internals of XML-based data extraction and mapping processes, what we call an &ldquo;uphill&rdquo; data conversion, data refinement or enhancement.

Get a chance to see how XSLT and other steps together give XProc ways to address conversion problems at appropriate levels of scale and abstraction, both for general and for specific or narrow cases.

See examples of how XProc pipelines can integrate validation processes to provide runtime quality assurance and regression testing.

## Prerequisites

You are familiar with the idea and probably the practice of running XProc pipelines, as described in earlier lessons.

You have understood from [preceding lesson unit](oscal-produce_101.md) its explanations of the examples discussed here, in greater depth.

## Resources

Like the preceding lesson unit, this one relies on XProc examples in this repository:

* USDS Playbook – 13 OSCAL controls (high level) derived from a simple web page produced by the US Digital Service (downloaded January 2025).
* NIST SP 800-171 from NIST Computer Cybersecurity and Privacy Reference Tool (CPRT) JSON (acquired December 2024)
* US Army Field Manual 6-22 - via HTML from PDF source, with NISO STS format as an additional result (acquired December 2024)

*Caution: all produced versions of these public documents are non-normative, unauthorized (lawful within terms of reuse in the public domain) and not for publication, being produced only for demonstration of tools and capabilities.*

## Interactive debugging in XProc

Mentioned before, potentially worth mentioning again:

* `p:store` can be used anywhere to save the document in the pipeline as it is at that point. Use it to save both interim and final results.
* `@message` (a `message` attribute) can be used on most any XProc step, including `p:identity`, to report on XProc at any point in a pipeline's execution.
* `@use-when` with a value returning a Boolean (true or false) can be used to switch steps on or off, in support of debugging or normal operations.
* XML comments can always be used to hide code from the XProc processor.

## Testing, both results and processes

Both automated (replicable) and non-automated (effortful or irreplicable) test methodologies can be applied.

In the non-automated category we include simple inspections of results.

We testing processes, in contrast, by actively intervening, making adjustments, and comparing results.

We can automate testing of processes by deploying schema or Schematron validation. These work similarly in that they provide sets of rules, more or less comprehensive, governing use of element structures within XML. Using either a standard schema (which can be stipulated as a benchmark or reference point for assessment), or a custom schema made for the case (and similarly subject to its own functional requirements), with XProc we can defend against regression by throwing errors if inputs start varying from expectations.

Schema validation also helps warrant results for fitness for exchange with partners using the same standards and XML vocabularies.

## XProc so far: a survey

A [worksheet XProc](../../worksheets/XProc-POLL_worksheet.xpl) is provided with an XSLT transformation that polls a set of XProc documents to produce a list of XProc elements appearing, with their files. This list was then edited by hand and spliced into this page, reorganized and enhanced with comments. Keep in mind this listing is likely to be out of date if the pipelines have changed.

For more links:

* [XProc step list](../../../projects/xproc-doc/out/xproc-step-list.html) generated using XProc
* Erik Siegel's [XProcRef](https://xprocref.org/) reference resource

### Top-level, imports and prologue

####  `p:declare-step`

The top-level (document) element for an XProc step declaration – either the document element of the XProc file, or (in none of these cases) directly contained inside `/p:library` (a step defined for import with a library) or `/p:declare-step` (for a step defined for local use in this pipeline only).

*  [NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl](../../../projects/oscal-import/NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl) 
*  [USDS-2024_Playbook/OSCAL-PLAYBOOK.xpl](../../../projects/oscal-import/USDS-2024_Playbook/OSCAL-PLAYBOOK.xpl) 
*  [USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl](../../../projects/oscal-import/USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl) 

####  

####  `p:import` 

Importing a step from another XProc XML file makes that step available as an extensions step in a pipeline. The named *type* of the step (given as `p:declare-step/@type` is provided as its invocation. This is typically a namespace-qualified name such as `ox:validation-summarize`, for the step defined in the imported pipeline [validation-summarize.xpl](../../../projects/oscal-import/USArmy_FM6-22/src/validation-summarize.xpl).

*  [USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl](../../../projects/oscal-import/USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl) 

####  `p:option` 

An XProc *option* permits a named value to be defined, like a variable, except exposed such that it can be set by the processor at runtime, overriding a default value. (XSLT practitioners will be reminded of `xsl:param` at the top level declaring a stylesheet parameter: this is XProc's equivalent.

In one pipeline here an option is made available in the XProc pipeline to turn on a tracing feature. In the other, options are used to set values that might be reset for a different use case.

*  [NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl](../../../projects/oscal-import/NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl) 
*  [USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl](../../../projects/oscal-import/USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl) – set the `writing-all` to `select="false()"` to turn off diagnostics (in the form of &ldquo;snapshots&rdquo; of interim document states, saved in a `temp` directory)

####  `p:input` 

A top-level binding for inputs to the pipeline. One pipeline among these examples binds its source using this top-level configuration. The other examples load their inputs dynamically using `p:load`.

*  [NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl](../../../projects/oscal-import/NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl) 

####  `p:output` 

All three pipelines produce outputs on the file system using `p:store`. Additionally, one is configured with an output port, where it exposes the aggregated results of several validation checks over process results.

*  [USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl](../../../projects/oscal-import/USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl) 

When an output port is configured (in a step or compound step) without an explicit port binding (via `@pipe` or `p:pipe`), it will bind implicitly to the primary output port of the last step in the pipeline (typically `result`, but often unstated).

### Steps

All three pipelines:

*  [NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl](../../../projects/oscal-import/NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl) 
*  [USDS-2024_Playbook/OSCAL-PLAYBOOK.xpl](../../../projects/oscal-import/USDS-2024_Playbook/OSCAL-PLAYBOOK.xpl) 
*  [USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl](../../../projects/oscal-import/USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl) 

####  `p:identity` 

This step passes documents on the `source` (implicit primary) port through, unchanged. This element is commonly used:

* To provide messages to the user at runtime.
* To provide a stable reference for an output port binding, as a discrete step, which can be positioned or moved among other steps.

####  `p:insert` 

####  `p:store` 

####  `p:validate-with-relax-ng` 

####  `p:xslt` 

In two of the three pipelines:


*  [USDS-2024_Playbook/OSCAL-PLAYBOOK.xpl](../../../projects/oscal-import/USDS-2024_Playbook/OSCAL-PLAYBOOK.xpl) 
*  [USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl](../../../projects/oscal-import/USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl) 

####  `p:choose`, `p:when`, `p:otherwise`

####  `p:load` 

####  `p:validate-with-xml-schema` 


*  [NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl](../../../projects/oscal-import/NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl) 
*  [USDS-2024_Playbook/OSCAL-PLAYBOOK.xpl](../../../projects/oscal-import/USDS-2024_Playbook/OSCAL-PLAYBOOK.xpl) 

####  `p:group` 

A compound step, for providing logical grouping to other steps. Without a `p:output` defined, a group has an implicit primary output bound to the result of its last contained step. Alternatively, one or more output ports defined on a group can be bound to results of steps run inside the group.

####  `p:cast-content-type` 

####  `p:namespace-delete` 

####  `p:namespace-rename` 


*  [NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl](../../../projects/oscal-import/NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl) 
*  [USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl](../../../projects/oscal-import/USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl) 

####  `p:if` 

Reassuringly, this element contains a subpipeline (step sequence) to be executed only if the given test evaluates as `true()`.

Compare this to the use of `@use-when` on a step - only statically known values can be used in `@use-when`, that is, values that can be determined by the pipeline processor from examining the pipeline, without executing it. Any expression can be given on `p:if/@test`, to be evaluated dynamically.

####  `p:string-replace` 

This step operates on plain text documents, not XML or HTML. One of its uses is cleanup tasks especially whitespace cleanup (rewriting cosmetic whitespace).

####  `p:validate-with-schematron` 

This step tests a document in process (i.e., the document in the state where this step is used) against a given Schematron, designated on the `schema` secondary input port.

The step emits a secondary result port named `report` containing the results of running the Schematron. This report may contain messages considered to indicate validation errors – XProc lets us decide.

Used in [USDS-2024_Playbook/OSCAL-PLAYBOOK.xpl](../../../projects/oscal-import/USDS-2024_Playbook/OSCAL-PLAYBOOK.xpl) only:

####  `p:add-attribute` 

If an attribute value can be determined statically for a matching element, this step can be used to add it. The value of the `attribute-value` should be a string (perhaps including attribute value templating), not an XPath that should result in a string – for that, use `p:label-elements`.

####  `p:error` 

Producing a runtime error is a reasonable way to end a process gone wrong for any reason.

####  `p:filter` 

A utility step for removing all but a matching set of elements within the document sequence.

####  `p:label-elements` 

This step is somewhat similar to `p:add-attribute`, but a little more flexible in that it can label elements with results of XPath expressions evaluated in their own (document) context.

####  `p:uuid` 

A step for generating random or workably-random UUID values (v4 UUIDs). Another pipeline in the repository uses XSLT logic for this purpose, in a more complex use case. For a simple case the XProc step works well.

In [NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl](../../../projects/oscal-import/NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl) only:

####  `p:delete` 

The mirror image of `p:filter`, this step indicates that elements should be removed.

####  `p:replace` 

This step matches branches of XML and replaces them with XML given on the `replacement` port.

In the production of SP 800-171 in OSCAL, this step is put to work to promote structured plain text syntax into an XML element structure, via a rewrite-and-parse strategy.

####  `p:try`, `p:catch`

XProc supports defining appropriate error handling and error trapping. This has a wide range of applications in XProc, for example for dynamically testing inputs against contracts on the fly, or for accounting for differences in XProc support between different processors.

####  `p:viewport` 

A compound step somewhat analogous in operation to an XSLT template, this step works like `p:replace`, except the replacement for matched elements is not provided on a port, but instead built by executing an entire subpipeline (step sequence).

In [USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl](../../../projects/oscal-import/USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl) only:

####  `p:wrap-sequence` 

This step aggregates a sequence of documents on its `source` port and collects them into a single XML document, whose name is given as `@wrapper`.

An extension step:

####  `ox:validation-summarize`

This step produces a plain-text summary of validation findings bound to the `source` input port. The validation findings can be in XML dialects (SVRL, XVRL etc.) delivered by commodity tools, negotiated internally and unified by the step.

*  [USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl](../../../projects/oscal-import/USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl) 

### Connectors and plumbing

Defining a variable:

####  `p:variable` 

This element may appear anywhere after the prologue, at the same level as a step. It defines a variable and binds a value to it for later use.

*  [NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl](../../../projects/oscal-import/NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl) 
*  [USDS-2024_Playbook/OSCAL-PLAYBOOK.xpl](../../../projects/oscal-import/USDS-2024_Playbook/OSCAL-PLAYBOOK.xpl) 
*  [USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl](../../../projects/oscal-import/USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl) 

Configuring a step …

####  `p:with-input` 

Most steps do not have an explicit `p:with-input` since the primary input is set implicitly to the primary output of the preceding step.

You will see `p:with-input` any time a step either starts with a new input, or needs some input in addition to its primary input. The `@port` given on `p:with-input`, if any, designates how the input relates to the step - when no `@port` is named, the primary input is assumed, usually named `source`.

*  [NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl](../../../projects/oscal-import/NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl) 
*  [USDS-2024_Playbook/OSCAL-PLAYBOOK.xpl](../../../projects/oscal-import/USDS-2024_Playbook/OSCAL-PLAYBOOK.xpl) 
*  [USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl](../../../projects/oscal-import/USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl) 

####  `p:with-option` 

Sets an option for a step, as defined by the step. Since options can also be set using attribute syntax, this is a relatively rare element in XProc.

*  [USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl](../../../projects/oscal-import/USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl) 

Bindings to connections – appearing inside `p:input`, `p:with-input`, or (in the case of `p:pipe`) `p:output`:

####  `p:document` 

Binds a document to a port, retrieved using `@href`. URIs using the `file:` and `http/s:` schemes are both supported by XProc engines for resource retrieval. Relative paths work fine.

*  [NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl](../../../projects/oscal-import/NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl) 
*  [USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl](../../../projects/oscal-import/USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl) 

####  `p:inline` 

Presents a literal document to be bound to the input. Take note, as whitespace inside this element is taken to be part of the contents bound to the port. More info available in the Specification.

*  [NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl](../../../projects/oscal-import/NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl) 
*  [USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl](../../../projects/oscal-import/USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl) 

####  `p:empty` 

Makes explicit that a port is bound to an empty sequence of documents – this is permissible, and sometimes useful, on ports set with `sequence="true()".`

*  [USDS-2024_Playbook/OSCAL-PLAYBOOK.xpl](../../../projects/oscal-import/USDS-2024_Playbook/OSCAL-PLAYBOOK.xpl) 

####  `p:pipe` 

Makes an explicit connection to an output port on another step, as indicated. A shorthand for this element is a `@pipe` attribute on its parent `p:with-input` or `p:output`.

*  [USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl](../../../projects/oscal-import/USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl) 

## TBD: for discussion

* Entropy-removing upconversion to semantic target, followed by downhill conversion - declarative encoding as 'potential energy' magnified by the degree to which consumers have prior knowledge of new formats
* Mix of generic and ad-hoc processes (tailored per pipeline)
* XProc or XSLT? (Or XQuery?) XSLT, in line or out of line?
* Transparency and traceability of deterministic, well-defined and specified processes
* Scaling and scalability: complexity, throughput (quantity), variability, time horizons - testing one-off cases vs production pipelines
