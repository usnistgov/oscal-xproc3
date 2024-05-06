# Schema Validation Field Testing

Determining conformance of [OSCAL schemas](https://pages.nist.gov/OSCAL) to their [Metaschema definitions](https://github.com/usnistgov/OSCAL/tree/main/src/metaschema).

More generally this means determining conformance of any generated or acquired schemas to [Metaschema](https://pages.nist.gov/OSCAL) semantics, or to any semantics defining states of 'valid' and 'invalid', as specified by example.

Note that 'field testing' is not a mathematical proof but an empirical demonstration -- we try it and see. In only some cases are we able and willing to exhaust the 'possibility space' we are examining, for an actual 'proof'. The provability of schema validation in the abstract (with respect to 'content models' or any other conceivable constraint set) is a theoretical question not addressed here.

The premise is that if you need to be a mathematician to understand schema validation, we have a problem. Instead, we assume that the rules that constitute document validity are understandable by anyone (or anyone with requisite domain knowledge), and do not require 'trust'. That being said - "rules is rules", but they can also be very relative (in function and applicability) and sensitive to circumstance.

Accordingly we help to define the constraint space by showing models or specimens. They demonstrate the rules by example (of conformance and failure) and tested under automation (checking schema processing results against expectations).

Skip to the [dev punchlist](#dev-punchlist) below for latest plans.

## TL/DR

1. Read the [top-level readme](../README.md) and follow its installation instructions to install and test Morgana with Saxon
1. Scan or read through this readme and any documentation you can find in project folders
1. Run the [`GRAB-OSCAL.xpl`](GRAB-OSCAL.xpl) pipeline (using [xp3.sh](../xp3.sh) or [xp3.bat](../xp3.bat) in the parent folder) to acquire OSCAL resources, creating a mini-library for OSCAL to be used in this application
1. Verify that it has run by checking to see that new resources have appeared where expected
1. To test run OSCAL validations:
    - [`PROVE-JSON-VALIDATIONS.xpl`](PROVE-JSON-VALIDATIONS.xpl) and [`PROVE-XSD-VALIDATIONS.xpl`](PROVE-XSD-VALIDATIONS.xpl) prove their respective validation sets against their respective schemas
    -  Schemas are currently wired into the pipelines - change them there or clone the pipelines for new schemas
    - XML and JSON reference sets are kept separate and aligned as necessary
    - Expect errors if resources are missing or out of place (and be sure to run `GRAB-OSCAL.xpl`)

For use in development

1. [CONVERT-XML-REFERENCE-SET.xpl](CONVERT-XML-REFERENCE-SET.xpl) helps convert samples from XML to JSON - it is also hard-wired to convert documents named in the pipeline. As such, it can be reconfigured or imported into another pipeline.
1. [../smoketest/POWERUP.xpl](../smoketest/POWERUP.xpl) does nothing but exercise the XSLT engine (to hear it hum).

## Testing

See [`TESTING.md`](TESTING.md).

## In this project folder

The architecture and configuration are intended to be appropriated and embedded in tests for other schema validators.

- XProc 3 pipeline files provide runtime configurations
- `reference-set` contains reference (sub)sets
  - within, distinct families (models / validation profiles) are distinguished, for example [`catalog-model`](reference-sets/catalog-model/) for OSCAL catalogs
  - Each should have its own readme
- `src` has XSLT and XProc code supporting runtimes
  - `\*.xpl` signifies XProc 3.0 (for Morgana XProc III)
- `lib` (created by running `GRAB-OSCAL.xpl`) contains downloaded resources, including
  - schemas to be tested
  - utilities such as converter scripts
  - alternative implementations for comparison, such as [oscal-cli](https://github.com/usnistgov/oscal-cli)
  - `.gitignore` excludes contents of `lib` from the repository, for the developer to curate locally

## Goals

We aim to be able to show definitively that a particular XSD or JSON schema is capable of discriminating correctly between valid and invalid documents, across a set of known (controlled and well understood) instances.

This is in support of OSCAL Issue https://github.com/usnistgov/OSCAL/issues/1989 and related issues.

Going beyond this to address more fundamental problems, for the sake of OSCAL conformance testing, and in general, we aim to be able to test any XSD or JSON Schema, with any schema validation engine. Any validator that 'emulates' a schema (returns the same error messages as a schema validation would, for the same inputs) can similarly be tested.

For this prototype we focus on the processors built into commodity XML tools as a baseline: XSD and JSON Schema validation as offered by Morgana XProc III using its libraries of commodity tools.

## Non-goals

To support generalizing the approach, an interface language for validation error reporting might be designed and deployed. This is not part of the current scope of work, but should be planned (in the [Metaschema](https://github.com/usnistgov/metaschema) context, not OSCAL context).

[XVRL](https://spec.xproc.org/master/head/xvrl/) is available as a reference point for this work (part of XProc 3.0, 2020) and might be adopted, to start. Many of these pipelines could be provided with a XVRL output port.

[TODO: identify potential consumers of XVRL that could give us leverage here?]

Until then, each new validation engine must be provided with its own testing harness. XProc harnesses can be developed for any runtime that can be integrated into Morgana and deliver its results back for processing. (Hint: XProc 3.0 has a `p:os-exec` step.)

## Setup and operation - more detail

Perform the repository setup by running the setup.sh script (requires `bash`) as described in the [repository readme.md](../readme.md).

These instructions assume familiarity with how to run XProc3 pipelines, as described in the [readme.md](../readme.md).

### Download OSCAL resources

For use by this application, OSCAL catalog converter XSLTs and schemas can be copied onto the local system by running the pipeline `GRAB-OSCAL.xpl`.

It places these resources in subdirectories inside a folder called `lib`. We leave it to you to run these to ensure things are kept up to date and aligned with expectations as to versions, etc.

Note that this is not the same as the project-wide `lib` directory created and populated by [the setup script](../setup.sh). Currently these resources are being kept isolated with this project to prevent collision with others that may wish to use resources that are *the same or very similar* (i.e. seem the same, but might not be).

Like the higher-level `lib`, however, these files are also excluded from git in order to make the dependency more transparent.

### Run the XSD field tests

Use the pipeline, Luke! The pipeline `PROVE-XSD-VALIDATIONS.xpl` runs an XSD field test on each of the documents named in the pipeline.

### Run the JSON validator field tests

The pipeline `PROVE-JSON-VALIDATIONS.xpl` runs a JSON Schema field test on each of the documents named in it.

### Inspect and assess the test samples

Test samples are all stored in the folder `reference-sets/`.

Each test set is kept separately; within each test set further discriminations can be made.

Note that their placement in the reference sets is used as an indicator to the validation logic to expect whether a file should be found valid or invalid.

The XSLT `src/common/validation-screener.xsl` has a function with this logic.

TODO: XSpec the core bits of logic here to externalize things a bit better?

### Add to the test samples

#### Converting samples

The XProc pipeline [`reference-sets/catalog-model/CONVERT-XML-REFERENCE-SET.xpl`](reference-sets/catalog-model/CONVERT-XML-REFERENCE-SET.xpl) can be used to convert XML files named in the pipeline into JSON equivalents. But it cannot be guaranteed to work on instances that are not schema-valid. 

Whether it can convert a given invalid instance depends on [the type of error or lapse -- see below](#what-are-we-testing). For example, data that is unexpected is typically dropped. But even if expected (required) data points are missing, what is present can typically be converted. So a defective XML instance (not valid because has something missing) converts cleanly into a similarly defective JSON instance.

Invalid instances that cannot be correctly converted must be aligned by hand, for now, but see [the catalog-model reference set readme.md](reference-sets/catalog-model/readme.md) for more on this topic.

## What are we testing?

A schema must be tested in a validating processor (depending on the kind of schema), but they can also be decoupled by "mixing and matching" schemas in standard syntaxes with engines that implement them.

Three different outputs of a schema validation process might be considered:

- Validity state as an abstraction - typically a Boolean value ('valid' or 'not valid')
- Validation messages - all messages or any 'validation' messages delivered by a processor
  -   typically excluding info level messages
  -   typically including 'error' and 'warning' level messages
- Post-validation document, as amended
  - In XSD this would be a PSVI ('post-validation info set')

Largely since we need to support both JSON Schema and XML validations with a wide range of processors, we support only the *first level* of testing here.

We do this by provided sets of known-valid and known-invalid inputs, and aligning tests to see if a validator (schema+processor combination) gives the expected results *for that technology* (given its capabilities) when run over those inputs.

However, Metaschema technology goes beyond this first level, and since different validators may support different subsets of the full range of tests implied by a metaschema, further discriminations are necessary.

Accordingly we start with (at least) three categories:

- **valid** - XSD and JSON-Schema level structural validation + constraints validation (no messages more severe than 'warning')
- **defective** - violates a modeling rule (detectable by XSD or JSON Schema)
- **disordered** - violates a metaschema-defined constraint (not detectable by XSD or JSON Schema)
- (possibly for later) **variant** - violates 'WARNING' level constraints only

Running over these sets, a validation engine is expected to be able to discriminate their members correctly, to the extent possible.

Without support for Metaschema constraints, an XSD or JSON Schema validator cannot distinguish between 'valid' and 'disordered' - for them, a putative category 'schema-valid' unifies 'valid' and 'disordered'.

(A different intersection, namely instances that return no errors on constraints but are invalid structurally, is excluded, since structural validation is a requirement for 'orderliness'. Only instances that are not defective can be disordered; or, defective instances are also disordered *ipso facto* even if no other constraints are violated.)

We have to maintain all categories in both XML and JSON formats, to begin (possibly YAML also, in future).

A small but pervasive problem in JSON Schema modeling provides us an opportunity to use this scaffolding [Issue metaschema-xslt #105](https://github.com/usnistgov/metaschema-xslt/issues/105).

### Validation state

Note that this is not an intrinsic state of an instance, but a *relation* between a given instance (as artifact of representation) and a set of rules and definitions in application to it (collectively called a 'schema').

As it bears on certain distinguishable operations, 'validation state' might also be distinguished:

- **legibility** - syntax okay and ordered enough for a lossless conversion - e.g. no unrecognized contents
- **intelligibility** - (presumes legibility) datatypes are lexically correct and everything casts into types as defined
- **completeness** - (presumes legibility) all model-based rules are followed and no required data fields or structures are missing
  - "valid" conventionally (above) is a combination of intelligible and complete
- **harmonization** - (often entails 'valid' i.e. completeness + intelligibility) constraints are all followed - these can be arbitrary, e.g. enumerated-value (datatype) or cross-referencing constraints
  - "disordered" or "variant" instances may be valid, but they are not harmonized - while variant instances may be harmonized with other variant instances.

Especially the last category overlaps with system-level, not trans-systemic constraints, including best practices and other rules not fully formalized or enforced.

## dev punchlist

TODO: UPDATE THIS FILE, addressing all TODO

- check-pipelines.xpl pipeline to apply Schematron to pipelines
  - consider `xslt3-functions` submodule for SchXSLT support
- call this from a top-level pipeline for ci/cd
- 
- Schematron over the pipelines?
  - Use of @message
    - Recommend on any p:load or p:store
    - format
  - /define-step/@type, @name
- XProc to apply the Schematron
- Put this under CI/CD

- Pick up 'choice' testing and demo bug
- Invite play testing
- How far can we get with oscal-cli?
  - building building on GRAB-OSCAL-CLI.xpl
  - Extracting its schema files for comparison?
  - Running it directly? let's try the <p:os-exec/> step
  - write an iXML grammar for its results?
- Schematron to validate XML in resource set?
  - with xpl runtime
  - nominally valid instances should have no PI
  - nominally invalid instances should be marked

started 20240424

---


