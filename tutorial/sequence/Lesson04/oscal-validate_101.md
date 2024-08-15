> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [/tutorial/source/oscal-validate/oscal-validate_101_src.html](../../../tutorial/source/oscal-validate/oscal-validate_101_src.html).
> 
> To create a persistent copy (for example, for purposes of annotation) save this file out elsewhere, and edit the copy.

# 101: Validating OSCAL

## Goals

Apply XProc for OSCAL schema validation, to determine the conformance of your OSCAL files to the rules defined by an appropriate schema.

Gain some sense of wider issues related to schemas, schema evolution, data set regularity and predictability.

## Prerequisites

You have succeeded in prior exercises, including tools installation and setup.

## Resources

This unit relies on the [oscal-validate project](../../../projects/oscal-validate/readme.md) in this repository, with its files. Like other projects this one may have installation or setup pipelines to run.

## Step one: validate some OSCAL XML

## Step two: validating sets of documents, handling outputs

TODO Two ways: separate pipeline; and single pipeline; also a 'switcher' pipeline?

 Also see 102 for a pipeline to digest results of batch validation plus see field testing.

## What could possibly go wrong?

As always, determining early whether a problem can be solved or mitigated at home, versus when it requires some kind of external intervention, is key.

Fortunately many of the issues that can prevent validation processes from working are the same issues that prevent processing in general, and as such are recognizable from the same tracebacks. If a file is missing or if it doesn't parse properly at all (i.e., if it proves not to be XML or JSON at all despite representations), you already know how to recognize and (often) repair that.

A syntax error in a file to be validated, that is, should produce a similar or the same error in processing that you will see from trying to transform or convert that same file, or perform any processing, inasmuch as a syntax error prevents any kind of processing at all. As usual in such cases, expect to see console tracebacks and error messages, but not process outputs (either messages or files).

For the same reason, this class of problems is usually found early in pipeline development. Once a pipeline is running with tools operating and configured properly, this problem goes away. A developer breaking new ground still must be able to recognize them.

The more interesting class of problems is what are called &ldquo;validation errors&rdquo;, which somewhat confusingly represents that class of problems that result not from files that are syntactically erroneous and therefore cannot be read, but more subltly, in data instances that can be read, but that when read, are found to fail to conform to expectations, as expressed in an applicable rules set.

Such a rules set is called a &ldquo;schema&rdquo; and deploying a schema to impose regularity and predictability over an open-ended body of data &mdash; including data that has not yet been created &mdash; is a primary responsibility of an entity that seeks to define an interoperable language, supporting robust data interchange across organizational boundaries.

### When you know your schema

### When you must determine a schema

## What is this schema?

### Schemas and document types

Schemas turn an open-world problem into a closed-world problem, giving it boundaries and helping to make it manageable. It traces the outline of the expected. Anything it does not account for can be considered out of consideration, other things being equal. As such it is an extremely useful &ldquo;touchstone process&rdquo; (it might be called) that reveal early what kinds of risks there are, if any (and only if risks of wasted effort and resources), from processing inputs not fit, defective or &ldquo;to spec&rdquo;. There are many ways of designing and building information processing systems with and around schemas, and many types of schemas for specific technologies. Even within the relatively narrow context of XML, there are many schema validation technologies available, and many approaches to validation using different kinds of schemas or schemas in different ways.

Even within this complexity, however, a certain regularity is accomplished by the most typical use case and application for a schema, broadly, namely to define and assert a *document type* for an instance or recognized entity evaluated by an XML processor. XML documents, that is to say, share many general characteristics (for example rules of syntax), while in other respects their differences are critical. In order that we can distinguish, for example, between a document as a **bill** (or invoice) and a **receipt** (two things that may superficially look somewhat similar), we can distinguish between apparently small but critical distinctions that define and characterize them - the rules they follow.

OSCAL deploys a range of models, each with its own schemas (for XML and JSON variants of the model). Each model describes a different OSCAL type.

## Critique so far

At time of writing this tutorial is very rough, with very much extension and refinement remaining to be done.

Tell us what we are doing right and wrong so far. Help us understand where things need to be explained, or better, illuminated by saying less - where is it too thick.

## 102: Validation results and XProc outputs

other workflows and orchestrations - using schema validation as gateway 

setting schema validation to require-valid=false and using try/catch to trap - as a way of annotating instances on the way through (schema-field-tests)

## 102: XProc exception handling

other workflows and orchestrations - using schema validation as gateway 

setting schema validation to require-valid=false and using try/catch to trap - as a way of annotating instances on the way through (schema-field-tests)
