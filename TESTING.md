# TESTING oscal-xproc3

TODO: Make up an XSpec for XSLT smoketest/congratulations.xsl

TODO: CI/CD setup - Schematron; XSpec

TODO: PR page with TODO

## Libraries

The underlying processors, [Morgana XProc IIIse](https://www.xml-project.com/morganaxproc-iiise.html) and [Saxon](https://www.saxonica.com/welcome/welcome.xml), are tested by their developers and user communities, as well as by this project.

XProc conformance testing is [documented for Morgana on its site](https://test-suite.xproc.org/implementation.html), using the [public XProc 3.0 test suite](https://test-suite.xproc.org/).

## Testing the runtime

Java is a requirement. For setup instructions, see the [README.md](README.md), the [more detailed setup notes](setup-notes.md), or try the bash script, `./setup.sh`.

Test the operation of an XProc3 pipeline with the [Smoke test](XPROC3-SMOKETEST.xpl) pipeline. You should see no figurative smoke:

```
> ./xp3.sh XPROC3-SMOKETEST.xpl
```

Windows users with no `bash` can use the `xp3.bat` utility instead.

## The applications

Each application will provide its own testing, as described in available README and TESTING documentation.

Additionally, applications that are (for example) testing frameworks, also need to be "self-testing" insofar as their own outputs validate their correctness.

### Testing XSLT with unit tests

We aim to support XSpec for XSLT unit tests and very much encourage deployment of XSpecs.

They are good not only for testing but also to help elucidate what an XSLT does and how it works.

Examing the file system and CI/CD configuration is the best way to assess how far we have advanced with this.

## Testing under CI/CD

Currently we run no tests under CI/CD but this is also due to change.

Candidate tests include the smoke test and XSpec unit tests just described. The smoke test itself need not be run under CI/CD - until we start running XSpec or other automation under XProc 3.

Additional ideas:

- Schematron the XSpecs for style/usage
  - confirm that @name and @type correspond to the file name   

