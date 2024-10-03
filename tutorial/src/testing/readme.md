# Tutorial production testing

Tutorial testing is mostly conducted by running the generation pipelines and checking results - not under automation.

This folder contains unit testing for some processes selected for their suitability as well as potential for reuse - the first of these is HTML -> Markdown conversion.

The XSpec test suite [xhtml-to-md.xspec](xhtml-to-md.xspec) does not yet test the Markdown conversion exhaustively. But its basic testing is enough to provide protection against breaking silently, while it is also extensible and useful for supporting ongoing development.

Note this XSpec *must pass* for the branch to be pulled into the repository, or removed from the list of XSpec files to be run under CI/CD at [../../../testing/FILESET_XSPEC.xpl](../../../testing/FILESET_XSPEC.xpl)

