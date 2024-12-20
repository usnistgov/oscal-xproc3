# OSCAL in XProc - tutorial

## Goals

Capability to download and run XProc pipelines to perform useful applications for OSCAL, the Open Security Controls Assessment Language.

Foundation for further work with XML and XSLT.

Understanding of the current state of the art with respect to XML technologies, especially within the OSCAL and systems security context, and including any identified limitations (if any).

Address primarily OSCAL users but potentially any users of XProc.

Provide useful information to readers at different levels, whether it be technical background, or need-to-know technical details.

## Course Prerequisites

- Comfortable installing and running tools from the command line (Linux or Windows)
- Familiar with XML on at least one platform, or ready to learn
- Comfortable with Github (cloning or forking repositories)
- Have Java (v8/11) installed and working

## Sketch

This tutorial is designed to offer a self-guided tour for those unable to get live help. By following instructions carefully (and assuming requisite background), you should be able to make things work, understand the moving parts, and determine what to research next.

However, the resources offered are also intended to be available for discussion, whether in formal or informal training sessions among professionals, academics or amateur/freelancers. In development, we will be keeping the solo autodidact in mind. But we also take note when we see opportunities for discussion and consideration of differing perspectives.

Not only is there no rule against 'borrowing' from or adapting this tutorial or part of it: that is part of the idea. (Credit your sources as always.)

As noted in the readme, there are several ways to work the sequence.

Even the most casual readers will benefit from doing the **101** sequence exercises, which require no coding, just operation of the tools.

### Production

The lessons are written as a set of 'lesson units' each of which contains multiple (usually three) approaches to lesson material.

Each lesson entails reading followed by a set of more or less open-ended 'play' exercises. Their source code is maintained in XHTML, using a small subset of tags validated against a strict rule set.

[An XProc pipeline](PRODUCE-TUTORIAL-MARKDOWN.xpl) is then used to produce Markdown pages.

Results of this process are written into the [sequence](sequence/) folder. Within this folder, the lessons are offered in a sequence, as marshalled by the pipeline. This indirect mapping between source lesson units and the lesson sequence gives us the ability to reconfigure the sequence easily, either to rearrange or to extend and edit when new or different lesson units are wanted.

Files in this folder are overwritten by the tutorial production sequence, so keep your copies or clones safe by planting them elsewhere.

### Lesson sequence

[A directory to the lesson sequence is updated dynamically (using XProc)](sequence/lesson-sequence.md)

A provisional working plan for the sequence appears below. (The current sequence published can be compared to discern the gap between actuality and aspiration.) While lessons build from one to the next they are designed for a certain degree of mix-and-match, like the projects themselves.

For convenience, each lesson unit focuses on a project (as noted).

- setup
- unpack (survey of files used in setup)
- oscal-convert
- oscal-validate
- oscal-transform
- oscal-publish
- metaschema-analysis
- xproc-files (including zipping)
- xproc-document - covering xproc-doc
- xproc-validate - covering Schematron
- xproc-repo - ci/cd, regression testing
- xproc-xspec
- xproc-debug
- tutorial-publish

### Equipment


You will be happy to have a developer's or data analyst's setup:

- Command line with bash or Windows (cmd/Powershell)

- File system browser i.e. Windows Explorer or Linux desktop
  - or you are awesome with the CL!
  
- Programmer's text editor for light editing
  XML capabilities are awesome but not essential

- Web browser and other commodity Internet tools
