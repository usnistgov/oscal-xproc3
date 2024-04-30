# TESTING validation-field-testing

The application is itself a testing framework, and in that sense it needs to be self-testing.

I.e. its own outputs validate its correctness, if necessary by comparison to other technology that does the same thing.

Morgana XProc III processor is tested against the [XProc 3.0 community-standard test suite](https://test-suite.xproc.org/) as documented (with test results) on [its home page](https://www.xml-project.com/morganaxproc-iiise.html).

Inasmuch as Morgana itself bundles lower-level components such as Xerces and Saxon, these might also be considered to be under test (and these components too have their own testing and verification).

## XSLT Testing

The pipelines are not complicated but they do rely on XSLT transformations to interpret results.

So far XSLT is fairly lightweight and can be tested adequately "under load", i.e. in the runtime.

TODO: XSpec testing for any of these components would be a useful contribution.

TODO: consider [XVRL](https://spec.xproc.org/master/head/xvrl/) as reporting language