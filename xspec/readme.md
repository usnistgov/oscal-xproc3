# XSpec project

*Important* - this project

- Depends on successful installation of XSpec using the pipeline [../lib/GRAB-XSPEC.xpl](../lib/GRAB-XSPEC.xpl)
- Provides XSpec support under XProc 3.0
  - As demonstrated by test files here
  - But also usable throughout the repository
  
When working with this project take care, as pipelines defined here may be used to run XSpec in other project folders.

Running the [XSpec smoke test](../smoketest/SMOKETEST-XSPEC.xpl) at regular intervals is a good idea to ensure the process continues to function.

## Approach

A minimalistic effort has been made to get this working even if not tested exhaustively. Having basic functionality is too important and any lapses we discover we can address going forward.

Likewise, the strategy has been to reuse any available code where possible - only the barest *new* code is provided.

Similarly, where edits to source (upstream) code repos including the XSpec repo might have been made, instead we provide *live patches under XProc* to pipeline steps (XSLTs) that require modification.

These encoded patches thus encapsulate the revision to be made in upstream XSLT when that becomes convenient (potentially as a submission to XSpec).

## Notes of interest

### Patching the compiler XSLT

XSpec works by transpiling an XSpec into an XSLT and then executing it. These XSLTs all work correctly in their current form, apart from a small problem resulting from a bug (or lapse in specification) in Morgana, which drops results from `xsl:result-document` when no `@href` is given.

As noted above, we repair this in the XProc pipeline with a slight amendment (patch) to the XSLT produced by the compiler, before executing it.

See [xspec-execute.xpl](xspec-execute.xpl) for this code. The change is made dynamically in the pipeline, and produces the results we need.

### Schematron XSpec

This is the first implementation of XSpec for Schematron that we have seen under XProc 3.0. Like the XSLT XSpec, Schematron XSpec as supported by the downloaded packages work with only a few adjustments.

Notes on the Schematron XSpec implementation are [here](schematron-xspec.md).

Note that we do *not* currently expect this runtime to work with all Schematrons!

### Seeing XSpec as XSpec

Because xspec files are typically not named `*.xml` they may not be recognized as XML by an XProc engine, for parsing. You will get an error for not knowing what to do with an octet stream.

To mitigate this, call the document in (`p:document` or `p:load`) with `content-type="application/xml"`.

(Passing the name on the command line is still a problem.)
      
## Acknowledgements

Florent Georges is the author of the XProc 1.0 pipelines we are emulating in this project; he along with other XSpec developers deserve thanks for their pioneering work.

---
