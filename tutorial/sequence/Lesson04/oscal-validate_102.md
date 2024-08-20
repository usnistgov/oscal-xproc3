> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [/tutorial/source/oscal-validate/oscal-validate_102_src.html](../../../tutorial/source/oscal-validate/oscal-validate_102_src.html).
> 
> To create a persistent copy (for example, for purposes of annotation) save this file out elsewhere, and edit the copy.

# 102: Validating OSCAL

## Goals

Apply XProc for OSCAL schema validation, to determine the conformance of your OSCAL files to the rules defined by an appropriate schema.

Gain some sense of wider issues related to schemas, schema evolution, data set regularity and predictability.

## Prerequisites

You have succeeded in prior exercises, including tools installation and setup. You know what OSCAL is and what &ldquo;validation&rdquo; means in the context of XML and data processing.

## Resources

This unit relies on the [oscal-validate project](../../../projects/oscal-validate/readme.md) in this repository, with its files. Like other projects this one may have installation or setup pipelines to run.

## Schema validation under XProc / code review

## validating sets of documents, handling outputs

TODO Two ways: separate pipeline; and single pipeline; also a 'switcher' pipeline?

 Also see 102 for a pipeline to digest results of batch validation plus see field testing.

[for 102] XProc 3.0 validation steps include an option `assert-valid` (takes a Boolean `true` or `false`), which configures how the step works when validation errors are encountered. This is essentially a switch between asking the XProc engine to stop with an error when inputs presented to the step show validation errors - often the preferred fail-safe solution for validity checks - or whether to continue processing the document, so as (for example) to survey it further or treat it somehow. Validation errors are reported back to the pipeline in either case - by virtue of validating, we will always get a report of where such errors occur. But with assert-valid off (`false`), if we wish we can, instead of quitting, continue with processing.

One reason to continue with processing is because we are aggregating validation results from a set of documents, so we do not want an error if any of them fails. Instead we wish only to validate them and to collect the reports.

See project [schema-field-tests](../../../projects/schema-field-tests/readme.md) for deeper coverage of validation, batch validation and schema testing.

### Rule of thumb - `assert-valid`

Use `assert-valid='true'` when the purpose of schema validation in a pipeline is as a screener, with the results to be processed further as input to a step. This reflects and enforces a logical dependency between the schema as a contract (enforceable by the assertion), and downstream processing built against the schema's models. It means that downstream processors are relieved thereby of an entire class of data processing errors, due to incorrect or inadequate or unforeseen inputs.

Use `assert-valid='false'` when a document is to be discarded after validation, while the results of validation - its reports, if any - are taken up. Typically this is done on files in entire collections, so halting the process and delivering an error is not in order for bad inputs that are detected in any case.

## Review: why validate?

The simplest reason we use schemas to validate documents is that it prevents certain kinds of errors that can be difficult to manage otherwise. Schema validation is part of the tool set of &ldquo;jigs and gauges&rdquo; we use to keep our models and our data aligned.

Schemas give us information subject to inferencing, such that when a given schema is applicable, it shows us (as designers and engineers) what is and can be known about our data, in general, and what is unknown, where are its dimensions of variance. A schema defines a boundary of in / legitimate, and out - illegitimate for our purposes and out of scope, however legitimate it may be otherwise. It 

## 102: Defining a pipeline step

## 102: Other schemas vs/and other models

The main reason it is useful to have all the OSCAL catalog validation in this project use the same step is that it consolidates control of which version, indeed which copy and location, of the OSCAL catalog schema (XSD) is to be used. Having such a single point of control means we can manage all the tools that use this logic together. If we wish to use an XProc validation step directly - hard-wiring a schema into a step - remains an option.

## 102: XProc exception handling

other workflows and orchestrations - using schema validation as gateway 

setting schema validation to require-valid=false and using try/catch to trap - as a way of annotating instances on the way through (schema-field-tests)

## 599: some XProc features
