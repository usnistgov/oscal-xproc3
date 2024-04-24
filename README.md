# OSCAL-XProc3

[OSCAL](oscal) on an [XProc 3.0](xproc) platform

This project is developed with an interest in FAIR principles -- **F**indable, **A**ccessible, **I**nteroperable and **R**eusable. See the [FAIR Software](fair-software.md) page for guiding principles.

TODO: Make up an XSpec for XSLT smoketest/congratulations.xsl

TODO: Register this software in MIDAS and any other public listings or search portals

TODO: Anything else to make the project more FAIR

## Software description

Miscellaneous software for processing OSCAL, on a platform-independent, open-source XML platform.

This repository serves as a platform for demonstration and development of capabilities in information and data processing in support of [OSCAL, the Open Security Controls and Assessment Language](oscal), using W3C-standard [XProc 3.0](xproc) technology.

This may include either OSCAL applications, or applications built to be used in OSCAL development. See below and project (folder) readme files for more details.

### Organization

The `lib` folder contents are excluded from git, and used to save third-party libraries. The `lib` library is populated by the installation script and should ordinarily be hands off.

Each project is kept in its own folder, next to the `lib` folder. In that folder, the project will have its own README.md. While projects may rely on the shared libraries, each one is considered to be discrete and independent from others unless otherwise noted.

### Background and project goals

This project aims to make XML-based processing using commodity (open-source) tools more broadly available to users and developers of OSCAL.

Many many subordinate goals include:

  - Supporting OSCAL activities such as schema development
  - Supporting XProc 3.0 and related initiatives  

[XProc 3.0](xproc) is an XDM-based (XML Data Model) information processing and pipelining stack published and supported by its development community. The application space it addresses - the configuration, management and execution of complex, composable information processing *pipelines* - is most commonly addressed using painful methods including carefully engineered and customized build utilities (including Apache Ant or GNU `make`), scripts (`bash` and other), execution environments (web processing stacks) and proprietary solutions -- almost universally platform-dependent. As a standard supporting a common semantics across implementations -- itself proof-tested by a history of earlier work -- XProc 3.0 promises greater adaptability, accessibility, scalability and power.

[XProc 1.0](xproc1) was published as a [W3C Recommendation](http://www.w3.org/2005/10/Process-20051014/tr.html#rec-publication) in 2010. In addition to integrating the latest XSLT and XQuery technologies such as [XSLT 3.0](xslt3), XProc 3.0 represents a significant advance over XProc 1.0:

- More streamlined and easier to learn and use
- Capable of processing and delivering any data notation, not only XML, including both JSON and plain-text-based formats (e.g. CSV, TSV etc.)

Both of these are important for OSCAL, which comes as both XML and JSON and whose users vary from the highly technical, to the bare beginner (in XML, OSCAL or both).

### Currently planned projects

Projects currently planned for deployment in this repository include:

  - `schema-field-test` OSCAL validation validation test harness - does an OSCAL schema test what you think it tests?
  - `batch-validate` validate OSCAL in batches against schemas or schema emulators
  - `data-convert` - convert OSCAL XML into JSON and OSCAL JSON into XML
  - `display-render` - convert OSCAL catalogs (including resolved profiles) into HTML and PDF

TODO: update this list

Applications in this repository may occasionally have general use outside OSCAL; users who find any of its capabilities should be generalized and published separately please [create a Github Issue](repo-issues).

## Software maturity

The software in this repository is at varying levels of maturity. Many stylesheets are fairly mature, having been developed in other contexts and proven its usefulness there. Yet work here also includes work on job configuration (XProc itself) and on testing, which is to say on tools to determine reliability and (by implication) maturity. These may be experimental, not mature.

At the same time, the development model for individual initiatives and the site as a whole is an incremental one. Things left as good-enough-for-now are regarded as being good enough, until experience shows us it is no longer so.

Assume the worst, hope for the best, and test.

Cloning the site is very much encouraged, as is participation in testing and development activities.

## Where to start

### OSCAL developers

OSCAL developers may wish to use software on this site as a 'black box', without interest in its internals except insofar as they may be subject to assessment (not reverse engineering).

After following the installation instructions to download and test the core libraries, choose the application you are interested in, and start there.

### XML/XSLT/XProc developers

Software developers using and learning XProc 3.0 and the XDM stack (XML/XSLT/XQuery) may wish to open the box and see how the internals work.

Again, after installation and testing, you can start anywhere -- you have already started.

## Installation instructions

*Platform requirements*: Java, plus a `bash` shell.

Developed on Windows and tested with WSL and Git bash.

Optionally, Windows users can use a 'batch file' command interface, with drag-and-drop functionality in the GUI. (Go ahead, try dragging an icon for an XPL file onto the icon for `xp3.bat`. For extra fun, change its icon under File/Properties.) 

Install the libraries by running the script:

```
> ./morgana-setup.sh
```

## Does it work?

To test your Java installation from the command line:

```
> java -version
```


You should see a nice message with your Java version, not an error or traceback.

TODO - tip for anyone with no Java?

To test your Morgana setup and installation, try the [Smoke test application](smoketest):

```
> ./xp3.sh smoketest/POWERUP.xpl
```

or (Windows users)


```
> .\xp3 smoketest\POWERUP.xpl
```

Again you should see fine-looking results, this time in XML.

*FEAR NOT THE ANGLE BRACKET!*

## Running the software

If Morgana is installed with Saxon-HE you should be good to go running any pipeline.

For their data soruces, pipelines can either read from the Internet (when connected and authorized), from the local file system (more commonly) or from inputs provided at runtime using ports.

Likewise, when run they can either write outputs (into the local file system), or expose results on output ports, or both.

In this repository (not its submodules) we follow a convention that an XProc with no exposed ports (neither output ports to bind, and no input ports to provide for) is named with ALL CAPITALS. Such pipelines can be run with no arguments and no prior knowledge of their inputs and outputs, since these are all contained in the XProc itself. They are also deterministic, in the sense that hard-wiring them also makes it easy to see, under simple inspection, where they read and write. Such a pipeline will ordinarily result in outputs to STDOUT (if only status messages) unless configured otherwise at runtime -- but they may and commonly will *also write to the file system*.

A well-designed pipeline will alert its user as to these activities, effects and state changes, using comments in the code, runtime messaging, and logs as appropriate.

Other XProc pipelines represent either subpipelines, or specialized processing with ports exposed for special purposes, to be called with arguments or parameters as documented.

Any XProc3 pipeline can be executed using the script `xp3.sh` (`bash`) or `xp3.bat` (Windows CMD). For example:

> ./xp3.sh LAUNCH.xpl

Will initiate an XProc 3 step (pipeline) defined in the file `LAUNCH.xpl`.

TODO: indicate which pipeline to use first

## Contact information

This project is being maintained by Wendell Piez, w e n d e l l (dot) p i e z (at) n i s t (dot) g o v) of the National Institute of Standards and Technology, Information Technology Laboratory, Computer Security Division (NIST/ITL/CSD 773.03).

