> *Warning:* this Markdown file will be rewritten under continuous deployment (CD): edit the source in [/tutorial/source/oscal-produce/oscal-produce_102_src.html](../../../tutorial/source/oscal-produce/oscal-produce_102_src.html).
> 
> To create a persistent copy (for example, for purposes of annotation) save this file out elsewhere, and edit the copy.

# 102: Producing OSCAL from uncooked data

## Goals

Learn about the internals of an XML-based data extraction and mapping process, an &ldquo;uphill data conversion&rdquo;.

Get a chance to see how XSLT gives XProc a way to address conversion at appropriate levels of scale and abstraction.

See an example of how an XProc pipeline can integrate validation to provide runtime quality-assurance and regression testing.

## Prerequisites

Run the pipelines described in [the 101 Lesson](oscal-produce_101_src.html)

## Resources

Like the [101 lesson](oscal-produce_101_src.html), this lesson unit uses the [oscal-import project](../../../projects/oscal-import/readme.md) in this repo.

## Step one: run the pipeline in diagnostic mode

## Step two: survey the pipeline steps

### feature: step by step &ldquo;up the hill&rdquo;

XProc is well suited for supporting an incremental development process based on an analysis/improvement loop. One at a time, we isolate operations to perform on the incoming data to refashion it - renaming and sometimes restructuring - into a more clearly encoded representation, closer to the goal of valid and high-quality OSCAL.

Keeping the operations isolated in separate transformations has important opportunities. We can

* Save out interim representations for inspection and validation (formal or informal)
* Isolate sub-processes for specialized requirements (micro-structures)
* Produce and persist (save out) any useful interim representation as a process by-product valuable in its own right


As it happens, the document example here is easier to convert into OSCAL if we convert into NISO STS format first. This gives us a good separation of concerns between producing any adequate semantic representation (in principle, irrespective of vocabulary) and producing a final and optimized OSCAL representation. Using NISO STS saves our having to invent a &ldquo;bespoke&rdquo; interim vocabulary, or use HTML, for this purpose, while introducing rigor. So our pipeline has two main parts:

* Convert raw text into running NISO STS format (clean up, fix up, mapping)
* Convert NISO STS into OSCAL (refactoring)


And when we map it out in detail:

* Convert HTML into NISO STS
* Save (valid or invalid)
* Validate against STS schema (QA check)
* Convert STS into OSCAL
* Save (valid or invalid)
* Validate against OSCAL schema and rules (QA checks)
* Report all validation results


Thus we can expect our runtime to deliver three outputs:

* An XML file representing the document, nominally in NISO STS format
* An XML file representing the document, nominally in OSCAL format
* Validation results in the console: &ldquo;All clear&rdquo; or &ldquo;Uhoh, please check&rdquo; if validation errors were reported


Specific validation errors are not, however, reported, only the summary finding. To see validation errors, run the files with a validator or pipeline that reports them (see projects [oscal-validate project](../../../projects/oscal-validate/readme.md) [oscal](../../../projects/schema-field-tests/readme.md) ). Depending on the validation technology being used - XML Schema (XSD), RelaxNG, Schematron or other - this can be done in a variety of ways using commodity tools.

As Step One also shows, the end-to-end process is not only robust (providing its own QA checks), it is also traceable, replicable (on the same inputs) and adaptable (for similar inputs), as it captures and codifies what an analyst learns about the incoming data, making this knowledge accessible and reusable.

Having a valid NISO STS instance as a &ldquo;side effect&rdquo; of this process also means we are saved the work of mapping it back down from OSCAL into STS, if for any reason an STS version is wanted.

### feature: saving intermediate files conditionally

### feature: inline and out-of-line XSLT transformations

### feature: validations on the fly

As described, the pipeline also validates its outputs on the fly and reports summary findings for these processes. Summary findings are judged to be enough since the particular validation errors are not always actionable, while when they are, they are also easy to determine by other means. (Validate the file implicated using a different pipeline or tool.)

In this implementation, these checks are provided fail-safes in case a user has failed to run pipelines to acquire schemas required for validation. Missing one of these resources results not in an error or process failure, but a warning that validation has not been performed.

Alternatively to downloading and securing these dependeny resource, a user always has the option of rewriting the pipeline to use a different resource or do something altogether different.

## Step 2.5: Inspect the STS version

This repository is devoted to OSCAL, but inasmuch as OSCAL comes in an XML format, it also plays well with other XML-based formats such as DITA, TEI or NISO STS (a member of the NISO JATS family). In this application, NISO STS or NISO BITS both offer credible alternatives for representing the document in machine-readable form. Moreover - what is most interesting and important - such an encoding (we have chosen STS as it is used elsewhere in our agency) is somewhat easier to produce than OSCAL. This is because OSCAL, while very flexible in some respects, provides rigor in other respects especially with regard to document structures: it demands and rewards regularity, not structural variation, among its parts. Field Manual 6-22 Chapter 4 is interesting in that it presents such regularity, but only implicitly by way of formatting conventions. STS can represent these conventional forms as given, without refactoring.

This difference is easily appreciated by comparing the two variants.

To display an STS document in a browser for reference or proofreading, an STS application such as the [NIST/ITL/CSD STS Viewer](https://pages.nist.gov/xslt-blender/sts-viewer/) can be useful.

## Step three: break and repair

## Step four: research XSLT
