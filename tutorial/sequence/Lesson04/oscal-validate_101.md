

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [/tutorial/source/oscal-validate/oscal-validate_101_src.html](../../../tutorial/source/oscal-validate/oscal-validate_101_src.html).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 101: Seeing valid OSCAL

## Goals

Run pipelines that perform OSCAL schema validation, determining the conformance of your OSCAL files to the rules defined by an appropriate schema.

See how these are wired up in XProc, along with a sense of the complexity, tradeoffs and possibilities.

Gain some sense of wider issues related to schemas, schema evolution, data set regularity and predictability.

## Prerequisites

You have succeeded in prior exercises, including tools installation and setup.

 You know what OSCAL is and [what                   validation means](https://pages.nist.gov/OSCAL/resources/concepts/validation/) in the context of XML and data processing. You are aware of the existence of the OSCAL schemas to define syntax for its models in XML and in JSON.

## Resources

This unit relies on the [oscal-validate project](../../../projects/oscal-validate/readme.md) in this repository, with its files. Like other projects this one may have installation or setup pipelines to run.

Additionally if you have your own OSCAL to bring, especially OSCAL catalogs, bring them along.

Learners who are completely new to XML may find themselves in deep, quite soon. Then too, and in any case, without a problem of your own to solve, any demonstration here will be very abstract. Counter these problems with more resources:

* Work closely with a partner who can bring the data
* Reach out via Github Discussions with questions

## Step one: validate some OSCAL XML

The project contains pipelines that perform validation. Any description that appears here may go out of date, so check everything stated in the tutorial coverage against the actual files.

### Boldly coding

There are those who will look at a screen with a traceback with equanimity and dispassion - and those who will recoil. Maybe you are one of the fearless, maybe even one of the curious. Open the pipeline code in a programmer's text editor or IDE (integrated development environment) and get a sense of just how malleable it is.

XML comment syntax takes the form of angle-bracketed text with dashes (hyphens) and a bang: `<!– -->`. You will see comments throughout the code examples, sometimes as inline documentation, and sometimes for entire blocks of inactive code.

The intrepid explorer will try both *tweaking*, around the edges, then *adapting*, with new ideas.

The best of it is, as you learn how **a traceback is a tasty treat**, you enter a virtuous learning cycle. Repair a few bugs and you might get a taste for it. (Try the [102 Lesson unit ](oscal-validate_102.md))

If you'd rather keep your feet dry, advance to the next Lesson.

## Step two: validate and report

Schema validation is an automated process, but it is typically done not for its own sake, but rather as a preliminary to some other kind of processing, data analysis or manipulation. Accordingly a validator is frequently designed to be deployed silently - it only makes noise (emits errors or exceptions) if and as problems arise. Silence is good news when it comes to validators.

However, we also have a step that instead of ending silently, reports summary results.

### Optional: confirm the validation

## Step three: Run a batch validator

![ugly-traceback.png](ugly-traceback.png)

TODO Two ways: separate pipeline; and single pipeline; also a 'switcher' pipeline?

 Also see 102 for a pipeline to digest results of batch validation plus see field testing.

## What could possibly go wrong?

As always, determining early whether a problem can be solved or mitigated at home, versus when it requires some kind of external intervention, is key.

Fortunately many of the issues that can prevent validation processes from working are the same issues that prevent processing in general, and as such are recognizable from the same tracebacks.

If you do not yet understand the critical distinction between syntactic correctness or &ldquo;well-formedness&rdquo;, and validity against the rules stipulated by a model, check out [the OSCAL web site on that             topic](https://pages.nist.gov/OSCAL/resources/concepts/validation/).

A syntax error will typically produce a similar or the same error in a validation process as it does in any process, inasmuch as a syntax error prevents any kind of processing to be conducted dependably (by a deterministic process). As usual in such cases, expect to see console tracebacks and error messages when things go wrong (resources are unavailable or out of order), but not process outputs, whether messages or files.

For the same reason, this class of problems is usually found early in pipeline development. Once a pipeline is running with tools operating and configured properly, this problem goes away. A developer breaking new ground still must be able to recognize them.

The more interesting class of problems is what are called &ldquo;validation errors&rdquo;, which somewhat confusingly represents that class of problems that result not from files that are syntactically erroneous and therefore cannot be read, but more subltly, in data instances that can be read, but that when read, are found to fail to conform to expectations, as expressed in an applicable rules set.

Such a rules set is called a &ldquo;schema&rdquo; and deploying a schema to impose regularity and predictability over an open-ended body of data – including data that has not yet been created – is a primary responsibility of an entity that seeks to define an interoperable language, supporting robust data interchange across organizational boundaries.

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
