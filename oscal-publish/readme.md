# OSCAL Production Workflow

Goals:

- Demonstrate OSCAL formatting
    - web (HTML, Markdown)
    - PDF
- Demonstrate validation in a formatting workflow
- Demonstrate 'enhancement-based' XSLT maintenance
  - "all bugs are also enhancements"
  - enhancements can be demonstrated in a pipeline before integrating into upstream
- Demonstrate pipeline-based configurations
  - runtime options   

Need: more samples?

Pipelines

I. Core Accepts any OSCAL catalog and formats it

Emitting an alarming WARNING message if not valid

Producing
   HTML
   Markdown
   PDF

II. Solo wrapper
  Produces HTML, Markdown or PDF for a single instance
  Writes it to the file system next to the input

III. Batch wrapper
  Calls solo wrapper for a batch
  Passes option through for result format(s)?
  
IV. Alternative XSLT shows XSLT customization layer

"Generic" OSCAL?

- Validating OSCAL XML
- Converting JSON into XML and validating?
- Producing HTML
- Producing Markdown
- Producing PDF

1. Download schema, XSLTs
1. Drop OSCAL in the hopper
1. Validate and convert OSCAL JSON?
1. Validate OSCAL XML
1. Convert OSCAL XML into outputs
  - singly
  - in batches
1. Scripts and runtimes for users
  - "Nullary" pipelines - no inputs - standalone
  - Unary pipeline - accept name of single input (file or folder name)
