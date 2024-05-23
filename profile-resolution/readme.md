# OSCAL XProc3 Project Template

Use this file to document the project in the containing folder.

For an outline of full (minimal) project documentation, see the [NIST Open-Source Software Repository Template](https://github.com/usnistgov/opensource-repo/blob/main/README.md).

The repository [README](../README.md) addresses all these points on a general level (repository-wide). Given the assumption that all projects are abiding by [repository guidelines](../CODE_OF_CONDUCT.md), each project readme (this file) is available for documenting its specifics.

Consider describing the following here:

## Project purpose, scope and goals

## Who might find this useful

The project is centered on an application or family of applications. Who will use it?

## What is provided

This project offers XProc pipelines useful for demonstrating and operating OSCAL Profile Resolution, a process defined by OSCAL for the production of **catalog baselines** from documents known as 'profiles', making reference to other documents, known as 'catalogs'.

<details><summary>OSCAL Profile Resolution</summary>

OSCAL profile resolution is defined normatively in a draft [specification and detailed description](https://pages.nist.gov/OSCAL/resources/concepts/processing/profile-resolution/) on the OSCAL web site, as part of the OSCAL specification.

OSCAL profiles and catalogs center around the concept of controls. Catalogs are collections of controls, and profiles are tailored selections of controls from catalogs.

In its most reduced form, a catalog might have controls A, B and C, and a profile selects A and B. To resolve this profile is to produce a catalog containing controls A and B. Control C for the catalog is considered to be out of scope for the catalog (the 'tailored baseline' or 'overlay') resulting from profile resolution. The profile does not contain the controls - it selects them. The controls, that is, are selected in the profile and *shown* in the resolved catalog, showing a subset of the original's controls.

Thus 'resolution' may be conceived of as a function that accepts profile and catalog inputs (in pseudo code)

```
resolve(profile, catalog) => catalog
```

which is eerily similar to a generalized transformation architecture

```
transform(stylesheet, document) => document
```

with an important caveat - a profile must designate its own catalog sources.\* (And there can be more than one.)

So

```
profile(catalog+) => resolve() => catalog
```

Where the result catalog represents the output of the resolution operation on the source profile (with its catalogs).

* While an OSCAL profile in principle could be resolved against any OSCAL catalog, not only those it designates, such behavior would be non-normative, and the process useful only for analysis and forensics, no longer meeting requirements for traceability.
</details>

Since an OSCAL profile makes reference to its catalog sources, its resolution can be driven by calling a resolver with one argument (designating the profile) or by calling a 'resolver wrapper' that designates this source, and runs standalone.

As inputs for testing, example profiles and catalogs can be found in two places:

[data](data) - look and see (possibly a motley collection)
[lib/oscal-content](lib/oscal-content) - some canonical OSCAL samples - acquire by running the pipeline [setup/ACQUIRE-OSCAL-DATA.xpl](setup/ACQUIRE-OSCAL-DATA.xpl)

## How to use it

### Setup

With a connection to the Internet, you can run a profile resolution pipeline by invoking an XSLT on Github, using the subpipeline [src/apply-remote-profile-resolver.xpl](src/apply-remote-profile-resolver.xpl) (or rewire [resolve-profile.xpl](resolve-profile.xpl) to use this).

Or you can copy the transformation suite (XSLTs only) into the project `lib` by running the pipeline [setup/GRAB-PROFILE-RESOLVER-XSLT.xpl](setup/GRAB-PROFILE-RESOLVER-XSLT.xpl).



At that point all the other pipelines will work without modifications: all resources will be present.

Another setup XProc, [setup/ACQUIRE-OSCAL-DATA.xpl](setup/ACQUIRE-OSCAL-DATA.xpl) will pick up some OSCAL data for local maintenance and use in testing.

### Standalone pipelines

Two standalone pipelines are provided, pre-wired for testing.

RESOLVE-KITTEN-CONTROLS.xpl uses files already available in the [data](data) folder. It should run without modification. Its resulting catalog will be written in a `result` folder.

RESOLVE-FISMA-BASELINE.xpl resolves a copy of the FISMA 'LOW' baseline, expressed in OSCAL, over its control set, using files assumed to be found in the folder [lib/oscal-content/](lib/oscal-content/). (NB: unless you have modified the configuration, these files are not committed into Github, as a security and transparency precaution.)

Run the pipeline [setup/ACQUIRE-OSCAL-DATA.xpl](setup/ACQUIRE-OSCAL-DATA.xpl) to populate this folder. 

### Resolving a profile (or more than one) in 'batch'

This can be done straightforwardly by copying and modifying one of the standalone profiles, to list your own OSCAL profile sources.

Of course, any profile must link correctly to its catalog or profile imports, and their links up the chain must be similarly resolvable.

TODO: thinking about a Schematron that can detect a broken import chain in OSCAL profiles.

### Designating your profile (source) at runtime

The scripts `` and `` provide Windows and Linux/WSL users respectively with an interface for resolving a (single) profile from the command line.

For example:

```
./resolve-profile.sh testing/cat-profile.xml
```

## How to use it to test and understand XSLT

Note that the scripts and pipelines use a subpipeline for the application of the profile resolver.

Actually three variant subpipelines are provided, each for a different use case.

### Running the pipeline locally using its XSLT driver

If you have run the [setup/GRAB-PROFILE-RESOLVER-XSLT.xpl](setup/GRAB-PROFILE-RESOLVER-XSLT.xpl) pipeline successfully, you have copies of the XSLT needed for profile resolution, and can execute it locally.

(Or if you acquire copies for yourself, of course.)

The pipeline [src/apply-profile-resolver.xpl](rc/apply-profile-resolver.xpl) executes this transformation sequence using the top-level [lib/resolver-xslt/oscal-profile-RESOLVE.xsl](lib/resolver-xslt/oscal-profile-RESOLVE.xsl) XSLT.

### Calling the driver stylesheet in from a remote location

The pipeline [src/apply-remote-profile-resolver.xpl](rc/apply-remote-profile-resolver.xpl) calls the same XSLT from its Github repository home, to be delivered to the pipeline at runtime.

### Running the pipeline as a sequence of discrete transformation steps

Alternatively, the pipeline [src/apply-profile-resolver-stepwise.xpl](src/apply-profile-resolver-stepwise.xpl) executes profile resolution as a chain of transformations, not a single call on an XSLT to execute an internal pipeline.

This is expected to be useful for debugging and analysis, as well as a demonstration of composition in XSLT and XProc working together.

## Contributors

The software runs XSLT distributed by the OSCAL team, originally developed by Wendell Piez, with further testing and development by Amanda Galtman.


started 20240523

---


