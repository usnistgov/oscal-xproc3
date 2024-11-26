# OSCAL XProc 3.0 Tutorial

This is unfinished work in progress towards an XProc 3.0 tutorial or set of tutorials.

Tutorial exercises can be centered on OSCAL-oriented applications but the learning focus will be XProc 3.0.

We need to be modest and realistic in our goals, in proportion to the great potentials.

## How to Work

The tutorial is designed to support multiple different approaches suitable for different learners and needs. Use the approach that works for you by mixing and matching your attention to appropriate coverage.

Each topic ("Lesson") in a sequence offers a set of Lesson Units around a common problem area or theme.

The first two topics cover setup and overview ("walkthrough"), while later topics delve into specific problem areas or application domains.

The important problem of data conversion between XML and JSON is the first topic explored in depth. Later topics (not yet developed) will cover XML-based publication, validation against schemas and rule sets (both standard and locally-defined), data acquisition from PDF and JSON; OSCAL profile resolution (rendition of control sets defined by profiles in catalog form); processing XProc itself; and others.

Since the topics each build on the previous topics, considering them in the given order will be least confusing. However, if it makes sense to cover only one or two tracks within each topic, lesson units can also be skimmed or skipped.

### Observer Track

For subject experts, managers and programmers who want to see how XProc works and understand its capabilities, without planning to develop XProc pipelines or requiring hands-on knowledge.

In this track you will inspect pipelines, run pipelines, and inspect their inputs and outputs. But you need not fear introducing errors or exceptions, as that's what the Maker track is for.

### Maker Track

The coverage here parallels the Observer track, but provides exposition appropriate to newcomers to XProc who wish to accelerate learning by 'hands on' experimentation.

The biggest challenge to developers learning XProc is how much XML, XPath, XQuery, or XSLT do you know. Even developers who have no prior exposure to the XML stack should be able to use the Maker track to test and develop skills. Those who do have prior experience will, it is hoped, find it to be an accelerant, while XProc itself is a launchpad.

The expectation is that unlike Observers, Makers will enjoy seeing tracebacks for errors you have introduced on purpose, just out of curiosity and need-to-know. You are confident that you can put things back well enough or that any damage is well contained.

Makers can also expect the gratification of making things work in new ways.

If you are a hands-on learner with no patience for reading, you can skim through the Observer and Maker tracks together quickly and focus on the examples, to try things out. Within topics, all tracks sometimes offer useful context, while the Maker track is specifically streamlined. (But maybe you have found that out for yourself and will never read these words to say so!)

### Learner Track

Paralleling the other two tracks, the Learner track offers all readers more explanation and commentary, in greater depth and with more links.

## Editing the lessons

The lessons are published in Markdown, which invites you to edit them, at least in your copies.
When you do so, however, you should take care:

- To see to it that your edits or annotations are easily distinguishable
- To save your edited copy out, lest it be written over inadvertantly as a publishing artifact (see next section) 

All work product here in in the Public Domain, so no worries there. Of course this means you can't claim copyright either: *caveat scriptor*.

# Production

Source files are maintained in a reduced HTML format.

This reduction is enforced by means of a Schematron rule set, which forbids anything outside of a small core of supported features in HTML.

Simultaneously, a transformation is maintained that rewrites these into Markdown syntax. These files can be produced statically or under CI/CD, committed into the repository and read directly in its previews.

At a future point we can also opt to do something better with this HTML.

### Requirements

See the top-level pipelines for current capabilities. At time of writing:

[PRODUCE-TUTORIAL-MARKDOWN.xpl](PRODUCE-TUTORIAL-MARKDOWN.xpl) produces a set of Markdown files, writing them to the `sequence` directory.

These files are not retained by git, being regarded instead as production artifacts. Run the pipeline when you want to refresh them.

[PRODUCE-TUTORIAL-PREVIEW.xpl](PRODUCE-TUTORIAL-PREVIEW.xpl) produces a single [Preview HTML version[(tutorial-preview.html)

[PRODUCE-TUTORIAL-TOC.xpl]() produces the [Tutorial Table of Contents](sequence/lesson-sequence.md)

[PRODUCE-PROJECTS-ELEMENTLIST.xpl] produces an [index to XProc elements appearing in pipelines](sequence/element-directory.md) under discussion - read about it in the lessons

## Leave your tracks

### Follow up

If you make a fork of this repository, let us know - also be aware we may use your name (unless you request we not do so).

If you copy or use anything from the repository also feel free to let us know.

### Discussion board

The [Github repository Discussion Board](https://github.com/usnistgov/oscal-xproc3/discussions) is a worthwhile place to browse or to pose questions, whether directly about the tutorial or exercises, or more broadly.

### Github PRs

Consider making a [pull request](https://github.com/usnistgov/oscal-xproc3/pulls) with an enhancement to the repository. If there are no corrections or improvements to suggest, sample files are always welcome. Future users can have the benefit of your experience.

---
