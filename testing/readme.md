# Repository testing

While projects in this repository should all provide for their own testing, XProc and other formats in use also benefit from repository-wide testing, for example Schematron testing to ensure fitness of XProc pipelines and XSpec test files, according to repository (not only project) requirements.

The [House Rules](../house-rules.md) include and imply a number of constraints that can usefully be applied to any of the resources posted. Since XSLT, XProc, and XSpec are both expressed in XML format, this makes them amenable to testing using the same tool set as we use to test other (XML-based) processes and results.

Apply the House Rules to any XProc in your editor, IDE or Schematron processor of choice, or use the pipelines to validate sets of XProcs.

One pipeline here will validate all XProcs found in the other project.

Two more will validate a set of files enumerated in a fourth pipeline, which exists for the sole purpose of collecting these files for processing.

Of these two, the difference is that one collects and presents and aggregated list of its findings, while the other "fails hard", delivering any Schematron validation error as an error as soon as it finds one.

This is useful for CI/CD, while the aggregating batcher BATCH-XPROC3-HOUSE-RULES.xpl is more graceful for interactive runtime:

```
> ../xp3.sh BATCH-XPROC3-HOUSE-RULES.xpl
```

writing a plaintext report to the console.

## Pipelines in this folder:

[REPO-XPROC3-HOUSE-RULES.xpl](REPO-XPROC3-HOUSE-RULES.xpl) - applies the House Rules Schematron to all XProc files in the repository (outside the top-level `lib` directory), polling the system to acquire them based on file suffix.

[BATCH-XPROC3-HOUSE-RULES.xpl](BATCH-XPROC3-HOUSE-RULES.xpl) - applies the House Rules Schematron to a set of XProc files called in from the subpipeline `TEST-XPROC-SET.xpl`. 

[HARDFAIL-XPROC3-HOUSE-RULES.xpl](HARDFAIL-XPROC3-HOUSE-RULES.xpl) - same as BATCH-XPROC3-HOUSE-RULES.xpl, except this pipeline FAILS HARD if any files are found to be invalid - which includes messages of any kind or stated level from Schematron (whether `assert` or `report` or what the nominal warning level). Since it fails if documents are out of expected order, this version is useful under CI/CD or other 'brittle' process workflows.

This pipeline also uses the subpipeline to acquire its list of XProc files.

[TEST-XPROC-SET.xpl](TEST-XPROC-SET.xpl) - acquires the files for the two XProc pipelines last mentioned (but not `REPO-XPROC3-HOUSE-RULES.xpl`).

## Schematron in this folder:

[xproc3-house-rules.sch](xproc3-house-rules.sch) - Schematron to validate House Rules on XProc pipelines.

See this file to determine what the house rules are. They include things like

- The assigned `@name` of the XProc must correspond to the file name
- Same with the assigned `@type`, and this time in a specific namespace
- Messages must be provided with certain steps (`p:load`, `p:store`)
- Messages must be prepended with the pipeline's `@name`

The same Schematron is easy and fun to use in a tool that supports Schematron QuickFix (such as oXygen XML Editor).

Naturally the application of all these rules can be altered by editing the Schematron.

Depending on requirements and demand, similar rules can be enforced for XSLT and XSpec.

---

