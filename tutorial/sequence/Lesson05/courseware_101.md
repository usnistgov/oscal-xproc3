

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [../../source/courseware/courseware_101_src.html](../../source/courseware/courseware_101_src.html).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# Courseware 101: Producing this tutorial

## Goals

Understand better how this tutorial is produced.

See an example of a small but lightweight and scalable publishing system can be implemented in XProc and XSLT.

## Prerequisites

None.

Readers who wish not only to inspect and refresh tutorial contents, but also to edit or extend, or alter the tutorial pipelines, are invited to look at [the next                exercise (lesson unit)](courseware_219.md).

## Resources

* Everything in the course you have seen so far
* Everything else you have seen relating to XProc
* Your own problems
* Your own examples
* Tutorial production pipelines as described below

## Tutorial production pipelines

The source files for these tutorials are all stored in the repository in [a directory named                   source](../), and maintained in HTML format. The expectation is that all files will be represented as valid and complete HTML 5 in XML syntax, i.e. XHTML to be treated as an HTML document type. When composing the tutorial lessons, the author uses XML-based tools this rule (and others). However, not all files in this subdirectory are used as source materials; this is only where they are stored and maintained. Draft materials might appear here as well.

At the top of the tutorial structure, a file [lesson-plan.xml](../../lesson-plan.xml) is used as a publication driver or configuration file, when read (by means of XProc) as a sequence of links back to folders. Production is achieved by running pipelines that traverse the links, reading files and working appropriately. Each folder named as a `Lesson/@key` is read, with all HTML files surnamed `_src.html` from that folder considered to be tutorial source materials, in nominally alphabetic order. The tutorial as a whole is built by reading each of these files, converting it to Markdown (with adjustments), and producing indexes to the entire set, all done by writing files into the [sequence directory](sequence/). Such a Markdown file set can be read and edited in Github in the usual way, or refreshed by running a production pipeline again.

The authoring model and its design rationales as well as its tooling support, including automated proof checking under CI/CD, is described in a [subsequent                lesson unit](courseware_219.md). Authoring in HTML rather than Markdown provides all kinds of leverage for ad-hoc &ldquo;tutorial semantics&rdquo; especially with the help of a structured (tagless) editor.

Each of the pipelines described here performs a specific task with respect to tutorial production, except for one, a convenience or utility pipeline that runs all the others with a single invocation.

As always, pipelines should be provided internally with explanatory comments.

When reading and writing files to file systems, the usual security considerations apply.

### [PRODUCE-TUTORIAL-PREVIEW](../../PRODUCE-TUTORIAL-PREVIEW.xpl)

Generates a preview (reading) version of the tutorial, for proofing.

### [PRODUCE-TUTORIAL-MARKDOWN](../../PRODUCE-TUTORIAL-MARKDOWN.xpl)

Generates Markdown from the HTML source data, populating an output folder with these results.

### [PRODUCE-TUTORIAL-TOC](../../PRODUCE-TUTORIAL-TOC.xpl)

Generates a Table of Contents in Markdown, saving it as [lesson-sequence.md](../../sequence/lesson-sequence.md) in a location where it will function on publication (by the repository).

### [PRODUCE-PROJECTS-ELEMENTLIST](../../PRODUCE-PROJECTS-ELEMENTLIST.xpl)

Generates an index of XProc elements used in projects in the repository, stored as[element-directory.md](../../sequence/element-directory.md).

### [PRODUCE-EVERYTHING](../../PRODUCE-EVERYTHING.xpl)

Runs all the pipelines described above, as a set, together.
