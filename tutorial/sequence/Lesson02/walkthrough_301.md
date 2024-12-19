

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [](../../..).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 301: Automated XProc

## Goals

* See how XProc supports software testing, including testing itself, supportive of test-driven development (TDD)
* Exposure to the configuration of the Github repository supporting dynamic testing on Pull Requests and releases, subject to extension

## Prerequisites

You have made it this far.

## Resources

Prepare to run pipelines in the [testing directory](../../../testing/readme.md) as described below.

* [Repository file set check XProc](../../../testing/REPO-FILESET-CHECK.xpl)
* [Validation file set ready check                XProc](../../../testing/VALIDATION-FILESET-READYCHECK.xpl)
* [House Rules check on defined XProc3                   FILESET](../../../testing/RUN_XPROC3-HOUSE-RULES_BATCH.xpl) 
* [House Rules check on all XProc3 files, found                   dynamically](../../../testing/REPO-XPROC3-HOUSE-RULES.xpl)
* [Run all XSpecs listed in the XSpec FILESET](../../../testing/RUN_XSPEC_BATCH.xpl)

Additionally, the [testing configuration file](../../../.github/workflows/test.yml) configured to run under Github Actions will potentially be of interest.

## XProc for quality testing

As currently configured, the repository provides two kinds of testing, both supported under XProc 3.0:

* Schematron validations providing quality checks are applied to XProcs - the so-called *House Rules* for XProc files in this repository.
* *XSpec tests* are run to provide functional testing, unit testing and regression testing for XSLT, Schematron or XQuery, as needed

Both kinds of tests can be configured and executed using XProc. Pipelines here provide for such executions in useful ways, both in local copies of the repository under development, and under automation, such as by Github Actions in this repository.

Specifically, tests that are run anytime a Pull Request is updated against the home repository serve to guard against accepting non-functional code into the repository code base.

The tests themselves are so far fairly rudimentary – while paying for themselves in the consistency and quality they help enforce.

### Pipelines useful for the developer:

* [VALIDATION-FILESET-READYCHECK.xpl](../../../testing/VALIDATION-FILESET-READYCHECK.xpl) runs a pre-check to validate that files referenced in FILESET Xprocs are in place
* [REPO-FILESET-CHECK.xpl](../../../testing/REPO-FILESET-CHECK.xpl) for double checking the listed FILESET pipelines against the repository itself - run this preventatively to ensure files are not left off either list inadvertantly
* [RUN_XPROC3-HOUSE-RULES_BATCH.xpl](../../../testing/RUN_XPROC3-HOUSE-RULES_BATCH.xpl) applies House Rules Schematron to all XProcs listed in the House Rules FILESET - just like the HARDFAIL House Rules pipeline except ending gracefully with error reports
* [REPO-XPROC3-HOUSE-RULES.xpl](../../../testing/REPO-XPROC3-HOUSE-RULES.xpl) applies House Rules Schematron to all XProc documents in the repository
* [RUN_XSPEC_BATCH.xpl](../../../testing/RUN_XSPEC_BATCH.xpl) runs all XSpecs listed in the XSpec FILESET, in a single batch, saving HTML and JUnit test results

### Pipelines run under CI/CD:

* [HARDFAIL-XPROC3-HOUSE-RULES.xpl](../../../testing/HARDFAIL-XPROC3-HOUSE-RULES.xpl) runs a pipeline enforcing the House Rules Schematron to every XProc listed in the imported FILESET pipeline, bombing (erroring out) if an error is found - useful when we want to ensure an ERROR condition comes back on an error reported by a *successful* Schematron run
* [RUN_XSPEC-JUNIT_BATCH.xpl](../../../testing/RUN_XSPEC-JUNIT_BATCH.xpl) runs all XSpecs listed in the XSpec FILESET, saving only JUnit results (no HTML reports)

### Additionally:

* [FILESET_XPROC3_HOUSE-RULES.xpl](../../../testing/FILESET_XPROC3_HOUSE-RULES.xpl) provides a list of resources (documents) to be made accessible to importing pipelines
* [FILESET_XSPEC.xpl](../../../testing/FILESET_XSPEC.xpl) provides a list of XSpec files to be run under CI/CD

### About the XProc House Rules

Read more about this in [project documentation](../../../testing/house-rules.md), and check out the [Schematron source code](../../../testing/xproc3-house-rules.sch). This set of rules helps to ensure smooth operations across projects.

A good example of a rule enforced over the XProc with this rules set: we never use XProc `p:store` without emitting a message to the console (or runtime) announcing it. This aids in transparency by alerting operators when files are produced and written. As a courtesy, the same rule is applied to `p:load` so that an operator knows when data sets are loaded dynamically (as opposed to bound to an input port).

More routinely, the House Rules checks include some very useful link integrity checks, making it possible to detect and correct broken links as soon as they appear.

### About XSpec testing in this repository

XSpec testing in this repository is quite minimal at the moment, but &ldquo;aspirational&rdquo;. We wholly endorse the goals of test-driven development and consider automated testing including functional testing and unit testing to be essential to the successful development and maintenance of pipelines with real-world complexity.

Testing a pipeline is what makes it real. Without testing, any pipeline might be a spoof or put-up job.

At the same time since the focus of development is on XProc, testing of subordinate XSLT and Schematron logic has often been neglected in favor of priorities.

This does not mean that deploying more XSpecs is not a goal.

Demonstrating the capability is a more important goal, and XSpecs can and are easily deployed and run - just take a look.

The [XSpec FILESET](../../../testing/FILESET_XSPEC.xpl) will show XSpecs run under CI/CD but not all XSpecs in the repository will be listed there.

## XProc running under continuous integration and development (CI/CD)

Any XProc pipelines designed, like the smoke tests or validations just described, to provide for quality checking over carefully maintained code bases, are natural candidates for running dynamically and on demand, for example when file change commits are made to git repositories under CI/CD (continuous integration / continuous deployment).

Consider this a ready-made framework for all kinds of testing including functional unit testing, regression testing and conformance testing as defined by traceable inputs and outputs, especially well suited for testing XSLT-, XQuery/XPath- or XProc-based solutions as well – to say nothing of testing and validation of applications (including validation applications!) provided as parts of such solutions.

The [Github Actions file configuring testing](../../../.github/workflows/test.yml) in this repo show how this can be done.

At this time, there are no immediate plans to use this feature for its most obvious purpose, namely dynamic publishing-of edited and curated source contents into readable results (such as HTML, SVG, PDF or other). Putting the tutorial production XProc pipelines into the Github Actions command sequence would have this effect.
