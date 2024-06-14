# XSpec project

*Important* - this project

- Depends on successful installation of XSpec using the pipeline [../lib/GRAB-XSPEC.xpl](../lib/GRAB-XSPEC.xpl)
- Provides XSpec support under XProc 3.0
  - As demonstrated by test files here
  - But also usable throughout the repository
  
When working with this project take care, as pipelines defined here may be used across the repository.

## Approach

- Minimal modifications of XSpec to apply it in this runtime 
- Reuse as much as possible
- Don't worry about advanced capabilities, basics are okay for now
- Ideally, test and demo each of
  - XSpec for XSLT
  - XSpec for Schematron
  - XSpec for XQuery

## Contents

- XProc 3.0 in the file system here mirrors XProc giving with XSpec

## Punchlist

- Analyze, trace and rebuild  XProc runtime for XSpec
  - The directory [xspec-dev](xspec-dev) in this project folder is at the same level as the local copy of the XSpec distribution saved out by [../lib/GRAB-XSPEC.xpl](../lib/GRAB-XSPEC.xpl)
  - Accordingly, its XProc 1.0 can simply be mirrored and updated (Famous Last Words)

- Illustrate with some XSpecs in action
  - runtime messages
  - HTML report
  - JUnit report
  - In batches

- Cover XSLT, Schematron, XQuery

## For later

- XSpec comes with SchXSLT - should we consolidate?
  - At least note as a possible optimization

      
## Acknowledgements

Florent Georges is the author of the XProc 1.0 pipelines we seek to re-engineer in this project.

Other XSpec contributors have played roles as well in bringing us this far.
---
