# OSCAL Profile Resolution

XProc 3.0 pipelines for running OSCAL Profile Resolution.

Convert OSCAL XML profiles into their equivalent catalogs (control sets).

## Project purpose, scope and goals

This project aims to make XSLT stylesheets distributed by the OSCAL team more accessible for use and testing.

These XSLTs implement [OSCAL Profile Resolution](https://pages.nist.gov/OSCAL/resources/concepts/processing/profile-resolution) as specified as part of OSCAL, the [Open Security Controls Assessment Language](https://pages.nist.gov/OSCAL). They were developed originally by NIST Team (with the help of an expert volunteer) as a demonstration and proof-of-concept (viability) for this declarative approach to constructing traceable baselines referencing control catalogs in OSCAL.

## Who might find this useful
 
- OSCAL users and practitioners who have profiles they wish to test and debug, or who wish to create an OSCAL baseline (or overlay) in the form of a profile

- OSCAL developers who wish to test this implementation or test against it

- XProc / XSLT students who wish to see a worked example of a pipeline in multiple steps

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

RESOLVE-FISMA-BASELINE.xpl resolves a copy of the FISMA 'LOW' baseline, expressed in OSCAL, over its control set, using files assumed to be found in the folder [lib/oscal-content/](lib/oscal-content/).

NB: unless you have modified the configuration, these files are not committed into Github, as a security and transparency precaution.

Run the pipeline [setup/ACQUIRE-OSCAL-DATA.xpl](setup/ACQUIRE-OSCAL-DATA.xpl) to populate this folder. 

### Resolving a profile (or more than one) in 'batch'

This can be done straightforwardly by copying and modifying one of the standalone profiles, to list your own OSCAL profile sources.

Of course, any profile must link correctly to its catalog or profile imports, and their links up the chain must be similarly resolvable.

TODO: thinking about a Schematron that can detect a broken import chain in OSCAL profiles.

### Designating your profile (source) at runtime

The scripts `resolve-profile.bat` and `resolve-profile.sh` provide Windows and Linux/WSL users respectively with an interface for resolving a (single) profile from the command line.

For example:

```
./resolve-profile.sh testing/cat-profile.xml
```

produces a catalog named `cat-profile-resolved.xml` next to the script.

The handler [resolve-profile-and-save.xpl](resolve-profile-and-save.xpl) does two things for the runtime:
 - Calls a subpipeline for profile resolution
 - Writes the result to a name and place

## How to use it to test and understand Xproc amd XSLT

All the subpipelines should do the same thing. If they do not, this is of interest, and must reflect variations either in XSLT logic or in configuration, both of which can be traced.

Examine each pipeline in more detail to consider its organization and how it handles tradeoffs it poses in running and maintenance, next to the others.

### Subpipeline variants

Three variant subpipelines are provided, each for a different use case.

Since all three are marked with the same top-level `type='apply-profile-resolver'`, they cannot be used together, but may instead be switched for one another.


#### Running the pipeline locally using its XSLT driver

If you have run the [setup/GRAB-PROFILE-RESOLVER-XSLT.xpl](setup/GRAB-PROFILE-RESOLVER-XSLT.xpl) pipeline successfully, you have copies of the XSLT needed for profile resolution, and can execute it locally.

(Or if you acquire copies for yourself, of course.)

The pipeline [src/apply-profile-resolver.xpl](rc/apply-profile-resolver.xpl) executes this transformation sequence using the top-level [lib/resolver-xslt/oscal-profile-RESOLVE.xsl](lib/resolver-xslt/oscal-profile-RESOLVE.xsl) XSLT.

#### Calling the driver stylesheet in from a remote location

The pipeline [src/apply-profile-resolver-remotely.xpl](rc/apply-profile-resolver-remotely.xpl) calls the same XSLT from its Github repository home, to be delivered to the pipeline at runtime.

#### Running the pipeline as a sequence of discrete transformation steps

Alternatively, the pipeline [src/apply-profile-resolver-stepwise.xpl](src/apply-profile-resolver-stepwise.xpl) executes profile resolution as a chain of transformations, not a single call on an XSLT that happens to execute an internal pipeline.

This is expected to be useful for debugging and analysis, as well as a demonstration of composition in XSLT and XProc working together.

Casual testing also suggests it performs at least as well as the XSLT driver, while providing a more direct interface (controls) over runtime options.

### XSLT transformations

XSLT for performing the profile resolution is downloaded from the [OSCAL repository](https://github.com/usnistgov/OSCAL/tree/main/src/utils/resolver-pipeline) as shown in the setup pipelines.

Its behavior is dictated by the [OSCAL Profile Resolution Specification](https://pages.nist.gov/OSCAL/resources/concepts/processing/profile-resolution/).
## Contributors

The software runs XSLT distributed by the OSCAL team, originally developed by Wendell Piez, with further testing and development by Amanda Galtman.

started 20240523

---


