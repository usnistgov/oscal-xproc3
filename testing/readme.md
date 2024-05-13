# Repository testing

While projects in this repository should all provide for their own testing, XProc and other formats in use also benefit from repository-wide testing, for example Schematron testing to ensure fitness of XProc pipelines and XSpec test files, according to repository (not only project) requirements.

The [House Rules](../house-rules.md) include and imply a number of constraints that can usefully be applied to any of the resources posted. Since XSLT, XProc, and XSpec are both expressed in XML format, this makes them amenable to testing using the same tool set as we use to test other (XML-based) processes and results.

## Pipelines in this folder:

[REPO-XPROC3-HOUSE-RULES.xpl](REPO-XPROC3-HOUSE-RULES.xpl) - applies the House Rules Schematron to all XProc files in the repository (outside the top-level `lib` directory)

[BATCH-XPROC3-HOUSE-RULES.xpl](BATCH-XPROC3-HOUSE-RULES.xpl) - applies the House Rules Schematron to a set of XProc files enumerated in the pipeline step. Edit the file or call it with overriding bindings on the `xproc-files` input port.

[HARDFAIL-XPROC3-HOUSE-RULES.xpl](HARDFAIL-XPROC3-HOUSE-RULES.xpl) - same as BATCH-XPROC3-HOUSE-RULES.xpl, except this pipeline FAILS HARD if any files are found to be invalid - which includes messages of any kind or stated level from Schematron (whether `assert` or `report` or what the nominal warning level). Since it fails if documents are out of expected order, this version is useful under CI/CD or other 'brittle' process workflows.

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

