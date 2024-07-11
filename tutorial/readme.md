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
  - Start at the top and see how far you get
  - Take notes
  - Get as far as you can - extra points for finishing the course

We will start with a poll - how far did you get?



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

OSCAL sample data

## XProc 102 - Intro for developers

Assumes XSLT / regards it as a black box
Assumes *some* XML

Included will be:

Pipelines and pipeline architectures - theory and practice

Potentials including TDD; distributed development; platform independence supporting data security

Setting up and running pipelines
  - standalone
  - with port bindings at runtime
  - local and remote resources (http: and file: URIs)
  - (scripted)
  - (via APIs)

Diagnostic methods
- Rewiring inputs (setting @sequence to true)
- Writing intermediate results
- `@message` and `p:identity/@message`
- Variables and AVTs in messages and paths

`@content-type` options including plain text, XML and JSON

## XProc 111-112 - Deep dive into XProc

Writing your own steps
- Names and @type
- Namespaces

Inline XSLT or XQuery

Local function libraries?

iXML for other notations