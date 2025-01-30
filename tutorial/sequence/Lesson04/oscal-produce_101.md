

> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [../../source/oscal-produce/oscal-produce_101_src.html](../../source/oscal-produce/oscal-produce_101_src.html).
> 
> Save this file elsewhere to create a persistent copy (for example, for purposes of annotation).

# 101: Producing OSCAL from a publication format

## Goals

Learn how high-quality XML can be produced from uncontrolled source data, with several examples.

Observe how a deterministic data processing framework can be tuned or programmed to resolve anomalies in bad inputs, producing a well-formatted, cleanly encoded edition at a higher level of quality and capability, using a traceable and verifiable process.

Along the way, learn something about XProc; XSLT transformations; XML; NISO STS format (a standard encoding for supporting publication in electronic formats); OSCAL; the NIST Cybersecurity and Privacy Reference Tool (CPRT); the US Digital Service, US Army field manuals and documentation; and the focus of FM 6-22: Leadership and leadership development.

## Prerequisites

You have succeeded in prior exercises, including tools installation and setup.

You have some understanding of OSCAL if not familiarity with it, possibly having seen or used public OSCAL examples such as NIST Special Publication (SP) 800-53 encoded as an OSCAL catalog.

## Resources

Several projects in the repository (at time of writing) produce OSCAL data from inputs that are not OSCAL. They each produce the same kind of result: an OSCAL catalog (XML document). Beyond this they represent a range of cases in both complexity and goals:

* USDS Playbook – 13 OSCAL controls (high level) from a simple web page produced by the US Digital Service: Guidance for the design and implementation of online (digital) services 
* NIST SP 800-171 from NIST Computer Cybersecurity and Privacy Reference Tool (CPRT) JSON - control catalog 
* US Army Field Manual 6-22 - via HTML from PDF source, with NISO STS format as an additional result - Chapter 4 on Leadership Development

*Caution: all produced versions of these public documents are non-normative, unauthorized (lawful within terms of reuse in the public domain) and not for publication, being intended only for demonstration of tools and capabilities.*

## Step one: review projects

These projects follow the general pattern in this repository. It is designed to be operated on its own, and comes with pipelines to be run to acquire resources from the Internet, typically placing these in the project lib directory . Such resources may include data sources or other dependencies for steps in the pipeline. It is always a good idea to look at pipelines before you run them, in case such requirements must be addressed first.

### USDS Playbook

