# OSCAL XProc doc

In this folder, find pipelines to produce

- A directory listing standard and community XProc steps, with code snippets
- A digest of XProc resources and their resource usage (references) in this repository

## Pull a directory to XProc in XML

Run pipeline `COLLECT-XPROC-STEPS.xpl` to produce a list of XProc steps compiled by querying the specification documents on line.

It writes the file `out/xproc-steps.xml` to the system.

## Produce a pretty directory in HTML

Running the pipeline `XPROC-STEP-INDEX-HTML.xpl` reads the XML produced by `COLLECT-XPROC-STEPS` and creates an HTML page, showing an <q>analytic directory</q> to steps defined for the standard, with links to the online XProc Specification documents.

It includes both the standard, required steps, and the steps defined as community specs, i.e. optional for implementors, but defined in common. Additional information may also be provided (run it and see) such as whether the feature is (known to be) available in Morgana.

## Produce a "view" of XProc in the repository

Running `REPOSITORY-STEP-INDEX-HTML.xpl` polls the file system (the repository starting from this project's parent folder) and produces a digested view of its pipelines.

This summary view can be useful to the developer as it exposes both points of control (input and output ports and bindings for all steps) and system dependencies such as local or network-based file references.

It does, however, also represent a design problem. There is much unexplored potential here.

## Next up

A functional notation for XProc?

Index to XProc elements used in the repo? Index to attributes by name and value?

XProc Englishing?

---
started 20240710


