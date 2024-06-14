# XSpec project

*Important* - this project

- Depends on successful installation of XSpec using the pipeline [../lib/GRAB-XSPEC.xpl](../lib/GRAB-XSPEC.xpl)
- Provides XSpec support under XProc 3.0
  - As demonstrated by test files here
  - But also usable throughout the repository
  
When working with this project take care, as pipelines defined here may be used to run XSpec in other project folders. Running `make test` from the top helps ensure nothing is broken by accident.

## Approach

- Minimal modifications of XSpec to apply it in this runtime 
- Reuse as much as possible
- Don't worry about advanced capabilities, basics are okay for now
- Ideally, test and demo each of
  - XSpec for XSLT
  - XSpec for Schematron
  - XSpec for XQuery

## Contents

- XProc 3.0 in the file system here provides XSpec evaluation in pipelines.

## Notes of interest

### Patching the compiler XSLT

XSpec works by transpiling an XSpec into an XSLT and then executing it. These XSLTs all work fine in their current form, apart from a small problem resulting from a bug (or lapse in specification) in Morgana, which drops results from `xsl:result-document` when no `@href` is given.

Accordingly, we provide a slight amendment to the XSLT produced by the compiler, before executing it.

See [xspec-execute.xpl](xspec-execute.xpl) for this code. The change is made dynamically in the pipeline, and produces the results needed.

### Seeing XSpec as XSpec

Because xspec files are typically not named `*.xml` they may not be recognized as XML by an XProc engine, for parsing. You will get an error for not knowing what to do with an octet stream.

To mitigate this, call the document in (`p:document` or `p:load`) with `content-type="application/xml"`.

(Passing the name on the command line is still a problem.)

## Punchlist

- Schematron
- XQuery

## For later

- XSpec comes with SchXSLT - should we consolidate?
  - At least note as a possible optimization
      
## Acknowledgements

Florent Georges is the author of the XProc 1.0 pipelines we are emulating in this project.

Other XSpec contributors have played important roles as well in bringing us this far.

---