This is the simplest and smallest of the OSCAL production demonstrations. It reads a web page and converts its contents into a simple but complete [OSCAL catalog](https://pages.nist.gov/OSCAL/resources/concepts/layer/control/catalog/).

The web source for this transformation has been archived and committed to this repository to ensure the demonstration works even if the upstream data source changes or becomes unavailable. Naturally, change management in the face of such potentials is an important issue. Fortunately, XProc gives us ways of both detecting and adapting to changes in the operating context or environment, as demonstrated (in a simple way) on these projects.

### NIST CPRT SP 800-171

The data set source for this OSCAL is JSON available through a public portal, the [Cybersecurity and Privacy Reference Tool](https://csrc.nist.gov/Projects/cprt) maintained by the National Institute of Standards and Technology (NIST).

Again producing an OSCAL catalog, this project has real-world complexity. *Note that neither this production nor its OSCAL representation are canonical or authoritative*, and should not be used for security operations, being untested in that context. (Instead, use XProc to build and maintain your own feeds from the source.)

The pipeline that produces this OSCAL also demonstrates how a pipeline can include validations of its own, supporting quality checking by means of schemas and queries over data as it passes through the system.

### US Army FM 6-22, chapter 4

This example is somewhat fanciful or artificial, as the source data was not produced with OSCAL in mind. Given this mismatch, that it works at all might be considered noteworthy, much less how well it works.

[US Army Field                   Manual 6-22](https://armypubs.army.mil/epubs/DR_pubs/DR_a/ARN36735-FM_6-22-000-WEB-1.pdf) on **Developing Leaders** has a distinguished history and distills hard-won knowledge, with many dedicated contributors over many revisions, and is noteworthy for this reason alone. As a structured data set, Chapter 4 of this document serves as a startling demonstration of how OSCAL can support &ldquo;semantic description&rdquo; of written (and typeset) information that shows OSCAL-like regularities, even when it has not been created with OSCAL in mind. As a machine-readable, structured, validable data instance, FM 6-22 and its contents may be useful in multiple ways beyond (simple) publication in print and PDF – while those capabilities have not been abandoned. At the same time the OSCAL-encoded version is suggestive of entirely new functionalities.

Greater accessibility is the goal, considered broadly. A standard such as OSCAL encoding is useful insofar as it serves that goal.

Of the three demonstrations, this is the most complex, requiring not only generic transformation logic, but also ad-hoc analysis with patches, in order to rectify encoding problems in the source. XProc provides tools and methods for this careful work that are efficient, comprehensive, manageable and testable.

## Step two: Examine pipelines and inputs

### USDS Playbook

Three pipelines can be found in this project folder:

* [GRAB-PLAYBOOK](../../../projects/oscal-import/USDS-2024_Playbook/GRAB-PLAYBOOK.xpl) copies an HTML file from the Internet (USDS web site) and saves it locally in an `archive` folder as [playbook-source.html](../../../projects/oscal-import/USDS-2024_Playbook/archive/playbook-source.html)
* [GRAB-RESOURCES.xpl](../../../projects/oscal-import/USDS-2024_Playbook/GRAB-RESOURCES.xpl) acquires a copy of the OSCAL Catalog XSD schema, for validating outputs
* [OSCAL-PLAYBOOK.xpl](../../../projects/oscal-import/USDS-2024_Playbook/OSCAL-PLAYBOOK.xpl) runs a pipeline converting the saved HTML file into an OSCAL file, validating it, and saving it as file [playbook_99_oscal.xml](../../../projects/oscal-import/USDS-2024_Playbook/archive/playbook_99_oscal.xml)

If pipelines have been run, there will also be files in the [lib](../../../projects/oscal-import/USDS-2024_Playbook/lib/) and [archive](../../../projects/oscal-import/USDS-2024_Playbook/archive/) directories. The [src](../../../projects/oscal-import/USDS-2024_Playbook/src/) directory contains other files used by the XProc.

As a general rule of good practice, XProc pipelines in this pipeline always emit messages to the console when saving copies of files it downloads.

### NIST CPRT SP 800-171

The JSON source data for this demonstration has been downloaded and saved in its[data/cprt](../../../projects/oscal-import/NIST-CPRT/data/cprt/cprt_SP_800_171_3_0_0_11-12-2024.json) directory. This file file is bound to the `source` port of the single pipeline in this project: [PRODUCE_SP800-171-OSCAL.xpl](../../../projects/oscal-import/NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl).

The [src](../../../projects/CPRT-import/src/) directory in this project folder contains a number of resources required by the pipeline, including both XSLT transformations and rule sets (using Schematron and RelaxNG) to be used as part of pipeline execution, ensuring predictability, conformance and correctness.

### US Army FM 6-22, chapter 4

The pipeline [PRODUCE_FM6-22-chapter4.xpl](../../../projects/oscal-import/USArmy_FM6-22/PRODUCE_FM6-22-chapter4.xpl) starts by reading an HTML data file created by using utility software to produce a &ldquo;web page export&rdquo; of the document in its original PDF format, as published by the US Army and placed into the public domain. This prior step must be accomplished by hand, and is sensitive to the software used. Consequently, for this pipeline to be reproducible as a demonstration, the HTML input needs to be fixed. This HTML has been saved as file [fm6_22.html](../../../projects/oscal-import/USArmy_FM6-22/source/export/fm6_22.html). An additional copy with whitespace added for legibility is placed alongside it.

Additionally, the pipeline requires other resources to be stored in `lib`, again acquired by running pipelines: [GRAB-RESOURCES.xpl](../../../projects/oscal-import/USArmy_FM6-22/GRAB-RESOURCES.xpl) for a local copy of the OSCAL schema and [GRAB-NISO_STS-RNG.xpl](../../../projects/oscal-import/USArmy_FM6-22/GRAB-NISO_STS-RNG.xpl) to acquire a RelaxNG schema for NISO STS format.

This last resource is needed by the pipeline because it produces, in addition to OSCAL, [a version of the Field Manual encoded                   in STS XML](../../../projects/oscal-import/USArmy_FM6-22/temp/t06_sts-enhanced.xml) as a waypoint format before creating OSCAL. This XML is of interest in its own right, as it is valid STS XML - try an [STS Viewer](https://pages.nist.gov/xslt-blender/sts-viewer/) to see the code rendered.

## Step three: Run pipelines, inspect results

Interim or final result files produced by these pipelines may have been committed to the repository, in which case they can be inspected without running the pipeline.

However, running each pipeline guarantee for the operator that you are seeing what you think you are seeing.

### USDS Playbook

As noted, and once all preliminaries are in place, the pipeline [OSCAL-PLAYBOOK.xpl](../../../projects/oscal-import/USDS-2024_Playbook/OSCAL-PLAYBOOK.xpl) will read the HTML source file and translate it into OSCAL.

Assuming all resources are in place, this pipeline should produce several files in an `archive` directory. In particular, look for a &ldquo;terminal file&rdquo; in OSCAL format, for example, named `playbook_99_oscal.xml`.

For this pipeline to work, other pipelines may have to be run first, to acquire resources: see the project [readme.md](../../../projects/oscal-import/USDS-2024_Playbook/readme.md) document.

### NIST CPRT SP 800-171

Running [this pipeline ](../../../projects/oscal-import/NIST-CPRT/PRODUCE_SP800-171-OSCAL.xpl) creates interim results in a `temp` directory, for tracing and debugging, overwriting copies of these files already present. A *fresh* output file with a new (distinct) name including an ID segment (the first block of its top-level UUID) is also produced in the project folder.

In operation, a user would delete files produced by &ldquo;practice runs&rdquo;: feel free to do this as well.

Note that OSCAL files produced by this pipeline in separate runtimes will not be identical, if only because each one has its own timestamp with its creation date. Otherwise, the same sources should produce the same results – and this can be tested.

### US Army FM 6-22, chapter 4

As noted above, this pipeline starts by loading [source/export/fm6_22.html](../../../projects/oscal-import/USArmy_FM6-22/source/export/fm6_22.html).

This pipeline produces temporary results along with its final result file, a valid OSCAL catalog.

#### Pipeline results

A directory named `temp` will contain results of this pipeline.

These include both interim results and nominally &ldquo;final&rdquo; outputs of the pipeline, including both OSCAL and NISO STS XML outputs: that is, the same data in two different forms. These are interesting for the comparison they provide – and the STS version is potentially useful in itself.

#### OSCAL output

Additionally, a file [FM_6-22-OSCAL-working.xml](../../../projects/oscal-import/USArmy_FM6-22/FM_6-22-OSCAL-working.xml) presents a copy of the OSCAL version (also saved in `temp`) with an XML stylesheet processing instruction attached. This binding makes it possible to view this file with formatting, when served by a web server. (See the next lesson unit for more details.)

OSCAL (Open Security Controls Assessment Language) is able to factor out a rich &ldquo;semantic&rdquo; view of this information set, presenting the full text of Chapter 4, but this time along with externalized control sets derived from their tables. These represent 25 **attributes** and 50 **competencies**, as described in Field Manual 6-22 and its related documents such as ADP 6-22 (describing the **US Army Leadership Requirements Model**).

## Step four: Inspect again in diagnostic mode

Having run these pipelines and seen their sources and results, inspect them one more time to appreciate some of their features.

### USDS Playbook

This XProc is a little unusual in that while its conversion requirements are fairly simple, it has been built defensively, with fallback logic to handle cases of missing or broken inputs. If inputs are missing – either the source data, or the OSCAL schema to which it is expected to validate – the pipeline does not error out, but instead delivers a more helpful response including instructions on acquiring them. Similarly, if the transformation process itself changes without notice, some defensive validation built into this pipeline will fail.

All this takes the form of extra complexity using elements such as `p:choose` (for conditional, switch-statement-like branching) along with validation steps.

[A simpler version of this                   pipeline](../../../projects/oscal-import/USDS-2024_Playbook/OSCAL-PLAYBOOK-SIMPLE.xpl)without the defensive logic is saved next to it – compare (and run) this pipeline for comparison.

### NIST CPRT SP 800-171

The pipeline that produces this OSCAL is somewhat more complex because its source data, in JSON format, is noisier and rougher, and requires somewhat more aggressive normalization and regularization. Accordingly, the pipeline does some work based on values provided to match the expectations of the source. Those values are provided to the XProc process as options, which can be set at runtime. While they are not expected to be any different from the set values for this data set, exposing them as options makes it easier to find and change them if this pipeline is ever adjusted to handle inputs that are nearly the same, but not exactly the same, as the source data here.

Internally, this pipeline does some fairly extensive string processing to render information that is given implicitly by means of a bespoke (one-off) syntax. Unless your XPath is strong you may wish to compare inputs and outputs of specific steps directly, in order to understand better what they do.

The steps in this pipeline are also organized into two large groups (using `p:group`) in order to separate them functionally. First, the data is ingested into a declarative, semantic-descriptive XML-based format. Then it is cast to OSCAL. Each of these processes requires several steps.

### US Army FM 6-22, chapter 4

As noted above, both OSCAL and STS XML outputs may be considered valuable resources. In this case, STS is used as the &ldquo;pivot&rdquo;, while the OSCAL output is richer and information-denser (about 80% the size in kilobytes). Either may be suitable for producing formatted results.

Additionally, this pipeline has a **pipeline option** declared named `writing-all`. When set to `true()`, the processor will be instructed to save intermediate results of pipeline processing in the `temp` directory. These are numbered in sequence. A `diff` tool (especially an XML-aware diff) between successive forms will reveal exactly what changes between these forms.

Set this option by hard-coding in the pipeline or by using your processor's option syntax:

* [Morgana XProc IIIse](https://www.xml-project.com/manual/ch01.html#R_ch1_s1_2_s2_3) supports syntax in the form `-option:OPTIONNAME=optionvalue` from the command line
* [XML Calabash 3](https://docs.xmlcalabash.com/userguide/current/running.html#run-run) supports syntax in the form `OPTIONNAME=optionvalue` *after* the pipeline name in the command

## What these pipelines have in common

See the [next lesson unit](oscal-produce_102.md) for remarks on the patterns that can be observed in these pipelines.

* Entropy-removing upconversion to semantic target, followed by downhill conversion - declarative encoding as 'potential energy' magnified by the degree to which consumers have prior knowledge of new formats
* Mix of generic and ad-hoc processes (tailored per pipeline)
* XProc or XSLT? (Or XQuery?) XSLT, in line or out of line?
* Transparency and traceability of deterministic, well-defined and specified processes
* Scaling and scalability: complexity, throughput (quantity), variability, time horizons - testing one-off cases vs production pipelines

## Some differences

Pipelines will vary in how much error handling or implicit &ldquo;hand holding&rdquo; they offer. The USDS Playbook example shows a case that may arguably be over-engineered, in the sense that it provides more complex fallback logic than the (comparatively simple) problem may warrant. For example, instead of declaring expected inputs (which can be checked when the pipeline is loaded), it loads them dynamically, giving a custom error message when they are missing (with a hint on how they can be acquired). A simpler pipeline might trust the processor's own error message to do the job of communicating the problem. The benefit is that this shows how XProc pipelines can be made to be more forgiving (of predictable errors) as well as presumably easier for the user, at the cost of some logical complexity in its internals.

Nevertheless even a pipeline designed to be robust will not when required inputs are not available. An engine drives a cart, but we move the cart for the sake of its cargo: this is what is means to be &ldquo;required&rdquo;.
