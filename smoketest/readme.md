# Smoke testing XProc3

It is called a 'smoke test' by analogy to a piece of electronic circuitry, which should not emit smoke when connected to a power source correctly. A 'smoke test' might also be applied to a vacuum seal, quite literally, to test the seal - does smoke go through.

For XProc, the smoke we do not want to see would be tracebacks instead of meaningful results.

Since many processes are themselves tests, however, 'meaningful results' could include 'failures'. I.e., in context, a 'failure' may be a success.

For this and other reasons it is very useful to have a process that runs but does almost nothing. We say 'almost' because this smoke test (for example) exercises not only your XProc runtime but also your XSLT transformation runtime.

## Run a smoke test

`POWER-UP.xpl` is a self-contained XProc delivering outputs to the 'result' port on STDOUT.

It does not read data in, or write to the file system. If these capabilities are in doubt, edit the pipeline accordingly to test these features.

- Instead of an inline input document, use `<p:document href="yourfile.xml"/>`.
- Instead of or additionally to delivering the transformation result, try `<p:store/>` to test file writing.

The pipeline invokes XSLT `congratulations.xsl` to modify its input, thereby testing the Saxon installation and configuration.

TODO: XSpec this XSLT (good task for a beginner)

## Analyze and debug

If the smoke test doesn't work, what's up with that? Either

1. Your system doesn't meet requirements (e.g. missing Java)
1. The software is actually broken or miswired in a small or large way (despite working when we last tried it)
1. There is something wrong or missing in the configuration

Your approach will depend on your assessment of the relative probability of these.

To the extent no. 1 is possible, the task is clear: come back when it's fixed up.

If it turns out to be no. 2, please accept our thanks for your patience and perseverence. We encourage you to help make the problem disappear by [reaching out](https://github.com/usnistgov/oscal-xproc3/issues). (For those with no Github presence, try email to w e n d e l l (at) n i s t (dot) g o v.)

Approach the possibility of no. 3 by retracing your steps to narrow the possibilities further. If you can determine it is no. 2 after all, your notes will be useful.

When you make it work, congratulate yourself - this alone makes you Level 2 at least.

### Pro Tip - 

A deeper understanding of the problem starts with looking at the noise that comes back (traceback or error messages), that is whatever is telling you there is a problem. For an XProc process:

- If it's not XML
  - Either it's hard and ugly evidence of a deep problem - a lower-level traceback
  - Or it's something neat and clean by design, actually a sign things are working
  - You decide
- If it is XML
  - Good news! The pipeline is probably running, notwithstanding appearances
  - Maybe an error in the pipeline e.g. missing or unavailable resource
  - Maybe a processing error along the way e.g. an XSLT compile or runtime error
  - Namespaces on the XML can be very informative

TODO: maybe we want a Debugging XProc wiki page?

### Testing Java

Nothing will work if Morgana can't find Java.


If you can see a version number when you issue `java -version` in the console, you should be good.

### Morgana switches

Learn how Morgana uses ports and options in [its documentation](https://www.xml-project.com/manual/index.html).

As noted in the [top-level readme](../README.md), a convention of this repository is to name pipelines in ALL CAPITALS when they are hard-wired (such as `PIPELINE.xpl`), exposing no ports and no options, or no options not defaulted. Any of these can be operated as a simple call to the XProc engine with no arguments apart from the XProc (step definition) itself.

-----
