# OSCAL in XProc - tutorial

## Goals

Capability to download and run XProc pipelines to perform useful applications for OSCAL, the Open Security Controls Assessment Language.

Foundation for further work with XML and XSLT.

Understanding of the current state of the art wrt XML technologies.

## Course Prerequisites

- Comfortable installing and running tools from the command line (Linux or Windows)
- Familiar with XML on at least one platform, or ready to learn
- Comfortable with Github (cloning or forking repositories)
- Have Java (v8/11) installed and working

## Sketch

This tutorial is designed to offer a self-guided tour for those unable to get live help. By following instructions carefully (and assuming requisite background), you should be able to make things work, understand the moving parts, and determine what to research next.

However, the resources offered are also intended to be available for discussion, whether in formal or informal training sessions among professionals, academics or amateur/freelancers. In development, we will be keeping the solo autodidact in mind -- but we also take note when we see opportunities for discussion and consideration of differing perspectives.

Not only is there no rule against 'borrowing' from or adapting this tutorial or part of it -- that is part of the idea. (Credit your sources as always.)

As noted in the readme, there are several ways to work the sequence.

Even the most casual readers will benefit from doing the **101** sequence exercises, which require no coding, just operation of the tools.

### Lesson sequence

- setup
- unpack (survey of files used in setup)
- oscal-convert
- oscal-validate
- oscal-transform
- oscal-publish
- xproc-files (including zipping)
- xproc-document - covering xproc-doc
- xproc-validate - covering Schematron
- xproc-repo - ci/cd, regression testing
- xproc-xspec
- xproc-debug
- tutorial-publish

### Equipment

Command line with bash or Windows (cmd/Powershell)

File system browser i.e. Windows Explorer or Linux desktop
  - or you are awesome with the CL!
  
Programmer's text editor for light editing
  XML capabilities are awesome but not essential



#### notes

Lesson_01 - 'setup' Setup and smoke tests [slides on XProc background and context]

Lesson_02 - 'unpack' Setup and smoke test pipelines - a look inside - what to look for inside a pipeline, how to research XProc [slides, also step indexes]
  namespaces
  header: options and ports
  steps
  
  recognize an atomic step by the fact that it has no elements except
    p:with-input and p:with-option (right?)

  whereas compound steps have subpipelines
  
  core compound steps include:
    for-each
    try/catch
    choose/when/otherwise, if
    group - handy wrapper
    viewport - works on matched (selected) subtrees of input

  core atomic steps - see references
  declared steps - 'ox' namespace
        

Lesson_03 - 'oscal-convert' An OSCAL XML-to-JSON conversion pipeline [slides on XML and JSON in XPath 3.1] - show rendering btw JSON and XML step by step

Lesson_04 - 'oscal-validate' OSCAL Validation - singles and batches [slides on validation, field testing]
  OSCAL with various schemas
  OSCAL with Schematron
    (run the Schematron smoke test to be sure you have it)

Lesson_05 - 'oscal-transform' OSCAL transformation - XSLT for HTML [slides on rendering pipelines]; also profile resolution

  advanced - use a defective catalog e.g. cat catalog missing labels
    how to mitigate defects:
      change source
        upstream or on the fly
      change XSLT
        layer over XSLT
        patch XSLT going through



Lesson_06 - 'xproc-files' XProc file management [slides on file and zip capabilities]
  super useful among other reasons b/c .docx, .xslx, .otx and .epub formats are all zip archives
  
Advanced XProc

Lesson_07 - 'xproc-document' XProc reflection - pipelines to document XProc
            
Lesson_08 - 'xproc-validate' Validating XProc with Schematron


Lesson_09 - 'xproc-repo' Unpacking the repository / CI/CD, regression testing and publishing workflows

Lesson_10 - XSpec for XSLT under XProc
 
Lesson_11 Interactive XProc
   debugging and analysis techniques
     writing interim results
     exposing on ports
     filtering what is exposed

Each lesson
  Objective
  Resources
  Lesson steps
    assumptions/prerequisites
    procedure
    observations/provocations
  Observations
  Questions and feedback
  (Background remarks in callouts?)

## Background and context (to cover)

