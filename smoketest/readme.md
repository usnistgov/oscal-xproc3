# Smoke testing XProc3

## Run a smoke test

`POWER-UP.xpl` is a self-contained XProc delivering outputs to the 'result' port on STDOUT.

It does not read data in, or write to the file system. If these capabilities are in doubt, edit the pipeline accordingly to test these features.

- Instead of an inline input document, use `<p:document href="yourfile.xml"/>`.
- Instead of or additionally to delivering the transformation result, try `<p:store/>` to test file writing.

The pipeline invokes XSLT `congratulations.xsl` to modify its input, thereby testing the Saxon installation and configuration.

TODO: XSpec this XSLT (good task for a beginner)

## Analyze and debug

Other XProc files in this folder may be kept for purposes of analysis and debugging.

While the project aims to deliver a functioning runtime architecture using tools developed by the community, it also offers a testbed and proving ground for tools still being developed, or not yet.
