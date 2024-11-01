# Development punchlist

With working notes.

## Github

- Issues templates for question/bug/request
- Discussion board

## Reference links / dashboard

Now see [xproc-dashboard.md](xproc-dashboard.md)

## Exercises

Now run pipeline PRODUCE-TUTORIAL-TOC.xpl to produce a [table of contents](sequence/lesson-sequence.md) (in Markdown) to exercises.

To add to the Toc, edit the pipeline.

To add to the production pipeline, edit PRODUCE-TUTORIAL-MARKDOWN.xpl

## End to end dependencies

- review phase:
  - Commends Day? (week?) go through all the comments
      consider factoring out into p:documentation / tooling
  - 101 sequence is inspection and observation (only)
  - 102 sequence is hands-on
  -  all 'Goals' in sequence, all 'Resources' in sequence, etc
  - where can we default e.g. `with-input` in place of `with-input[@port='source']` ? test all these ...
  - Review and normalize usage of 'i', 'b', 'em' and other inline elements?
- Top level Overview page about
  - Strategies for learning (breadth-first or depth-first)
  - **Tools** - editor, XML IDE?
  - House rules; project and tutorial conventions
    - file naming, all-caps names for 'nullary' XProc
    - XPath syntax for references to XML, e.g. '@href'
- find and fix all TODO
- update / finish / close
   - `tutorial/outline.md`
   - `tutorial/readme.md`
   - `./README.md`
   - this file and any other .md files in `tutorial`
   - conclude this punchlist
- rewrite outline.md
- delete this file

---

# notes

XProc/XML intensives - specialized topics
  Namespaces in XML and XProc
  Pipes and ports: XProc connectors
  HREFs and file retrieval
    p:urify
    document-properties(.,'base-uri') and base-uri(.)
  How to Learn XPath
  XSLT Processing Model Quick Summary
  XQuery with XProc
  XProc and testing
    Smoke testing
    XSpec
  XProc-based TDD
    1. Analyze problem
    1. Patch using XProc to develop solution
    1. Migrate patch into codebase after testing
  "XProc style" and local rules
  XProc Quizzes
    Read an XProc and predict what it will do when run
    XProc harness for learning XSLT and XQuery?

Lesson_01 - 'setup' Setup and smoke tests [slides on XProc background and context]

Lesson_02 - 'unpack' Setup and smoke test pipelines - a look inside - what to look for inside a pipeline, how to research XProc [slides, also step indexes]
  namespaces
  header: options and ports
  steps
  
  recognize an atomic step by the fact that it has no elements except
    p:with-input and p:with-option (right?)

  whereas compound steps pull together multiple steps with pre-configured inputs to operate in special ways such as iterating (when performing a sequence for a set of inputs) as distinct from grouping, or try/catch, enabling the processor to pick up if a process errors or exceptions are flagged.
  
   There are only a few compound steps in the core step library: 
  
    for-each
    try/catch
    choose/when/otherwise, if
    group - handy wrapper
    viewport - works on matched (selected) subtrees of input

  core atomic steps - see references
  declared steps - 'ox' namespace
        

Lesson_03 - 'oscal-convert' An OSCAL XML-to-JSON conversion pipeline [slides on XML and JSON in XPath 3.1] - show rendering btw JSON and XML step by step

102 - debugging by writing intermediates
       p:store
      exposing on output ports
599 bonus exercise: convert JSON into XML, then apply a Schematron
      running a p:compare step - look-see
      introducing normalizers to isolate converter deltas

Lesson_04 - 'oscal-validate' OSCAL Validation - singles and batches [slides on validation, field testing]
  OSCAL with various schemas
  OSCAL with Schematron
    (run the Schematron smoke test to be sure you have it)

Lesson_05 - 'oscal-transform' OSCAL transformation - XSLT for HTML [slides on rendering pipelines]; also profile resolution

simple - try using p:uuid to replace OSCAL uuids

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
 
  - XSLT unit testing
  - conformance testing
 
Lesson_11 Interactive XProc
   debugging and analysis techniques
     writing interim results
     exposing on ports
     filtering what is exposed

More --

Integrating open-source XSLT
  for example TAN https://textalign.net/

General-purpose XML-to-JSON/JSON-to-XML testing harness
  compares round trips from any invoked process
     (XSLT-based)

XProc-based CMS? or better, 'content management' features without a CMS

XProc reading dynamically from the web? E.g. feeds and updates
  RSS/Atom? content syndication
    ie. a resource that updates while remaining stable
      address
      content types
    archive accessions, but does not delete
      'retractions' instead

XProc producing Github Issues digest from querying into Github Issues page?

Pulling in from wiki pages?

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

Capturing and redirecting pipeline results - binding ports at runtime

Messages

`p:sink`

`p:try`/`p:catch`

`@select` vs `@match` semantics, with running demo of a 'deep match'

`p:variable/p:pipe` for binding variables to intermediate and secondary outputs

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