- Some history and roots
- XProc 3.0+, XSLT 3.0./3.1, XQuery 3.1 - W3C standards and beyond
- Available transformation engines (Saxon) and databases (BaseX)
- Features supporting JSON and other non-XML -- applicability in heterogeneous data domains (e.g. systems security)
- Available resources and tools including OSCAL resources
- Support for data not in XML - JSON, iXML parsing

## Draft tutorial coverage

### XProc as pipelining language
  What is a pipelining language
  Alternatives for pipelining
    historical and current
      Ant, `make`, batch and shell scripts, proprietary stacks....
  XProc 1.0
    XML Calabash
    Adoption of XProc 1.0 - or not (why not?)
      Too niche
      XML only
      no XPath 3.0/3.1
      The syntax was sometimes vexing even for XMLers (just ask)
      Problem already dealt with in most places that had it
  XProc 3.0
    Morgana processor
    Others to come?

### XProc resources

  Book by Erik Siegel
  Mailing list 
  XPath and XPath resources
  XProc specifications - source
  https://github.com/xproc/3.0-steps/blob/master/steps/src/main/xml/specification.xml

#### XProc self-runners? XProc spelunking

Concept: generate a suite of XProc step definitions as demo tests

Each drops a different step into a boilerplate XProc, for execution, to test that step with default settings.

Then we try running them and diffing the results with the inputs.

We document outputs and problems encountered.

In a second pass we can mitigate known issues for example providing schemas to schema validation steps.

Over time this can be built into demonstrations.

### XProc for users

As an XProc "homeowner" what do you need to know?
  How things work, basic operation and maintenance
  When to call the plumber or electrician

Premises: you know the file system, the resources and the operations to perform
  You will not be writing XSLT
  (Or only in collaboration)

1. Nullary or 'standalone' XProc
    All inputs are hard-wired
    All results are directed or accounted for (connected or plugged)

2. Making sense of XPath
  $variable references
  path expressions
  XProc functions e.g. p:document-property()
  XProc https://spec.xproc.org/master/head/xproc/#xpath-extension-functions  writeup by M Kraetke - https://xporc.net/xproc-tutorial/xprocs-xpath-extension-functions/
  
3. How pipelines work

Chains
  principle is simple, same as functional composition a(.) => b(.) => c(.)
  
  they can be long
  order of steps can matter
  we can start with an a() if we want a to produce (not modify)
  but a(.) => b() permits dropping a() and also .

Branches

multiple inputs the same - collections of alike documents
  to be aggregated or analyzed as a group

multiple inputs different e.g. doc + schema

multiple outputs e.g. results and reports

Compositional logic
  mix and match

Functional logic and side-effects
  Functional mappings
    map/filter/reduce can be executed 'atemporally'
  Side effects introduce sequential dependencies (something has to happen)
  In XProc, we use these together
    e.g. `p:input/p:document` but also `p:load`
      exposing output ports vs `p:store`
  
XML, plain text, JSON and other inputs

Intro to steps, ports and pipes
    Think of ports as having 'polarity' they can be only one of `input` or `output`
      which they are affects how they plug into other steps

### XProc for developers

Premise: New to XProc but not new to the problem space
  You know enough XSLT or XQuery to be dangerous
  You expect you might be writing your own steps

How to do that
  Namespaces

Names and step types
  Assign same step types only to pipelines with the same 'signature'
    (this is in principle testable)

Capturing and redirecting pipeline results

Messages

`p:sink`

`p:try`/`p:catch`

Inline XSLT
  TVTs and AVTs in embedded code!
  
Complete list of steps - see xproc-step-list.html and the pipelines that produce it

Anatomy of a step

Validating XProc
  Your house rules

### Test-driven development

Still testing our XProc the old-fashioned way
  interactive
  with friends

But with XSLT and XQuery we have now advanced

TDD - what and why

XSpec
  and XSLT
  XQuery
  Schematron

Running XSpec in XProc

XProc, XSpec and XSLT - the development loop
  entry to XSLT

XSpec over XProc - what will it take?

### OSCAL Projects: a self-guided tour

Doing our best to document things for you as you come across them.

Note - in some places there may be 'road work' going on
  when resources move, for example, things break and need repair before they work again


Here we should start with a proposed visiting order?

