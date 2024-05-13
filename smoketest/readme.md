# Smoke testing XProc 3.0

It is called a 'smoke test' by analogy to a piece of electronic circuitry, which should not emit smoke when connected to a power source correctly. A 'smoke test' might also be applied to a vacuum seal, quite literally, to test the seal - does smoke go through.

For XProc, the smoke we do not want to see would be tracebacks instead of meaningful results.

Since many processes are themselves tests, however, 'meaningful results' could include 'failures'. I.e., in context, a 'failure' may be a success.

To help tell the difference, and other reasons, it is very useful to have a process that runs but does almost nothing. 'Almost' because these smoke tests work not only for your XProc runtime but also for components it needs, supporting XSLT and Schematron, by doing nothing but ask the XSLT and Schematron processors to run (and do nothing). Because they do nothing, the only way things can go wrong is if things are already wrong in the setup.

The "do nothing" [XSLT](congratulations.xsl) and [Schematron](./doing-well.sch) are of course available for inspection.

An easy debugging step if you ever suspect misconfiguration of these tools is to run one or all these tests.

## Run a smoke test

`POWER-UP.xpl` is a self-contained XProc delivering outputs to the 'result' port on STDOUT.

It does not read data in, or write to the file system. If these capabilities are in doubt, edit the pipeline to test these features.

- Instead of an inline input document, use `<p:document href="yourfile.xml"/>` (with an XML file of that name in place).
- Instead of or additionally to delivering the transformation result, try `<p:store/>` to test file writing.

The folder additionally contains smoke test pipelines, useful for testing third-party components of the XProc runtime, namely Saxonica and SchXSLT:

- Test Saxon for the XSLT capability using [SMOKETEST-XSLT](SMOKETEST-XSLT.xpl)
- Test SchXSLT for the Schematron capability using [SMOKETEST-SCHEMATRON](SMOKETEST-SCHEMATRON.xpl)

## Analyze and debug

If the smoke test doesn't work, what's up with that? Either

1. Your system doesn't meet requirements (e.g. missing Java)
1. The software is actually broken or miswired in a small or large way (despite working when we last tried it)
1. There is something wrong or missing in the configuration

Your approach will depend on your assessment of the relative probability of these.

To the extent no. 1 is possible, the task is clear: come back when it's fixed up.

If it turns out to be no. 2, please accept our thanks for your patience and perseverence. We encourage you to help make the problem disappear by [reaching out](https://github.com/usnistgov/oscal-xproc3/issues). (For those with no Github presence, try email to w e n d e l l (at) n i s t (dot) g o v.)

Approach the possibility of no. 3 by retracing your steps to narrow the possibilities further. If you can determine it is no. 2 after all, your notes will be useful.

When you make it work, congratulate yourself on the Experience Points you are acquiring.

### Testing Java

Nothing will work if Morgana can't find Java. Check your version using `java -version` in the console.

MorganaXProc-IIIse requires Java version 8.0 and 11 (and later).

-----
