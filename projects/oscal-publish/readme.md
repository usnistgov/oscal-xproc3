# OSCAL Production Workflow

Near-term goals:

- Demo a simple formatting application
- Show options for runtime validations and resource management

Stretch goals:

- Demonstrate OSCAL formatting
    - web (HTML, Markdown)
    - PDF
- Demonstrate validation in a formatting workflow
- Demonstrate 'enhancement-based' XSLT maintenance
  - "All bugs are also enhancements"
  - Enhancements can be demonstrated in a pipeline before integrating into upstream
- Demonstrate pipeline-based configurations
  - runtime options   

## OSCAL publishing pipeline

The pipeline [publish-oscal-catalog.xpl](publish-oscal-catalog.xpl) shows work in progress towards formatted production of OSCAL.

## Setup and Operation

Pipelines in the [setup/](setup/) directory provide for setup. Run these (standalone) to copy files onto the local system.

The XSLT library is required for operation of the "publishing" production pipeline. The OSCAL Catalog schema is optional, as the same resource can be acquired by a live `http` reference (assuming connectivity, etc.).

To operate:

Either use the `publish-oscal-catalog.xpl` pipeline directly (in a script or on the command line), binding its input `source` port to your OSCAL Catalog

Or, write a wrapper XProc that imports the publishing XProc and applies it to a document collection you define.

## Current status

The utility pipeline [publish-oscal-catalog.xpl](publish-oscal-catalog.xpl) will provide rendering capabilities for OSCAL catalogs. At present it produces HTML only.

For now

  - Works well to produce HTML (web pages) for those able to work directly with XSLT
    - Mainly because it is likely to require customization and tuning
    - By default, this writes an HTML next to its XML input. Whether/where to serialize is configurable.
  - Can serve as a useful working example
  - Makes a good testbed for front-end developers learning XSLT
    - Could benefit from better unit testing (XSpec)
  - Producing PDF is technically feasible but not yet possible with free-to-use open-source tooling

## Details

On the [publish-oscal-catalog.xpl](publish-oscal-catalog.xpl) pipeline, a source catalog file can be provided on the `source` port; for demonstration the pipeline is provided with an OSCAL catalog file as fallback.

In the pipeline, the file provided is validated against a copy of the OSCAL Catalog schema (stored locally or remotely), with a warning if input fails the validation. An HTML file result is then produced, in all cases. The warning if emitted thus gives the user an additional hint, when the results defective as they typically will be, with schema-invalid inputs.

If you receive an error trying to retrieve the schema, its location can be adjusted in the pipeline. A setup pipeline can be used to acquire a local copy.

## To do

(Help wanted! let us know)

**Schematron** - this XSLT provides a nice illustration of how nicely Schematron can provide for 'pre-checks' against publication anomalies.

For example, the HTML rendering XSLT has no fallback logic for rendering controls that have no 'label' properties, but nothing requires those in the schema or constraints, either.

An XSLT alteration in an importing layer could repair this, but a Schematron can also warn about it this issue up front.

**XSLT alterations** We could make those XSLT improvements here. We could also demonstrate other improvements in a customization layer.

**XSpec** - this XSLT has no XSpec: wouldn't that be good?

**Enhanced HTML** An alternative ["NIST Emulator" XSLT](lib/xslt/publish/nist-emulation/sp800-53A-catalog_html.xsl), makes a more highly polished HTML view, closer to a print page view.

**Simpler HTML** Another XSLT (not yet written) could make a 'plain page' optimized to show everything legibly.

**PDF production** Given a license to MorganaXProc-IIIee, or a capable XProc 3.0 processor with support for `xsl-formatter`, we can try the FO-based production offered in the XSLT repository.

(For now, in the [home repository](https://github.com/usnistgov/oscal-xslt) you can find a runtime using Maven and XProc 1.0.)

**Markdown dump** If you need the data in Markdown, it can be readily produced from HTML using an HTML-to-Markdown filter, devised or borrowed.

**More samples** Especially other forms of OSCAL.

**Demonstrate batching** With more samples come more ways to combine files in runtimes.


---
started 20240706
