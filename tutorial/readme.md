# OSCAL XProc 3.0 Tutorial

This is unfinished work in progress towards an XProc 3.0 tutorial or set of tutorials.

Tutorial exercises can be centered on OSCAL-oriented applications but the learning focus will be XProc 3.0.

We need to be modest and realistic in our goals, in proportion to the great potentials.

## How to Work

The tutorial is designed to support multiple different approaches suitable for different learners and needs - both learning styles, and 'use cases' as described below. Develop an approach that works for you by mixing and matching your attention to appropriate coverage.

Each topic ("Lesson") in a sequence offers a set of Lesson Units around a common problem area or theme.

The first two topics cover setup and overview ("walkthrough"), while later topics delve into specific problem areas or application domains.

The important problem of data conversion between XML and JSON is the first topic explored in depth. Later topics (not yet developed) will cover XML-based publication, validation against schemas and rule sets (both standard and locally-defined), data acquisition from PDF and JSON; OSCAL profile resolution (rendition of control sets defined by profiles in catalog form); processing XProc itself; and others.

Since the topics all build on previous topics, considering them in the given order will be least confusing. However, if it makes sense to cover only one or two tracks within each topic, lesson units can also be skimmed or skipped.

### Target audiences

- Data owners, proprietors and process managers who need to oversee XProc-based processes
- XML-stack developers starting or working with XProc 3.0/3.1
- Students at all levels
- OSCAL engineers new to XML/XDM who wish to broaden OSCAL horizons - this tutorial being a gateway to OSCAL applications in this repository

To enable readers to cater to their own needs:

- **Observer** track - operates pipelines (hits 'run' button or equivalent) and inspects outputs (in a file system), but does not code internals
- **Maker** track - able and willing to intervene in the internals
- **Learner** track - everyone

Since the different tracks are arranged along the same topics, the treatments are also suitable for groups who wish to work any or all tracks collaboratively.

### Observer Track

For subject experts, managers and programmers who want to see how XProc works and understand its capabilities, without planning to develop XProc pipelines or requiring hands-on knowledge.

In this track you will inspect pipelines, run pipelines, and inspect their inputs and outputs.

Since this track does not ask you to modify or extend anything, you can have confidence that any bugs or errors you encounter expose honest problems to be inquired after, not errors on your part.

The idea is that with a foundation in running pipelines and witnessing their capabilities at first hand, readers can then judge for themselves how deeply to delve into the various topics raised, whether moving along, skipping, stopping, or pausing to look at the other tracks.

### Maker Track

The coverage here parallels the Observer track, but provides exposition appropriate to newcomers to XProc who wish to accelerate learning by 'hands on' experimentation

The biggest challenge to developers coming to XProc will often be in how much XML, XPath, XQuery, or XSLT do you know. Even developers who have no prior exposure to the XML stack should be able to use the Maker track to test and develop skills. Those who do have prior experience will, it is hoped, find it to be an accelerant, while XProc itself is a launchpad. It should be possible to start from zero.

The expectation is that unlike Observers, Makers will enjoy seeing tracebacks for errors you have introduced on purpose, just out of curiosity and need-to-know. You are confident that you can put things back well enough or that any damage is well contained.

Makers can also expect the gratification of making things work in new ways.

If you are a hands-on learner with no patience for reading, you can skim through the Observer and Maker tracks together quickly and focus on the examples, to try things out. Within topics, all tracks sometimes offer useful context, while the Maker track is specifically streamlined. (But maybe you have found that out for yourself and will never read these words to say so!)

### Learner Track

In parallel with the other two tracks, the Learner track offers all readers more explanation and commentary, in greater depth and with more links.

The difference is between being able to visit Rome, and being able to stay there for four months on a fellowship. (Not long enough!) The assumption of the Learner track (unlike the others) is that readers will, usually ... read.

### Easter eggs

There are more curiosities to be discovered. For example, the tutorial has indexes, built using XProc. There are worksheets. Close inspection of hidden corners sometimes pays off. Links are not always given here or anywhere, and prizes go to the vigilant.

## Interactivity

Interactivity of a sort is built in, inasmuch as every lesson is centered on specific processing pipelines already in place and ready to run.

How far you go with this is up to you, but one obvious possibility for some will be to *bring your own data set* and consider adapting pipelines to do things with it.

OSCAL Catalog data will especially be of interest!

## Editing the lessons

The lessons are published in Markdown, which invites you to edit them, at least in your copy of the code repository.

When you do so, however, please should take care:

- To see to it that your edits or annotations are easily distinguishable
- To save your edited copy out, lest it be deleted inadvertantly as a temporary artifact (see next section) 

All work product here in in the Public Domain, so no worries there. Of course this means you can't claim copyright either: *caveat scriptor*.

# Production

Source files are maintained in a reduced HTML format.

This reduction is enforced by means of a Schematron rule set, which forbids anything outside of a small core of supported features in HTML.

Simultaneously, a transformation is maintained that rewrites these into Markdown syntax. These files can be produced statically or under CI/CD, committed into the repository and read directly in its previews.

This model is designed to requirements: - Easy to use in available tools including oXygen XML Editor (structured authoring) - Quick and lightweight to stand up - XProc-based - Works bare-bones but easy to extend ad-hoc - Quick and easy to publish - Github/markdown-based publishing is versatile for users - The publishing pipeline is easily extensible or switchable for something better, later.

At a future point we can also opt to do something better with this source data or portions of it.

## Runtimes

See the top-level pipelines for current capabilities. At time of writing:

[PRODUCE-TUTORIAL-MARKDOWN.xpl](PRODUCE-TUTORIAL-MARKDOWN.xpl) produces a set of Markdown files, writing them to the `sequence` directory.

[PRODUCE-TUTORIAL-TOC.xpl]() produces the [Tutorial Table of Contents](sequence/lesson-sequence.md)

[PRODUCE-TUTORIAL-PREVIEW.xpl](PRODUCE-TUTORIAL-PREVIEW.xpl) produces a single [preview tutorial on one HTML page](tutorial-preview.html)

[PRODUCE-PROJECTS-ELEMENTLIST.xpl] produces an [index to XProc elements appearing in pipelines](sequence/element-directory.md) under discussion - read about it in the lessons

# Leave your tracks

## Follow up

If you make a fork of this repository, let us know - also be aware we may use your name (unless you request we not do so).

If you copy or use anything from the repository also feel free to let us know.

## Discussion board

The [Github repository Discussion Board](https://github.com/usnistgov/oscal-xproc3/discussions) is a worthwhile place to browse or to pose questions, whether directly about the tutorial or exercises, or more broadly.

## Github PRs

Consider making a [pull request](https://github.com/usnistgov/oscal-xproc3/pulls) with an enhancement to the repository. If there are no corrections or improvements to suggest, sample files are always welcome. Future users can have the benefit of your experience.

---
