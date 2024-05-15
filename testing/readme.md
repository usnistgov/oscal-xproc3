# Repository testing

While projects in this repository should all provide for their own testing, XProc and other formats in use also benefit from repository-wide testing, for example Schematron testing to ensure fitness of XProc pipelines and XSpec test files, according to repository (not only project) requirements.

The [House Rules](../house-rules.md) include and imply a number of constraints that can usefully be applied to any of the resources posted. Since XSLT, XProc, and XSpec are both expressed in XML format, this makes them amenable to testing using the same tool set as we use to test other (XML-based) processes and results.

Apply the House Rules to any XProc in your editor, IDE or Schematron processor of choice, or use the pipelines to validate sets of XProcs.

One pipeline here will validate all XProcs found in the repository (outside `/lib`), acquired by producing a file listing using `x:directory`.

Two more will validate a set of files enumerated in a fourth pipeline, which exists for the sole purpose of collecting these files for processing.

Of these two, the difference is that one collects and presents and aggregated list of its findings, while the other "fails hard", delivering any Schematron validation error as an error as soon as it finds one.

This is useful for CI/CD, while the aggregating batcher BATCH-XPROC3-HOUSE-RULES.xpl is more graceful for interactive runtime:

```
> ../xp3.sh BATCH-XPROC3-HOUSE-RULES.xpl
```

writing a plaintext report to the console.

## Pipelines (summary)

- [TEST-XPROC-SET.xpl](TEST-XPROC-SET.xpl) lists XProc files to be tested
- [BATCH-XPROC3-HOUSE-RULES.xpl](BATCH-XPROC3-HOUSE-RULES.xpl) runs the House Rules Schematron on those files, producing an aggregated report
- [HARDFAIL-XPROC3-HOUSE-RULES.xpl](HARDFAIL-XPROC3-HOUSE-RULES.xpl) does the same, except failing on error (useful for CI/CD)
- [REPO-XPROC3-HOUSE-RULES.xpl](REPO-XPROC3-HOUSE-RULES.xpl) produces an aggregated report, but from all XProcs not just those listed in `TEST-XPROC-SET.xpl`

## CI/CD

CI/CD (continuous integration and development) is supported via [Github Actions](../.github/workflows/test.yml). Consult the setup to see what tests you can expect to see running.

Our aim is to support comprehensive testing interactively and under CI/CD, including Schematron, XSpec and other testing.

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

