# OSCAL XProc 3.0 Tutorial

This is unfinished work in progress towards an XProc 3.0 tutorial or set of tutorials.

Tutorial exercises can be centered on OSCAL-oriented applications but the learning focus will be XProc 3.0.

We need to be modest and realistic in our goals, in proportion to the great potentials.

Slides show only snapshots of process - no live demo
Each slide shows links to repo
Students are invited to read slides ahead of time with other materials

We need to send this out two weeks early? Or anyone who registers late should be urged to dive in.

For preparation:
  - Take your pick: slides, repository or both
  - Start at the top with Lesson 0 and proceed from there
    - They all involve a hands-on component
  - Take notes
  - Get as far as you can - extra points for finishing the course

We will start with a poll - how far did you get?

# Architecture

The course contains a sequence of hands-on lessons of increasing depth and complexity.

See the [outline.md](outline.md) for an overview of current plans.

They are to be centered on a short sequence of applications, mostly OSCAL applications (one XProc applicationn at the end). Each of these is presented in a Lesson with a curriculum (slides/writeup) offered at three levels:

**101** - Beginners - anyone - presumes only the preceding Lessons

You can use the command line to accomplish tasks, but do not expect to be coding.

**102** - Developers - presumes deeper interest, but at an intro level

Tutorial tasks may involve editing code and providing your own OSCAL examples.

**599** - Advanced

Proceeding through the lessons you can choose how deeply to go with each, and also whether and when to come back.

## Production

Source files are maintained in a reduced HTML format.

This reduction is enforced by means of a Schematron rule set, which forbids anything outside of a small core of supported features in HTML.

Simultaneously, a transformation is maintained that rewrites these into Markdown syntax. These files can be produced statically or under CI/CD, committed into the repository and read directly in its previews.

At a future point we can also opt to do something better with this HTML.

### Requirements

For the lesson set:

- Schematron
- Markdown XSLT
- Production pipeline

See the top-level pipelines for current capabilities. At time of writing:

[PRODUCE-TUTORIAL-MARKDOWN.xpl](PRODUCE-TUTORIAL-MARKDOWN.xpl) produces a set of Markdown files, writing them to the `sequence` directory.

These files are not retained by git, being regarded instead as production artifacts. Run the pipeline when you want to refresh them.

[PRODUCE-TUTORIAL-PREVIEW.xpl](PRODUCE-TUTORIAL-PREVIEW.xpl)

## XProc 101 - What Is XProc

Developers, users and decision-makers

- What problems does it solve
- XProc 'barn raising' - getting started
- Hands on practice running some pipelines
- 'Insider tour' shows some XProc internals
- Resources

### Tasks

- XML OSCAL Catalog Validation
  - sample data, your data
  - extra: other models
- JSON Validation
  - sample data, your data
- JSON to XML and XML to JSON conversion
  - sample data, your data
- Catalog to HTML
- Profile resolution

### Follow on

OSCAL activities, XProc activities or both?

OSCAL sample data - more and better

If you make a fork of this repository, let us know - also be aware we may use your name (unless you tell us not to).

If you copy or use anything from the repository also feel free to let us know.

## XProc 102 - Intro for developers

Assumes XSLT / regards it as a black box
Assumes *some* XML
Assumes you have completed 101 and all its exercises (could be on your own)

Provides a more detailed survey and more exercises

Included will be:

Pipelines and pipeline architectures - theory and practice

Setting up and running pipelines
  - standalone
  - with port bindings at runtime
  - local and remote resources (http: and file: URIs)
  - (scripted)
  - (via APIs)

Diagnostic methods
- Rewiring inputs and outputs (setting @sequence to true)
- Writing intermediate results
- `@message` and `p:identity/@message`
- Variables and AVTs in messages and paths

`@content-type` options including plain text, XML and JSON

## XProc 599-600 - Advanced Practicum

Writing your own steps
- Names and @type
- Namespaces

Inline XSLT or XQuery

Local function libraries?

iXML for other notations

## Leave your tracks

### Discussion board

The Github repository Discussion Board is a worthwhile place to browse or to pose questions, whether directly about the tutorial or exercises, or more broadly.

### Github Issues




Consider making a pull request with an enhancement to the repository. If there are no corrections or improvements to suggest, sample files are always welcome. Future users can have the benefit of your experience.

