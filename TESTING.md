# TESTING oscal-xproc3

TODO: CI/CD setup - Schematron; XSpec - xslt3-functions submodule

TODO: PR page with TODO

## Libraries

The underlying processors, [Morgana XProc IIIse](https://www.xml-project.com/morganaxproc-iiise.html) and [Saxon](https://www.saxonica.com/welcome/welcome.xml), are tested by their developers and user communities, as well as by this project.

XProc conformance testing is [documented for Morgana on its site](https://test-suite.xproc.org/implementation.html), using the [public XProc 3.0 test suite](https://test-suite.xproc.org/).

XML Calabash also [publishes its test results](https://xmlcalabash.com/test-report/current/) against the public test suite as well as its own.

## Testing the runtime

Java is a requirement. For setup instructions, see the [README.md](README.md), the [more detailed setup notes](setup-notes.md), or try the bash script, `./setup.sh`.

Test the operation of an XProc3 pipeline with the [Smoke test](smoketest/TEST-XPROC3.xpl) pipeline. You should see no figurative smoke:

```
> ./xp3.sh XPROC3-SMOKETEST.xpl
```

Windows users with no `bash` can use the `xp3.bat` utility instead.

### Assorted smoke tests

In addition to [smoketest/TEST-XPROC3.xpl](smoketest/TEST-XPROC3.xpl)

[smoketest/TEST-XSLT.xpl](smoketest/TEST-XSLT.xpl) tests XSLT transformations (requires Saxon installation)

[smoketest/TEST-SCHEMATRON.xpl](smoketest/TEST-SCHEMATRON.xpl) tests Schematron validation (requires Saxon and SchXSLT installation) - returning SVRL code.

Beginning developers might take the time to inspect and edit this smoke test and the Schematron it uses, as it can show the different behaviors when (a) the document is valid or invalid to the Schematron (as written, all documents are always valid), or (b) the pipeline is set to *require* validity or not (`assert-valid='true'`).

TL/DR is that Schematron errors appear in the main `result` port only when the document is required to be valid, *and* Schematron messages (of any kind) are delivered. A `report` output port is available making Schematron results (and runtime metadata) visible in all cases.

## The applications

Each application will provide its own testing, as described in available README and TESTING documentation.

Additionally, applications that are (for example) testing frameworks, also need to be "self-testing" insofar as their own outputs validate their correctness.

### Testing XSLT with unit tests

We aim to support XSpec for XSLT unit tests and very much encourage deployment of XSpecs. They are good not only for testing but also to help elucidate what an XSLT does and how it works.

The best way to assess how far we have advanced with this is to examine the file system and CI/CD configuration.

### House rules: code format

No house rules have been defined or codified yet for XProc, XSLT, XSpec or other formats, but [a Schematron](testing/xproc3-house-rules.sch) is underway to help XProc authors write flawless XProc for this repo. See the [testing](./testing) folder. As documented inline, it enforces a couple of guidelines at WARNING level as well as providing error detection.

In time there may be Schematrons or other tests for XSpecs and other work.

## Testing under CI/CD

See the [GitHub Actions configuration](.github/workflows/test.yml) to see which pipelines including testing pipelines are run.

Some unit tests are now run under CI/CD, but minimally.

Files to be tested using Schematron or XSpec executable are listed in the FILESET pipelines:

- [XProc 'house rules' Schematron](testing/FILESET_XPROC3_HOUSE-RULES.xpl)
- [XSpec unit testing for XSLT or Schematron](testing/FILESET_XSPEC.xpl)

Candidate tests include the smoke test and XSpec unit tests just described. The smoke test itself need not be run under CI/CD - until we start running XSpec or other automation under XProc 3.