Please [create a Github Issue](repo-issues) or [join an OSCAL forum]() to pursue discussion on this repository. In support of this project, email to the principal investigator is also welcome.

## Related Material

### **OSCAL**, the Open Controls and Assessment Language

- [OSCAL web site](oscal)
- [OSCAL model reference site](oscal-reference)
- [OSCAL Github code repository](oscal-repo)

More sites and repositories are devoted to OSCAL and OSCAL tools, but these are the references to start with.

### XProc 3.0

Again these are only a foothold and starting place -

- [XProc community page](xproc)
- [XProc 3.0 specifications](xproc-specs)

## How to cite

Piez, Wendell (2024), OSCAL-XProc3, US National Institute of Standards and Technology (NIST), https://github.com/usnistgov/oscal-xslt3.

TODO: secure a DOI (register in MIDAS)

## Included software and licenses

The code in this repository is all declarative, and depends on lower-level processors provided in libraries.

Currently these dependencies are:

- Morgana XProc III SE, by Achim Berndzen
- Saxon 12.3, from Saxonica

Both require Java, as detailed on their support pages.

See [THIRD_PARTY_LICENSES.md](THIRD_PARTY_LICENSES.md) for more.

XProc 3.0 aims to be platform- and application-independent, so one use of this project could be to test and assess portability across environments supporting XProc. 

[repo-issues]: https://github.com/usnistgov/oscal-xproc3/issues
[metaschema]: https://pages.nist.gov/metaschema
[metaschema-repo]: https://github.com/usnistgov/metaschema
[metaschema-java]: https://github.com/usnistgov/metaschema-java
[metaschema-xslt]: https://github.com/usnistgov/metaschema-xslt
[oscal]: https://pages.nist.gov/OSCAL
[oscal-reference]: https://pages.nist.gov/OSCAL-Reference
[oscal-repo]: https://github.com/usnistgov/OSCAL
[oscal-xslt]: https://github.com/usnistgov/oscal-xslt
[oscal-cli]: https://github.com/usnistgov/oscal-cli
[xslt3-functions]: https://github.com/usnistgov/xslt3-functions

[xproc]: https://xproc.org/
[xproc-specs]: https://xproc.org/specifications.html
[xproc1]: https://xproc.org/
[xproc1-site]: https://archive.xproc.org/

---

This README was composed using the [NIST Open Source Repository template as of April 24, 2024](https://github.com/usnistgov/opensource-repo/blob/095af7e/README.md).

---


